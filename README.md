[![Build Status](https://travis-ci.org/italopaiva/sei.svg?branch=master)](https://travis-ci.org/italopaiva/sei)

[![codecov](https://codecov.io/gh/italopaiva/sei/branch/master/graph/badge.svg)](https://codecov.io/gh/italopaiva/sei)

# SEI!

Esta gem facilita o acesso ao webservice do SEI!. O retorno do webservice é automaticamente associado às classes de retorno que possuem os atributos retornados por cada serviço. Estes atributos são acessados através de assessores da classe.

## Instalação

Adicione esta linha no Gemfile da sua aplicação:

```ruby
gem 'sei'
```

E execute:

    $ bundle

Ou instale através do seguinte comando:

    $ gem install sei

## Uso

Uma lista com os serviços implementados na gem podem ser obtidos através do comando `rake servicos`.

A classe test/sei_test.rb possui casos de teste que podem ser utilizados como exemplo para chamada dos serviços.


### Configuração

Antes de chamar os métodos dos serviços, é necessário configurar a gem através do comando:

```ruby

Sei.configure do |config|
  config.wsdl = ENV['SEI_CONFIG_WSDL']
  config.follow_redirects = true
  config.pretty_print_xml = true
  config.sigla = ENV['SEI_CONFIG_SIGLA']
  config.identificacao = ENV['SEI_CONFIG_IDENTIFICACAO']
end

```
onde

`config.wsdl` é o endereço do WSDL do SEI, por exemplo http[s]://[servidor php]/sei/controlador_ws.php?servico=sei';
`config.follow_redirects` indica para a biblioteca 'savon' que ela deve seguir as respostas 'redirect' devolvidas pelo servidor;
`config.pretty_print_xml` indica para a biblioteca 'savon' que as mensagens XML geradas devem ser impressas no console de forma formatada;
`config.sigla` é a sigla do sistema configurada no SEI, através do menu administração -> sistemas;
`config.identificacao` é a identificação do serviço configurado no SEI, através do menu administração -> sistemas;

A gem suporta dois modos de conexão com o WebServices do SEI, utilizando o protocolo SOAP (comportamento default) ou através
de um proxy HTTP. Esta funcionalidade foi adicionada pois a comunicação direta como o WebService via SOAP em ruby muitas vezes falhava
em alguns cenários. Dos cenários testados (em Ruby, Python e PHP), a comunicação direta via SOAP só é possível sem falhas por meio do cliente SOAP do PHP (linguagem de implementação do SEI), portanto foi criada uma [aplicação em PHP](https://github.com/italopaiva/sei-soap-proxy-app) que funciona como um intermediador da comunicação, onde recebe uma requisição HTTP com os dados do serviço do SEI em JSON, chama o WebService do SEI via cliente SOAP PHP e devolve os dados em JSON (e não XML!!).
Para consumir o WebService do SEI por meio de um proxy HTTP, a configuração da gem ficaria assim:

 ```ruby

Sei.configure do |config|
  config.sei_ws_connection_mode = :http_soap_proxy
  config.http_soap_proxy_url = ENV['URL_SEI_WEB_SERVICE_PROXY']
  config.sigla = ENV['SEI_CONFIG_SIGLA']
  config.identificacao = ENV['SEI_CONFIG_IDENTIFICACAO']
end

```
onde

`config.sei_ws_connection_mode` é o tipo de conexão com o WebService do SEI. Pode ser `:soap` (para conexão direta via SOAP (default da gem)) ou `:http_soap_proxy` para utilizar a conexão via proxy HTTP específico.
`config.http_soap_proxy_url` é a URL do proxy HTTP que será utilizada quando o modo `:http_soap_proxy` for habilitado.

### Chamando os serviços

Exemplo:

```ruby

procedimento = Sei::V3::Estruturas::Procedimento.new
procedimento.id_tipo_procedimento = '100000334'
procedimento.especificacao = 'Especificacao do procedimento'
procedimento.observacao = 'Teste de integracao Web Service'
procedimento.nivel_acesso = '0'
procedimento.id_hipotese_legal = nil

retorno_geracao_procedimento = Sei::V3::Servicos::GerarProcedimento.call(
    id_unidade, procedimento, documentos: [],
    procedimentos_relacionados: [], unidades_envio: [],
    manter_aberto_unidade: 'N', enviar_email_notificacao: 'N',
    data_retorno_programado: nil, dias_retorno_programado: nil,
    dias_uteis_retorno_programado: 'N', id_marcador: nil,
    texto_marcador: nil
)

puts retorno_geracao_procedimento.id_procedimento

```

## Desenvolvimento

Após checar o repositório, execute `bin/setup` para instalar as dependências. Depois, execute `rake test` para rodar os testes. É possível também executar `bin/console` para carregar o prompt interativo que permite testar a gem na linha de comando.

Para instalar esta gem na sua máquina local, execute `bundle exec rake install`. Para publicar uma nova versão, atualize o número da versão em `version.rb` e execute `bundle exec rake release`. Isto criará uma tag git para a versão. Envie (push) os commits e tags e envie (push) o arquivo `.gem` para [rubygems.org](https://rubygems.org).

Para implementar um novo serviço, siga os passos abaixo:

- Crie uma classe com o nome do serviço (padrão CamelCase) do WebService do SEI (pois, o serviço que será chamado no WebService do SEI será deduzido a partir do nome da classe) que herda de `Sei::V3::Servicos::Base`;
- Implemente o método de classe `params()` que deve possuir como parâmetros todos os parâmetros necessários ao serviço do SEI. Este método deve retornar uma Hash contendo a estrutura dos parâmetros definidos no [Manual do Sei](https://softwarepublico.gov.br/social/articles/0004/7172/SEI-WebServices-v3.0.pdf);
- Defina na constante `RESPONSE_CLASS` a classe que será utilizada para encapsular a resposta do WebService. Se nenhuma classe for definida nesta constante um objeto arbitrário será devolvido contendo os dados de resposta. Caso queira a resposta original do WebService, defina esta constante como `:raw`.

## Contribuindo

Indicação de bugs e pull requests são bem-vindos no GitHub (https://github.com/tellesleandro/sei). Este projeto tem a intenção de ser seguro e incentiva a colaboração. É esperado que os contribuidores sigam o código de conduta [Contributor Covenant](http://contributor-covenant.org).

## Licença/License

Esta gem está disponível como código aberto dentro dos termos da [MIT License](http://opensource.org/licenses/MIT).

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

