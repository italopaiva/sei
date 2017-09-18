require 'test_helper'

describe 'Sei::V3::Servicos::IncluirDocumento' do
  before do
    @sigla_sei = 'SIGLA TESTE'
    @identificacao = 'Identificação do serviço'
    Sei.configure do |config|
      config.sigla = @sigla_sei
      config.identificacao = @identificacao
    end
  end

  it 'tem como classe de retorno a classe RetornoGeracaoProcedimento' do
    assert_equal(
      Sei::V3::Servicos::IncluirDocumento::RESPONSE_CLASS,
      Sei::V3::Estruturas::RetornoInclusaoDocumento
    )
  end

  it 'inclui um documento' do
    documento = Sei::V3::Estruturas::Documento.new
    documento.tipo = 'G'
    documento.id_serie = '3'
    documento.numero = '456453'
    documento.descricao = 'Descrição do documento teste...'
    documento.observacao = 'Observacao teste do documento'
    documento.conteudo = 'Conteudo do documento'
    documento.nivel_acesso = '0'
    documento.id_procedimento = '155373'
    id_unidade = '100091020'

    # Mensagem esperada
    msg = {
      SiglaSistema: Sei.configuration.sigla,
      IdentificacaoServico: Sei.configuration.identificacao,
      IdUnidade: id_unidade,
      Documento: documento.to_h
    }

    call_service :incluir_documento, expected_message: msg do
      Sei::V3::Servicos::IncluirDocumento.call id_unidade, documento
    end
  end
end
