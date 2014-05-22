require 'spec_helper'

describe XmlErrorsParser::ErrorsRegex do
  describe '#find_expression_from_code' do

    let(:regex) { described_class.find_expression_from_code get_code }

    describe 'unkown_code' do
      it 'should return the original message and error code' do
        msg = 'Crazy error message !"#$%&/%&/(/&%"'
        mg  = regex.match(msg)
        mg[:error_msg].should == msg

      end
    end

    describe '1868' do
      it 'should work' do
        msg = "Element '{http://foo.com}infNFe': The attribute 'Id' is required but missing."
        mg  = regex.match(msg)
        mg[:element].should == 'infNFe'
        mg[:attribute].should == 'Id'
      end
    end

    describe '1840' do
      it 'should work' do
        msg = "Element '{http://www.portalfiscal.inf.br/nfe}orig': [facet 'enumeration'] The value '5' is not an element\
               of the set {'0', '1', '2'}."
        mg  = regex.match(msg)
        mg[:element].should == 'orig'
        mg[:value].should == '5'
        mg[:set].should == "{'0', '1', '2'}"
      end
    end

    describe '1845' do
      it 'should work' do
        msg = "Element '{http://www.portalfiscal.inf.br/nfe}NFe': No matching global declaration available for the \
              validation root."
        mg = regex.match(msg)
        mg[:element].should == 'NFe'
      end
    end

    describe '1839' do
      it 'should work' do
        msg = "Element '{http://www.portalfiscal.inf.br/nfe}CNPJ': [facet 'pattern'] The value 'NAO INFORMADO' is not accepted by the pattern '[0-9]{14}'"
        mg = regex.match(msg)
        mg[:element].should == 'CNPJ'
        mg[:pattern].should == "'[0-9]{14}'"
      end
    end
  end

  def get_code
    example.metadata[:example_group][:description_args].first
  end
end