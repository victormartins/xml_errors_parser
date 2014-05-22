require 'spec_helper'

describe XmlErrorsParser::ErrorMessageBuilder do
  describe 'message for code #1868' do
    it 'should work' do
      tokens = {
        element: 'Foo',
        attribute: 'Bar'
      }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == 'The Attribute "Bar" of the Element "Foo" is mandatory.'
    end
  end

  describe 'message for code #1840' do
    it 'should work' do
      tokens = {
        element: 'Foo',
        value: '5',
        set: "{'1','2','3'}"
      }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == "The Element \"Foo\" has the Value \"5\" but it is not one from the Set: \"{'1','2','3'}\"."
    end
  end

  describe 'message for code #1845' do
    it 'should work' do
      tokens = { element: 'XPTo' }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == 'The Element "XPTo" has no matching global declaration available for the validation root.'
    end
  end

  describe 'message for code #1839' do
    it 'should work' do
      tokens = {
        element: 'CNPJ',
        value: 'NAO INFORMADO',
        pattern: "'[0-9]{0}|[0-9]{14}'"
      }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == 'The Value "NAO INFORMADO" for the Element "CNPJ" is not accepted by the pattern "\'[0-9]{0}|[0-9]{14}\"'
    end
  end

  describe 'message for code #UNKNOWN' do
    it 'should return the full message plus the code' do
      tokens = { error_msg: 'full message'}
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == '[UNKNOWN] full message.'
    end
  end

  def get_code
    desc = example.metadata[:example_group][:description_args].first
    /#(?<code>.*)/.match(desc)[:code]
  end
end