require 'rails_helper'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'capybara/poltergeist'
require 'database_cleaner'

RSpec.configure do |config|

  Capybara.javascript_driver = :poltergeist
  # Capybara.javascript_driver = :selenium


  Capybara.save_and_open_page_path = "/tmp/capybara"
  Capybara::Screenshot.autosave_on_failure = true


  config.after(:each) do
    if RSpec.current_example.exception
      screenshot_and_save_page
    end
  end
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


end
