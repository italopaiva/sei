module ServicesHelper
  def call_service(expected_service, expected_message:)
    connection_mock = Minitest::Mock.new
    connection_mock.expect :call, {}, [expected_service, expected_message]
    response_mock = { foo: 'bar' }

    Sei::V3::Servicos::Base.stub :respond, (->(_) { response_mock }) do
      Sei::Connection.stub :instance, (->(*_) { connection_mock }) do
        result = yield
        assert_equal result, response_mock
      end
    end

    connection_mock.verify
  end
end
