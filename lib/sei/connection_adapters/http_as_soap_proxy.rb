module Sei
  module ConnectionAdapters
    require 'http'
    require 'singleton'
    require 'facets/string/camelcase'

    class HttpAsSoapProxy
      include Singleton

      def call(service, message, raw_response: nil)
        service_name = service.to_s.camelcase
        params = { service: service_name, data: message }
        response = HTTP.post Sei.configuration.http_soap_proxy_url, json: params
        return response if raw_response
        return response.parse unless response.code == 400
        raise(
          HTTP::ResponseError,
          "Error in SOAP request to '#{service}': #{response.parse}"
        )
      end
    end
  end
end
