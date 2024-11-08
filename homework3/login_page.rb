require 'capybara/rspec'
require_relative 'spec_helper'
require 'rspec_html_reporter'

RSpec.configure do |config|
  config.add_formatter(RspecHtmlReporter::Reporter, 'report.html')
end

RSpec.describe 'Login Tests' do
  before(:each) do
    @driver = Capybara::Session.new(:selenium)
    @driver.visit 'https://www.saucedemo.com/'
  end

  it "Вхід з правильним логіном і паролем" do
    @driver.fill_in 'user-name', with: 'standard_user'
    @driver.fill_in 'password', with: 'secret_sauce'
    @driver.click_button('Login')

    expect(@driver).to have_selector('.inventory_list')
  end

  it "Вхід з неправильним паролем" do
    @driver.fill_in 'user-name', with: 'standard_user'
    @driver.fill_in 'password', with: 'wrong_password'
    @driver.click_button('Login')

    expect(@driver).to have_selector('.error-message-container', text: "Epic sadface: Username and password do not match any user in this service")
  end

  it "Вхід заблокованого користувача" do
    @driver.fill_in 'user-name', with: 'locked_out_user'
    @driver.fill_in 'password', with: 'secret_sauce'
    @driver.click_button('Login')

    expect(@driver).to have_selector('.error-message-container', text: "Epic sadface: Sorry, this user has been locked out.")
  end
end
