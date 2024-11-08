require 'date'

class Student
  @@students = []
  attr_accessor :surname, :name, :date_of_birth, :age

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth
    @age = calculate_age
  end

  def calculate_age
    birth_date = Date.parse(@date_of_birth)
    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date.next_year(age)
    raise ArgumentError, "Дата не вірна" if age < 0
    age
  end

  def self.add_student(surname, name, date_of_birth)
    student = Student.new(surname, name, date_of_birth)
    raise ArgumentError, "Студент вже є в списку" if @@students.any? { |s|
      s.surname == surname &&
        s.name == name &&
        s.date_of_birth == date_of_birth
    }
    @@students << student
    student
  end

  def self.remove_student(surname, name, date_of_birth)
    @@students.delete_if { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end

  # Перевизначений метод to_s для кращого виводу
  def to_s
    "#{@name} #{@surname} (Дата народження: #{@date_of_birth}, Вік: #{@age})"
  end
end
# Зразки використання класу
# Приклад використання класу
student1 = Student.add_student("Іваненко", "Іван", "2000-05-21")
student2 = Student.add_student("Петренко", "Олена", "1998-10-15")
student3 = Student.add_student("Чуліпа", "Вадим", "2004-04-18")
puts student1.to_s
puts student2.to_s
puts student3.to_s
# Вивід студентів 20 років
students_age_20 = Student.get_students_by_age(20)
puts "Студенти 20 років: #{students_age_20.map(&:to_s).join(", ")}"

# Вивід студентів з ім'ям Іван
students_named_ivan = Student.get_students_by_name("Іван")
puts "Студенти з ім'ям Іван: #{students_named_ivan.map(&:to_s).join(", ")}"

# Вивід всіх студентів
puts "Всі студенти: #{Student.all_students.map(&:to_s).join(", ")}"
