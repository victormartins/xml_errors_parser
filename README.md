# XmlErrorsParser
[![Gem Version](https://badge.fury.io/rb/xml_errors_parser.png)](http://badge.fury.io/rb/xml_errors_parser)
[![Dependency Status](https://gemnasium.com/victormartins/xml_errors_parser.png)](https://gemnasium.com/victormartins/xml_errors_parser)
[![Code Climate](https://codeclimate.com/github/victormartins/xml_errors_parser.png)](https://codeclimate.com/github/victormartins/xml_errors_parser)
[![xml_errors_parser API Documentation](https://www.omniref.com/ruby/gems/xml_errors_parser.png)](https://www.omniref.com/ruby/gems/xml_errors_parser)


  When validating XML using a XSD, we get error messages that are not very friendly, for example:

  `Element '{http://www.portalfiscal.inf.br/nfe}infNFe': The attribute 'Id' is required but missing.`

  What this gem does, is that it processes those errors and enable us to use the I18n gem to internationalize them.
  That way the client/customer can ask/see the error messages in any way they want.

## Installation

Add this line to your application's Gemfile:

    gem 'xml_errors_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xml_errors_parser

## Usage

### Parsing Errors
Imagine that in your application you are using nokogiri to validate the XML:

```ruby
    schema = Nokogiri::XML::Schema(xsd_string).xsd
    errors = schema.validate(some_xml) # this will return the original errors
```

Now we can parse them like this:

```ruby
    pretty_errors = XmlErrorsParser::Parser.new(errors).errors
```

```pretty_errors``` will be an array of errors that can be sent to the flash or to any html page to be presented.

### Adding new errors to the Gem
Not all errors are covered (there are many many possible errors). But the gem makes it pretty easy to add more cases.
Please contribute if you do some :)
If the Gem receives an error that it does not known, it will output a message with the error code and the original error
message. We can use this information to add new errors.

**To add more errors we do this:**

1. Edit the /spec/xml_errors_parser/errors_regex_spec.rb and add a new test. Use the code of the error on the
description. Then expect to find the tokens that the error provides. For example, the element name.

2. To make the test pass, edit the file `lib/xml_errors_parser/errors_regex.rb` so that the error code matches a
regular expression. Use regular expressions that return tokens, using the `?<token_name>`. Try this until the test passes.

3. Create a new test here: `spec/xml_errors_parser/error_message_builder_spec.rb`. These test makes sure that if the
tokens exist, the right message will be created. Just follow one of the examples.

4. To make the test pass just add the new error message in: `/config/locales/en.yml`

5. In the end **always** run `bundle exec fudge build` to validate the build before doing a pull request. This will check
specs, code coverage, documentation and code style.

```
en:
  xsd_errors:
    'unkown': '[%{error_code}] %{error_msg}.'
    '1840': 'The Element "%{element}" has the Value "%{value}" but it is not one from the Set: "%{set}".'
    '1845': 'The Element "%{element}" has no matching global declaration available for the validation root.'
    '1868': 'The Attribute "%{attribute}" of the Element "%{element}" is mandatory.'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run `bundle exec fudge build` to see if the build passes
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
