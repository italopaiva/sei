require 'test_helper'

describe 'Sei::V3::Servicos::ListarUnidades' do
  before do
    @sigla_sei = 'SIGLA TESTE'
    @identificacao = 'Identificação do serviço'
    Sei.configure do |config|
      config.sigla = @sigla_sei
      config.identificacao = @identificacao
    end
  end

  it 'lista todas unidades quando chamado sem argumentos' do
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdTipoProcedimento: nil,
      IdSerie: nil
    }

    call_service :listar_unidades, expected_message: msg do
      Sei::V3::Servicos::ListarUnidades.call
    end
  end

  it 'lista todas unidades para o tipo de procedimento informado' do
    id_tipo_procedimento = '11105256'
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdTipoProcedimento: id_tipo_procedimento,
      IdSerie: nil
    }

    call_service :listar_unidades, expected_message: msg do
      Sei::V3::Servicos::ListarUnidades.call(
        id_tipo_procedimento: id_tipo_procedimento
      )
    end
  end

  it 'lista todas unidades para a série informada' do
    id_serie = '3'
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdTipoProcedimento: nil,
      IdSerie: id_serie
    }

    call_service :listar_unidades, expected_message: msg do
      Sei::V3::Servicos::ListarUnidades.call id_serie: id_serie
    end
  end
end
