module Sei
  module V3
    module Servicos
      class IncluirDocumento < Sei::V3::Servicos::Base

        RESPONSE_CLASS = Sei::V3::Estruturas::RetornoInclusaoDocumento

        def self.params(id_unidade, documento)
          {
            SiglaSistema: Sei.configuration.sigla,
            IdentificacaoServico: Sei.configuration.identificacao,
            IdUnidade: id_unidade,
            Documento: documento.to_h
          }
        end
      end
    end
  end
end
