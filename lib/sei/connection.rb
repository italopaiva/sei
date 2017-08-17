module Sei
  class Connection
    def self.instance
      case Sei.configuration.sei_ws_connection_mode
      when :soap
        Sei::ConnectionAdapters::Soap.instance
      when :http_soap_proxy
        Sei::ConnectionAdapters::HttpAsSoapProxy.instance
      end
    end
  end
end
