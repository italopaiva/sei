module Sei
  module V3
    module Estruturas
      class Procedimento
        attr_accessor :id_tipo_procedimento, :numero_protocolo, :data_autuacao,
                      :especificacao, :observacao, :nivel_acesso,
                      :id_hipotese_legal
        attr_reader :assuntos, :interessados

        def adicionar_assunto(codigo_estruturado, descricao)
          @assuntos ||= []
          @assuntos << {
            CodigoEstruturado: codigo_estruturado,
            Descricao: descricao
          }
        end

        def adicionar_interessado(sigla, nome)
          @interessados ||= []
          @interessados << {
            Sigla: sigla,
            Nome: nome
          }
        end

        def to_h
          {
            IdTipoProcedimento: id_tipo_procedimento,
            NumeroProtocolo: numero_protocolo,
            Especificacao: especificacao,
            DataAutuacao: data_autuacao,
            Assuntos: assuntos,
            Interessados: interessados,
            Observacao: observacao,
            NivelAcesso: nivel_acesso,
            IdHipoteseLegal: id_hipotese_legal
          }
        end
      end
    end
  end
end
