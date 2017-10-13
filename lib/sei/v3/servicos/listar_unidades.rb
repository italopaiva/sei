module Sei
  module V3
    module Servicos
      class ListarUnidades < Sei::V3::Servicos::Base

        def self.params(id_tipo_procedimento: nil, id_serie: nil)
          {
            SiglaSistema: Sei.configuration.sigla,
            IdentificacaoServico: Sei.configuration.identificacao,
            IdTipoProcedimento: id_tipo_procedimento,
            IdSerie: id_serie
          }
        end
      end
    end
  end
end
