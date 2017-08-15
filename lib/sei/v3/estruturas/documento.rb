module Sei
  module V3
    module Estruturas
      class Documento
        attr_accessor :tipo, :id_procedimento, :protocolo_procedimento,
                      :id_serie, :numero, :data, :descricao, :observacao,
                      :id_tipo_conferencia, :nome_arquivo, :nivel_acesso,
                      :id_hipotese_legal, :id_arquivo, :sin_bloqueado
        attr_reader :remetente, :interessados, :destinatarios,
                    :conteudo, :conteudo_mtom, :campos

        def remetente=(sigla, nome)
          @remetente = { Sigla: sigla, Nome: nome }
        end

        def conteudo=(conteudo)
          @conteudo = Base64.strict_encode64 conteudo
        end

        def conteudo_mtom=(conteudo_mtom)
          @conteudo_mtom = File.read conteudo_mtom
        end

        def adicionar_destinatarios(sigla, nome)
          @destinatarios ||= []
          @destinatarios << {
            Sigla: sigla,
            Nome: nome
          }
        end

        def adicionar_interessado(sigla, nome)
          @interessados ||= []
          @interessados << {
            Sigla: sigla,
            Nome: nome
          }
        end

        def adicionar_campo(nome, valor)
          @campos ||= []
          @campos << {
            Nome: nome,
            Valor: valor
          }
        end

        def to_h
          {
            Tipo: tipo,
            IdProcedimento: id_procedimento,
            ProtocoloProcedimento: protocolo_procedimento,
            IdSerie: id_serie,
            Numero: numero,
            Data: data,
            Descricao: descricao,
            IdTipoConferencia: id_tipo_conferencia,
            Remetente: remetente,
            Interessados: interessados,
            Destinatarios: destinatarios,
            Observacao: observacao,
            NomeArquivo: nome_arquivo,
            Conteudo: conteudo,
            ConteudoMTOM: conteudo_mtom,
            NivelAcesso: nivel_acesso,
            IdHipoteseLegal: id_hipotese_legal,
            IdArquivo: id_arquivo,
            Campos: campos,
            SinBloqueado: !sin_bloqueado ? 'N' : 'S'
          }
        end
      end
    end
  end
end
