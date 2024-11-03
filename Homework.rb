require 'date'

class Student
  # Змінна класу для зберігання списку всіх унікальних студентів
  @@students = []

  attr_reader :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name

    # Перевірка дати народження
    if date_of_birth >= Date.today
      raise ArgumentError, "Дата народження має бути в минулому."
    end
    @date_of_birth = date_of_birth

    # Додаємо студента, якщо його ще немає
    add_student
  end

  def calculate_age
    """Обчислює вік студента на основі дати народження."""
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < Date.new(today.year, @date_of_birth.month, @date_of_birth.day)
    age
  end

  def add_student
    """Додає студента до списку @@students, якщо він ще не доданий."""
    unless @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
      @@students << self
    else
      puts "Студент #{@name} #{@surname} вже існує у списку."
    end
  end

  def self.remove_student(surname, name, date_of_birth)
    """Видаляє студента зі списку @@students, якщо він присутній."""
    student_to_remove = @@students.find { |student| student.surname == surname && student.name == name && student.date_of_birth == date_of_birth }
    if student_to_remove
      @@students.delete(student_to_remove)
      puts "Студент #{name} #{surname} видалений зі списку."
    else
      puts "Студент #{name} #{surname} не знайдений у списку."
    end
  end

  def self.get_students_by_age(age)
    """Повертає список студентів з вказаним віком."""
    today = Date.today
    @@students.select do |student|
      student_age = today.year - student.date_of_birth.year
      student_age -= 1 if today < Date.new(today.year, student.date_of_birth.month, student.date_of_birth.day)
      student_age == age
    end
  end

  def self.get_students_by_name(name)
    """Повертає список студентів з вказаним ім'ям."""
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    """Повертає список всіх студентів."""
    @@students
  end

  def to_s
    "#{@name} #{@surname} (Дата народження: #{@date_of_birth})"
  end
end

student1 = Student.new("Іваненко", "Іван", Date.new(2000, 5, 21))
student2 = Student.new("Петренко", "Олена", Date.new(1998, 10, 15))

age = student1.calculate_age
puts age  # Виведе поточний вік студента

Student.remove_student("Петренко", "Олена", Date.new(1998, 10, 15))

students_age_20 = Student.get_students_by_age(20)
students_named_ivan = Student.get_students_by_name("Іван")

puts Student.all_students  # Виведе список всіх унікальних студентів класу
