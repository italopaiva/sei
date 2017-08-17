require 'test_helper'

describe 'Sei::Connection' do
  describe '.instance' do
    describe 'when SOAP connection mode' do
      before do
        Sei.configure do |config|
          config.sei_ws_connection_mode = :soap
          config.wsdl = 'URL'
          config.follow_redirects = true
          config.pretty_print_xml = true
          config.sigla = 'SIGLA'
          config.identificacao = 'foobar'
        end
      end

      it { assert_equal Sei.configuration.sei_ws_connection_mode, :soap }

      it 'return a instance of the SOAP adapter' do
        connection_mock = 'soap connection mock'
        Sei::ConnectionAdapters::Soap.stub :instance, (->(*_args) { connection_mock }) do
          assert_equal Sei::Connection.instance, connection_mock
        end
      end
    end

    describe 'when HTTP SOAP Proxy connection mode' do
      before do
        Sei.configure do |config|
          config.sei_ws_connection_mode = :http_soap_proxy
          config.http_soap_proxy_url = 'Proxy URL'
          config.sigla = 'SIGLA'
          config.identificacao = 'foobar'
        end
      end

      it { assert_equal Sei.configuration.sei_ws_connection_mode, :http_soap_proxy }

      it 'return a instance of the HTTP Proxy adapter' do
        mock = 'HTTP proxy connection mock'
        Sei::ConnectionAdapters::HttpAsSoapProxy.stub :instance, (->(*_args) { mock }) do
          assert_equal Sei::Connection.instance, mock
        end
      end
    end

    describe 'when invalid connection mode' do
      it 'raise an error' do
        assert_raises GemConfig::InvalidKeyError do
          Sei.configure do |config|
            config.sigla = 'SIGLA'
            config.sei_ws_connection_mode = :non_possible_option
            config.http_soap_proxy_url = 'Proxy URL'
            config.identificacao = 'foobar'
          end
        end
      end
    end
  end
end
