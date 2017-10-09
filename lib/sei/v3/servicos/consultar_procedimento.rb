module Sei
  module V3
    module Servicos
      class ConsultarProcedimento < Sei::V3::Servicos::Base

        def self.params(
          protocolo, id_unidade: nil, retornar_andamento_geracao: 'N',
          retornar_assuntos: 'N', retornar_interessados: 'N',
          retornar_observacoes: 'N', retornar_andamento_conclusao: 'N',
          retornar_ultimo_andamento: 'N', retornar_unidades_procedimento_aberto: 'N',
          retornar_procedimentos_relacionados: 'N', retornar_procedimentos_anexados: 'N'
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
