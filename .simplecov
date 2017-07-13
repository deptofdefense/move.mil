require 'simplecov-console'

formatters = [SimpleCov::Formatter::HTMLFormatter]

if RSpec.configuration.files_to_run.length > 1
  formatters << SimpleCov::Formatter::Console
end

SimpleCov.start 'rails' do
  formatter SimpleCov::Formatter::MultiFormatter.new(formatters)
end
