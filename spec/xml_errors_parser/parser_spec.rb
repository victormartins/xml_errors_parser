require 'spec_helper'

describe XmlErrorsParser::Parser do

  def error_1868_missing_attribute(element, attribute)
    double :error, {
      code:    '1868',
      message: "Element '{http://www.portalfiscal.inf.br/nfe}#{element}': The attribute '#{attribute}' is required but missing."
    }
  end

  it 'should return no errors of no errors are sent' do
    described_class.new([]).errors.should == []
  end

  it 'should parser missing attributes for elements' do

    errors = [
      error_1868_missing_attribute('infNFe', 'Id'),
      error_1868_missing_attribute('Foo', 'Bar')
    ]

    expected_errors = [
      'O Atributo "Id" do Elemento "infNFe" é obrigatório',
      'O Atributo "Bar" do Elemento "Foo" é obrigatório'
    ]

    described_class.new(errors).errors.should == expected_errors

  end
end