require 'test_helper'

describe 'Sei::V3::Servicos::GerarProcedimento' do
  before do
    @wsdl = 'test URL'
    @sigla_sei = 'SIGLA TESTE'
    @identificacao = 'Identificação do serviço'
    Sei.configure do |config|
      config.wsdl = @wsdl
      config.follow_redirects = true
      config.pretty_print_xml = true
      config.sigla = @sigla_sei
      config.identificacao = @identificacao
    end
  end

  it 'tem como classe de retorno a classe RetornoGeracaoProcedimento' do
    assert_equal(
      Sei::V3::Servicos::GerarProcedimento::RESPONSE_CLASS,
      Sei::V3::Estruturas::RetornoGeracaoProcedimento
    )
  end

  it 'gera um procedimento sem documento' do
    # Cria um procedimento arbitrario
    procedimento = Sei::V3::Estruturas::Procedimento.new
    procedimento.id_tipo_procedimento = '100000334'
    procedimento.especificacao = 'Especificacao do procedimento'
    procedimento.observacao = 'Teste de integracao Web Service'
    procedimento.nivel_acesso = '0'
    procedimento.id_hipotese_legal = nil
    id_unidade = '100091020'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      Procedimento: procedimento.to_h,
      Documentos: nil,
      ProcedimentosRelacionados: nil,
      UnidadesEnvio: nil,
      SinManterAbertoUnidade: 'N',
      SinEnviarEmailNotificacao: 'N',
      DataRetornoProgramado: nil,
      DiasRetornoProgramado: nil,
      SinDiasUteisRetornoProgramado: 'N',
      IdMarcador: nil,
      TextoMarcador: nil
    }

    call_service :gerar_procedimento, expected_message: msg do
      Sei::V3::Servicos::GerarProcedimento.call(id_unidade, procedimento)
    end
  end

  it 'gera um procedimento com um documento' do
    documento = Sei::V3::Estruturas::Documento.new
    documento.tipo = 'G'
    documento.id_serie = '3'
    documento.numero = '456453'
    documento.descricao = 'Descrição do documento teste...'
    documento.observacao = 'Observacao teste do documento'
    documento.conteudo = 'Conteudo do documento'
    documento.nivel_acesso = '0'
    documento.id_procedimento = '155373'

    # Cria um procedimento arbitrario
    procedimento = Sei::V3::Estruturas::Procedimento.new
    procedimento.id_tipo_procedimento = '100000334'
    procedimento.especificacao = 'Especificacao do procedimento'
    procedimento.observacao = 'Teste de integracao Web Service'
    procedimento.nivel_acesso = '0'
    procedimento.id_hipotese_legal = nil
    id_unidade = '100091020'

    # Mensagem esperada
    msg = {
      SiglaSistema: @sigla_sei,
      IdentificacaoServico: @identificacao,
      IdUnidade: id_unidade,
      Procedimento: procedimento.to_h,
      Documentos: [documento.to_h],
      ProcedimentosRelacionados: nil,
      UnidadesEnvio: nil,
      SinManterAbertoUnidade: 'N',
      SinEnviarEmailNotificacao: 'N',
      DataRetornoProgramado: nil,
      DiasRetornoProgramado: nil,
      SinDiasUteisRetornoProgramado: 'N',
      IdMarcador: nil,
      TextoMarcador: nil
    }

    call_service :gerar_procedimento, expected_message: msg do
      Sei::V3::Servicos::GerarProcedimento.call(
        id_unidade, procedimento, documentos: [documento]
      )
    end
  end
end
