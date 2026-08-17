# ORIGEM — Protocolo de Recuperação e Continuidade Dev3

**Estado:** obrigatório a partir deste commit.
**Frente proprietária:** Dev3 — direcção cinematográfica, composição e evidências.
**Autoridade de coordenação:** Desenvolvedor Principal.
**Regra central:** a ausência de um checkout, ramo ou referência física é um evento de recuperação, **nunca** o encerramento do ciclo de desenvolvimento.

## 1. Regra de não-paragem

Quando o ambiente Dev3 não contiver o projecto, o programador deve efectuar **uma única verificação material** dos caminhos indicados e procurar o `project.godot`. Não deve repetir mensagens equivalentes em ciclos sucessivos nem declarar a tarefa concluída. A conclusão de uma verificação abre automaticamente a recuperação descrita neste documento.

| Situação observada | Acção imediata e obrigatória | Evidência para coordenação | Próxima tarefa já aberta |
| --- | --- | --- | --- |
| Existe repositório, mas falta um ramo ou referência | Registar o bloqueio em `diretor_orientacoes/BLOQUEIO_DEV3.md`, efectuar commit e push no ramo acessível. | Commit com tabela de recursos, caminho testado, data UTC e impacto. | Recuperar o ramo/referência e iniciar a primeira validação Godot. |
| Não existe checkout, mas existe conectividade Git | Clonar `https://github.com/darlanmelloti/ORIGEM.git` num directório de recuperação, listar os ramos remotos e abrir o ramo cinematográfico aplicável. | Nota curta no ciclo, identificando o comando de recuperação e o ramo encontrado. | Ler os marcadores de continuidade e executar o próximo passe permitido. |
| Não existe checkout e a recuperação Git falha | Não fabricar código, capturas nem commits. Publicar uma única nota estruturada no canal de coordenação e esperar apenas pela reposição material. | Nota com erro objectivo, URL tentada, momento UTC e requisito mínimo. | Repetir somente a recuperação Git no ciclo seguinte; não repetir a auditoria de caminhos. |
| Checkout e recursos restabelecidos | Actualizar ou fechar `BLOQUEIO_DEV3.md`, criar `CONTINUIDADE_DEV3.md` com o próximo passe em execução e voltar imediatamente ao Godot. | Commit de retoma com validação técnica e evidência real. | Próximo subpasse cinematográfico, sem aguardar confirmação verbal. |

## 2. Marcador obrigatório no Git

Sempre que exista qualquer checkout acessível, Dev3 deve criar ou actualizar exactamente o ficheiro:

```text
res://diretor_orientacoes/BLOQUEIO_DEV3.md
```

O ficheiro deve conter apenas informação operacional verificável, no formato abaixo.

```markdown
# BLOQUEIO DEV3 — <ID>

| Campo | Valor |
| --- | --- |
| UTC | AAAA-MM-DD HH:MM |
| Frente | Dev3 cinematográfico |
| Tarefa interrompida | <ID e título> |
| Recurso ausente | <caminho, ramo ou referência> |
| Verificação única realizada | <comando/caminho e resultado> |
| Recuperação iniciada | <clone, fetch, checkout ou pedido material> |
| Próxima tentativa autónoma | <acção concreta> |

## Coordenação requerida

<uma instrução clara que o Desenvolvedor Principal consiga executar ou delegar>
```

Depois de gravar o marcador, Dev3 deve fazer **commit e push**. O commit é uma solicitação coordenável, não um ponto de paragem. O Desenvolvedor Principal deve ler o marcador, responder por commit numa instrução de recuperação ou actualizar `CONTINUIDADE_DEV3.md` com o ramo, o caminho ou a substituição autorizada.

## 3. Recuperação quando não há repositório local

Sem um checkout não é possível gravar uma nota no Git. Nesse caso, Dev3 deve aplicar esta sequência, em vez de repetir relatórios de indisponibilidade:

1. Tentar obter o repositório canónico `darlanmelloti/ORIGEM` por Git, sem criar um projecto substituto.
2. Enumerar ramos remotos e seleccionar o ramo cinematográfico aplicável. Se o ramo histórico não existir, trabalhar apenas na cópia autorizada mais próxima e registar a divergência.
3. Quando o clone for impossível, emitir **uma** mensagem estruturada de recuperação com o URL, o erro e o recurso mínimo necessário; o próximo ciclo começa directamente na recuperação Git, não numa nova varredura de caminhos.
4. Ao primeiro checkout válido, criar retroactivamente `BLOQUEIO_DEV3.md`, fazer commit e iniciar a leitura de `CONTINUIDADE_DEV3.md` e dos relatórios de evidência.

> A ausência de materiais não autoriza a criação de capturas, gameplay, ZIP, commits ou resultados fictícios. Autoriza, porém, e exige, a recuperação determinística do repositório e a criação de uma instrução coordenável assim que houver Git disponível.

## 4. Responsabilidade do Desenvolvedor Principal

Ao detectar um bloqueio Dev3, o Desenvolvedor Principal deve publicar no mesmo ramo uma resposta operacional que indique **um** destes resultados: caminho de trabalho validado, ramo a usar, clone autorizado, recurso a materializar ou tarefa alternativa dentro do escopo Dev3. A resposta deve abrir imediatamente a próxima tarefa executável de Dev3.

A ausência de uma referência cinematográfica específica não bloqueia a preparação técnica do Dev3 quando o projecto estiver disponível: o director deve ler o estado Git, actualizar a continuidade, verificar a cena aplicável e preparar a próxima matriz de captura sem alterar áreas fora do seu escopo.

## 5. Critério de encerramento de bloqueio

O bloqueio só é considerado encerrado quando, no mesmo ciclo, existirem: checkout Git válido, ramo identificado, `project.godot` acessível, uma tarefa cinematográfica em execução e a próxima acção anotada em `CONTINUIDADE_DEV3.md`. A retoma não exige nova autorização do CEO ou do Diretor Geral.
