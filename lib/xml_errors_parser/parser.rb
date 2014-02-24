module XmlErrorsParser
  # This class receives the nokogiri errors and outputs human friendly errors
  class Parser
    attr_reader :errors

    def initialize errors
      @original_errors = errors
      @errors          = []

      parse_errors
    end

    private

    def parse_errors
      return if @original_errors.empty?

      @original_errors.each do |error|
        parse_error_msg error
      end
    end

    def parse_error_msg error
      @message  = error.message
      @code     = error.code
      error_msg = ErrorMessageBuilder.build_message_for(@code, tokens)
      @errors << error_msg
    end

    def tokens
      regex      = ErrorsRegex.find_expression_from_code(@code)
      match_data = regex.match(@message)
      process_match_data(match_data)
    end

    def process_match_data(match_data)
      result = {}
      match_data.names.each do |name|
        result[name.to_sym] = match_data[name]
      end
      result
    end
  end
end
