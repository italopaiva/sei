module Sei
  module V3
    module Estruturas
      class RetornoInclusaoDocumento < ::Valuable
        has_value :id_documento
        has_value :documento_formatado
        has_value :link_acesso

        def initialize(params)
          self.id_documento = params[:id_documento]
          self.documento_formatado = params[:documento_formatado]
          self.link_acesso = params[:link_acesso]
          initialize_attributes
        end
      end
    end
  end
end
