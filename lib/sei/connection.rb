module Sei
  class Connection
    def self.instance
      ws_connection_mode = Sei.configuration.sei_ws_connection_mode
      if ws_connection_mode == :soap
        Sei::ConnectionAdapters::Soap.instance
      elsif ws_connection_mode == :http_soap_proxy
        Sei::ConnectionAdapters::HttpAsSoapProxy.instance
      else
        raise 'Invalid WS connection mode informed'
      end
    end
  end
end
