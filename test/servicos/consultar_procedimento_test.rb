require 'test_helper'

describe 'Sei::V3::Servicos::ConsultarProcedimento' do
  before do
    @sigla_sei = 'SIGLA TESTE'
    @identificacao = 'Identificação do serviço'
    Sei.configure do |config|
      config.sigla = @sigla_sei
      config.identificacao = @identificacao
    end
  end

  it 'consulta um procedimento com flags default' do
    id_unidade = '100091020'
    protocolo_procedimento = '00992-00001092/2017-11'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      ProtocoloProcedimento: protocolo_procedimento,
      SinRetornarAndamentoGeracao: 'S',
      SinRetornarAssuntos: 'S',
      SinRetornarInteressados: 'S',
      SinRetornarObservacoes: 'S',
      SinRetornarAndamentoConclusao: 'S',
      SinRetornarUltimoAndamento: 'S',
      SinRetornarUnidadesProcedimentoAberto: 'S',
      SinRetornarProcedimentosRelacionados: 'S',
      SinRetornarProcedimentosAnexados: 'S'
    }

    call_service :consultar_procedimento, expected_message: msg do
      Sei::V3::Servicos::ConsultarProcedimento.call(id_unidade, protocolo_procedimento)
    end
  end

  it 'consulta um procedimento desabilitando algumas flags' do
    id_unidade = '100091020'
    protocolo_procedimento = '00992-00001092/2017-11'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      ProtocoloProcedimento: protocolo_procedimento,
      SinRetornarAndamentoGeracao: 'S',
      SinRetornarAssuntos: 'N',
      SinRetornarInteressados: 'S',
      SinRetornarObservacoes: 'N',
      SinRetornarAndamentoConclusao: 'S',
      SinRetornarUltimoAndamento: 'S',
      SinRetornarUnidadesProcedimentoAberto: 'S',
      SinRetornarProcedimentosRelacionados: 'S',
      SinRetornarProcedimentosAnexados: 'S'
    }

    call_service :consultar_procedimento, expected_message: msg do
      Sei::V3::Servicos::ConsultarProcedimento.call(
        id_unidade, protocolo_procedimento,
        retornar_assuntos: 'N', retornar_observacoes: 'N'
      )
    end
  end
end
