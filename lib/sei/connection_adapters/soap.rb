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
        request = client.build_request service, message: message
        Sei::Printer.xp request.body
        client.call service, message
      end
    end
  end
end
