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
    protocolo_procedimento = '00992-00001092/2017-11'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: nil,
      ProtocoloProcedimento: protocolo_procedimento,
      SinRetornarAndamentoGeracao: 'N',
      SinRetornarAssuntos: 'N',
      SinRetornarInteressados: 'N',
      SinRetornarObservacoes: 'N',
      SinRetornarAndamentoConclusao: 'N',
      SinRetornarUltimoAndamento: 'N',
      SinRetornarUnidadesProcedimentoAberto: 'N',
      SinRetornarProcedimentosRelacionados: 'N',
      SinRetornarProcedimentosAnexados: 'N'
    }

    call_service :consultar_procedimento, expected_message: msg do
      Sei::V3::Servicos::ConsultarProcedimento.call(protocolo_procedimento)
    end
  end

  it 'consulta um procedimento habilitando algumas flags' do
    id_unidade = '100091020'
    protocolo_procedimento = '00992-00001092/2017-11'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      ProtocoloProcedimento: protocolo_procedimento,
      SinRetornarAndamentoGeracao: 'N',
      SinRetornarAssuntos: 'S',
      SinRetornarInteressados: 'N',
      SinRetornarObservacoes: 'S',
      SinRetornarAndamentoConclusao: 'N',
      SinRetornarUltimoAndamento: 'N',
      SinRetornarUnidadesProcedimentoAberto: 'N',
      SinRetornarProcedimentosRelacionados: 'N',
      SinRetornarProcedimentosAnexados: 'N'
    }

    call_service :consultar_procedimento, expected_message: msg do
      Sei::V3::Servicos::ConsultarProcedimento.call(
        protocolo_procedimento,
        id_unidade: id_unidade,
        retornar_assuntos: 'S',
        retornar_observacoes: 'S'
      )
    end
  end
end
