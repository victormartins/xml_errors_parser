require 'spec_helper'

describe XmlErrorsParser::ErrorMessageBuilder do
  describe 'message for code #1868' do
    it 'should work' do
      tokens = {
        element: 'Foo',
        attribute: 'Bar'
      }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == 'O Atributo "Bar" do Elemento "Foo" é obrigatório'
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
      msg.should == 'O Elemento "Foo" tem o valor "5" mas este não é um dos valores permitidos: "{\'1\',\'2\',\'3\'}"'
    end
  end

  describe 'message for code #1845' do
    it 'should work' do
      tokens = { element: 'XPTo' }
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == 'Não foi encontrada uma declaração global para o element root "XPTo"'
    end
  end

  describe 'message for code #UNKNOWN' do
    it 'should return the full message plus the code' do
      tokens = { error_msg: 'full message'}
      msg = described_class.build_message_for(get_code, tokens)
      msg.should == '[UNKNOWN] full message'
    end
  end

  def get_code
    desc = example.metadata[:example_group][:description_args].first
    /#(?<code>.*)/.match(desc)[:code]
  end
end