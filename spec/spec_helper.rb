require "bundler/setup"
require "antecedent"
require "active_record"
require "database_cleaner"
require "pry"

# AR models for testing
require_relative "../db/models/user.rb"
require_relative "../db/models/customer.rb"
require_relative "../db/models/user/admin.rb"

# Setup test database to be used for spec
def db_configuration
  db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_configuration_file))
end
ActiveRecord::Base.establish_connection(db_configuration["test"])

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Database cleaner setup
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
