require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_help'


RSpec.describe 'Cart Test' do
  include Capybara::DSL

  before(:each) do
    @driver = Capybara::Session.new(:selenium)
    @driver.visit 'https://www.saucedemo.com/'
  end

  it "Повинні мати можливість додати 2 товари до кошика" do
    @driver.fill_in 'user-name', with: 'standard_user'
    @driver.fill_in 'password', with: 'secret_sauce'
    @driver.click_button('Login')

    @driver.click_button('add-to-cart-sauce-labs-backpack')
    @driver.click_button('add-to-cart-sauce-labs-onesie')


    # Перевірка кошика
    @driver.find('.shopping_cart_link').click
    elements = @driver.all('.cart_item')
    expect(elements.length).to eql(2)
  end
end
