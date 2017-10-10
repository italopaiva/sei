module Sei
  module V3
    module Servicos
      class ListarHipotesesLegais < Sei::V3::Servicos::Base

        def self.params(id_unidade: nil, nivel_acesso: nil)
          {
            SiglaSistema: Sei.configuration.sigla,
            IdentificacaoServico: Sei.configuration.identificacao,
            IdUnidade: id_unidade,
            NivelAcesso: nivel_acesso
          }
        end
      end
    end
  end
end
