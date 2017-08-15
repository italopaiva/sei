module Sei
  module V3
    module Servicos
      class GerarProcedimento < Sei::V3::Servicos::Base

        RESPONSE_CLASS = Sei::V3::Estruturas::RetornoGeracaoProcedimento

        def self.params(
          id_unidade, procedimento, documentos: [],
          procedimentos_relacionados: [], unidades_envio: [],
          manter_aberto_unidade: 'N', enviar_email_notificacao: 'N',
          data_retorno_programado: nil, dias_retorno_programado: nil,
          dias_uteis_retorno_programado: 'N', id_marcador: nil,
          texto_marcador: nil
        )
          {
            SiglaSistema: Sei.configuration.sigla,
            IdentificacaoServico: Sei.configuration.identificacao,
            IdUnidade: id_unidade,
            Procedimento: procedimento.to_h,
            Documentos: documentos.empty? ? nil : documentos.map(&:to_h),
            ProcedimentosRelacionados: procedimentos_relacionados.empty? ? nil : procedimentos_relacionados.map(&:to_s),
            UnidadesEnvio: unidades_envio.empty? ? nil : unidades_envio.map(&:to_s),
            SinManterAbertoUnidade: manter_aberto_unidade,
            SinEnviarEmailNotificacao: enviar_email_notificacao,
            DataRetornoProgramado: data_retorno_programado,
            DiasRetornoProgramado: dias_retorno_programado,
            SinDiasUteisRetornoProgramado: dias_uteis_retorno_programado,
            IdMarcador: id_marcador,
            TextoMarcador: texto_marcador
          }
        end
      end
    end
  end
end
