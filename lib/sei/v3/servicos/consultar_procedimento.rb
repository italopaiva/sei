module Sei
  module V3
    module Servicos
      class ConsultarProcedimento < Sei::V3::Servicos::Base

        def self.params(
          id_unidade, protocolo, retornar_andamento_geracao: 'S',
          retornar_assuntos: 'S', retornar_interessados: 'S',
          retornar_observacoes: 'S', retornar_andamento_conclusao: 'S',
          retornar_ultimo_andamento: 'S', retornar_unidades_procedimento_aberto: 'S',
          retornar_procedimentos_relacionados: 'S', retornar_procedimentos_anexados: 'S'
        )
          {
            SiglaSistema: Sei.configuration.sigla,
            IdentificacaoServico: Sei.configuration.identificacao,
            IdUnidade: id_unidade,
            ProtocoloProcedimento: protocolo,
            SinRetornarAndamentoGeracao: retornar_andamento_geracao,
            SinRetornarAssuntos: retornar_assuntos,
            SinRetornarInteressados: retornar_interessados,
            SinRetornarObservacoes: retornar_observacoes,
            SinRetornarAndamentoConclusao: retornar_andamento_conclusao,
            SinRetornarUltimoAndamento: retornar_ultimo_andamento,
            SinRetornarUnidadesProcedimentoAberto: retornar_unidades_procedimento_aberto,
            SinRetornarProcedimentosRelacionados: retornar_procedimentos_relacionados,
            SinRetornarProcedimentosAnexados: retornar_procedimentos_anexados
          }
        end
      end
    end
  end
end
