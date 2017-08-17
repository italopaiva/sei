require 'test_helper'

describe 'Sei::V3::Servicos::Base' do
  before do
    # Creating a service class named 'TestService' that inherits from base
    Object.const_set 'TestService', Class.new(Sei::V3::Servicos::Base) \
      unless Object.const_defined? :TestService
    # Defining .params method with 3 arbitrary arguments to the service
    TestService.class_eval do
      def self.params(arg1, arg2, kwarg1:)
        { arg1: arg1, arg2: arg2, kwarg1: kwarg1 }
      end
    end
    @arg1 = 'foo1'
    @arg2 = 'foo2'
    @kwarg1 = 'foo3'
  end

  describe '.call' do
    before do
      @response_mock = { foo: 'bar' }
      @respond_method_mock = ->(_response) { @response_mock }
    end

    it 'calls the service with snakecase version of class name as service'\
       ' and returned message from .params() method as message' do
      connection_response = Minitest::Mock.new.expect :to_snake_keys, nil
      expected_message = { arg1: @arg1, arg2: @arg2, kwarg1: @kwarg1 }
      connection_mock = Minitest::Mock.new
      connection_mock.expect(
        :call, connection_response, [:test_service, expected_message]
      )

      Sei::V3::Servicos::Base.stub :respond, @respond_method_mock do
        Sei::Connection.stub :instance, (->(*_args) { connection_mock }) do
          result = TestService.call @arg1, @arg2, kwarg1: @kwarg1
          assert_equal result, @response_mock
        end
      end

      connection_mock.verify
      connection_response.verify
    end

    describe 'when the method .params is defined in the specific service' do
      it 'raise a NotImplementedError' do
        assert_raises NotImplementedError do
          # Creating a service without defining .params method
          Object.const_set 'BadService', Class.new(Sei::V3::Servicos::Base)
          BadService.call @arg1, @arg2, kwarg1: @kwarg1
        end
      end
    end
  end

  describe '.respond' do
    describe 'when RESPONSE_CLASS constant is defined' do
      after { TestService.send :remove_const, 'RESPONSE_CLASS' }

      it 'and is setted to :raw' do
        # Setting constant to :raw
        TestService.const_set 'RESPONSE_CLASS', :raw

        test_response = { foo: 'bar' }
        Sei::V3::Servicos::Base.stub :parse_response, nil do
          response = TestService.respond test_response
          assert_equal response, test_response
        end
      end

      it 'and is setted to an arbitrary class' do
        # Setting constant to a mock object
        test_response = { foo: 'bar' }
        expected_response = Class.new.new # Arbitrary object
        response_class_mock = Minitest::Mock.new
        response_class_mock.expect :new, expected_response, [test_response]
        def response_class_mock.==(arg); false; end
        TestService.const_set 'RESPONSE_CLASS', response_class_mock

        Sei::V3::Servicos::Base.stub :parse_response, nil do
          response = TestService.respond test_response
          assert_equal response, expected_response
        end

        response_class_mock.verify
      end
    end

    describe 'when RESPONSE_CLASS constant is not defined' do
      it 'returns an arbitrary object' do
        value = 'foo value'
        test_response = { foo: { bar: value } }
        Sei::V3::Servicos::Base.stub :parse_response, nil do
          response = TestService.respond test_response
          assert_respond_to response, :foo
          assert_respond_to response.foo, :bar
          assert_equal response.foo.bar, value
        end
      end
    end
  end

  describe '.parse_response' do
    before do
      @test_hash = {
        'foo' => {
          'bar' => [
            { 'baz' => 'whatever' }
          ]
        }
      }
      TestService.parse_response @test_hash
    end

    describe 'returns the given hash with all keys simbolized and snakecased' do
      it { assert @test_hash.key? :foo }
      it { assert @test_hash[:foo].key? :bar }
      it { assert @test_hash[:foo][:bar][0].key? :baz }
    end
  end
end
