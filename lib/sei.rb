require 'date'
require 'base64'
require 'savon'
require 'valuable'
require 'gem_config'
require 'plissken'

require 'sei/connection_adapters/soap'
require 'sei/connection_adapters/http_as_soap_proxy'
require 'sei/connection'
require 'sei/printer'
require 'sei/servico'
require 'sei/version'

require 'sei/estruturas/documento'
require 'sei/estruturas/procedimento'
require 'sei/estruturas/retorno_inclusao_documento'
require 'sei/estruturas/retorno_geracao_procedimento'

require 'sei/v3/estruturas/procedimento'
require 'sei/v3/estruturas/documento'
require 'sei/v3/estruturas/retorno_inclusao_documento'
require 'sei/v3/estruturas/retorno_geracao_procedimento'

require 'sei/v3/servicos/base'
require 'sei/v3/servicos/gerar_procedimento'

module Sei
  include GemConfig::Base

  with_configuration do
    has :wsdl, classes: String
    has :follow_redirects
    has :pretty_print_xml
    has :sigla, classes: String
    has :identificacao, classes: String
    has :sei_ws_connection_mode,
        values: %i[soap http_soap_proxy],
        default: :soap
    has :http_soap_proxy_url, classes: String
  end
end
