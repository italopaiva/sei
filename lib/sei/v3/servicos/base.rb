module Sei
  module V3
    module Servicos
      class Base
        def self.call(*args)
          service = name.split('::').last.underscore.to_sym
          message = params(*args)
          respond Sei::Connection.instance.call(
            service, message
          ).to_snake_keys
        end

        def self.respond(response)
          parse_response response
          if const_defined? :RESPONSE_CLASS
            return response if self::RESPONSE_CLASS == :raw
            self::RESPONSE_CLASS.new response
          else
            JSON.parse response.to_json, object_class: OpenStruct
          end
        end

        # Simbolize all keys in the response object
        def self.parse_response(response)
          require 'facets/hash/deep_rekey' unless {}.respond_to? :deep_rekey!
          response.deep_rekey! if response.is_a? Hash
          response.each do |_key, value|
            if value.is_a? Hash
              value.deep_rekey!
              parse_response value
            elsif value.is_a? Array
              value.each do |item|
                item.deep_rekey! if item.is_a? Hash
                parse_response item
              end
            end
          end
        end

        def self.params(*_args)
          raise(
            NotImplementedError,
            "Método params() não implementado no serviço #{name}"
          )
        end

        def self.all_services
          ObjectSpace.each_object(Class).select { |klass| klass < self }
        end
      end
    end
  end
end
