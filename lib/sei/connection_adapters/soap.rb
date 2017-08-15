module Sei
  module ConnectionAdapters
    require 'singleton'

    class Soap
      include Singleton

      def client
        @client ||= Savon.client(
          wsdl: Sei.configuration.wsdl,
          follow_redirects: Sei.configuration.follow_redirects,
          pretty_print_xml: Sei.configuration.pretty_print_xml,
          convert_request_keys_to: :camelcase
        )
      end

      def call(service, message)
        request = client.build_request service.to_sym, message: message
        Sei::Printer.xp request.body
        response = client.call service.to_sym, message: message
        # Savon pattern of response index
        response_index = service.to_s + '_response'
        # The key ":parametros" is a SEI pattern of response
        response.body[response_index.to_sym][:parametros]
      end
    end
  end
end
