require 'test_helper'

describe 'Sei::V3::Servicos::ListarHipotesesLegais' do
  before do
    @sigla_sei = 'SIGLA TESTE'
    @identificacao = 'Identificação do serviço'
    Sei.configure do |config|
      config.sigla = @sigla_sei
      config.identificacao = @identificacao
    end
  end

  it 'lista todas hipoteses legais quando chamado sem argumentos' do
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: nil,
      NivelAcesso: nil
    }

    call_service :listar_hipoteses_legais, expected_message: msg do
      Sei::V3::Servicos::ListarHipotesesLegais.call
    end
  end

  it 'lista todas hipoteses legais para processo restritos quando chamado com nivel de acesso 1' do
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: nil,
      NivelAcesso: 1
    }

    call_service :listar_hipoteses_legais, expected_message: msg do
      Sei::V3::Servicos::ListarHipotesesLegais.call nivel_acesso: 1
    end
  end

  it 'lista todas hipoteses legais para processo sigiloso quando chamado com nivel de acesso 2' do
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: nil,
      NivelAcesso: 2
    }

    call_service :listar_hipoteses_legais, expected_message: msg do
      Sei::V3::Servicos::ListarHipotesesLegais.call nivel_acesso: 2
    end
  end

  it 'lista todas hipoteses legais para unidade específica' do
    id_unidade = '111202054'
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      NivelAcesso: nil
    }

    call_service :listar_hipoteses_legais, expected_message: msg do
      Sei::V3::Servicos::ListarHipotesesLegais.call id_unidade: id_unidade
    end
  end

  it 'lista todas hipoteses legais para unidade e nivel de acesso específicos' do
    id_unidade = '111202054'
    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      NivelAcesso: 1
    }

    call_service :listar_hipoteses_legais, expected_message: msg do
      Sei::V3::Servicos::ListarHipotesesLegais.call id_unidade: id_unidade, nivel_acesso: 1
    end
  end
end
