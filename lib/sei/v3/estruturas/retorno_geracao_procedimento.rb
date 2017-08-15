module Sei
  module V3
    module Estruturas
      class RetornoGeracaoProcedimento < ::Valuable
        has_value :id_procedimento
        has_value :procedimento_formatado
        has_value :link_acesso
        has_collection :retorno_inclusao_documentos,
                       klass: Sei::V3::Estruturas::RetornoInclusaoDocumento

        def initialize(params)
          self.id_procedimento = params[:id_procedimento]
          self.procedimento_formatado = params[:procedimento_formatado]
          self.link_acesso = params[:link_acesso]
          inicializar_documentos params
          initialize_attributes
        end

        def inicializar_documentos(params)
          self.retorno_inclusao_documentos = []
          documentos = params[:retorno_inclusao_documentos]
          documentos.each do |documento|
            self.retorno_inclusao_documentos.push(
              Sei::V3::Estruturas::RetornoInclusaoDocumento.new(
                documento
              )
            )
          end
        end
      end
    end
  end
end
