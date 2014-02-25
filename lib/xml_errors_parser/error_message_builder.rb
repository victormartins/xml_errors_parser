module XmlErrorsParser
  require 'i18n'
  I18n.reload!

  # This class will take the error code and the error tokens and translate them
  # to a classic I18n message
  class ErrorMessageBuilder

    # Gets a code and tokens and builds the error message
    def self.build_message_for code, tokens
      self.new(code, tokens).build
    end

    def initialize code, tokens
      @tokens = tokens
      @code   = code
    end

    # Build error message
    def build
      key = "xsd_errors.#{@code}"
      I18n.t(key, @tokens.merge(default: :'xsd_errors.unkown', error_code: @code))
    end

  end
end
