# Database cleaning hooks for Cucumber tests
require 'database_cleaner/active_record'

# Clean database before each scenario
Before do
  DatabaseCleaner.clean_with(:truncation)
end

# For JavaScript tests, use truncation strategy
Before('@javascript') do
  DatabaseCleaner.strategy = :truncation
end

# For non-JavaScript tests, use faster transaction strategy
Before('not @javascript') do
  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.start
end

After('not @javascript') do
  DatabaseCleaner.clean
end

# Ensure clean state for JavaScript tests
After('@javascript') do
  DatabaseCleaner.clean_with(:truncation)
end
