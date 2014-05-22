module XmlErrorsParser
  # Module that aggregates the errors regular expressions
  module ErrorsRegex

    # Regular expressions for each error code
    ERRORS_REGEX = {
      '1840' => /(}(?<element>.*?)').*(value.'(?<value>.*)').is.not .*((?<set>{.*}))/,
      '1845' => /}(?<element>.*?)'/,
      '1868' => /(}(?<element>.*?)').*(attribute.'(?<attribute>.*)')/,
      '1839' => /(}(?<element>.*?)').*(value.'(?<value>.*)')\sis\snot*\saccepted\sby\sthe\spattern.(?<pattern>.*)/,
      '1824' => /(}(?<element>.*?)')\:\s\'(?<value>.*)\'.is.not.a.valid.value/
    }

    # Given a xsd error code returns the respective regular expression.
    # If the code is unkown, then returns a generic regex
    def self.find_expression_from_code error_code
      ERRORS_REGEX[error_code.to_s] || default_error_expression
    end

    private
    def self.default_error_expression
      /(?<error_msg>.*)/
    end
  end
end
