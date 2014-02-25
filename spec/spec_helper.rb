require 'xml_errors_parser'
require 'pry'
require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  I18n.default_locale = :en
  I18n.enforce_available_locales = true
  I18n.load_path = [File.expand_path('../../config/locales/en.yml', __FILE__)]
end
