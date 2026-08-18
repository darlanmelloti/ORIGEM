# Sincronização Canónica — Dev3

## Fonte de verdade

A frente cinematográfica usa o repositório `darlanmelloti/ORIGEM`, branch `feature/cine07-final`. O checkout canónico actualmente validado é `/home/ubuntu/ORIGEM_cine48_recovered`. Qualquer caminho como `/home/ubuntu/work/ORIGEM_director_cinematic_polish_pass02` é apenas um destino local opcional de recuperação; a sua ausência **não** é bloqueio do projecto nem justifica concluir um ciclo sem entrega.

## Recuperação reproduzível

Dev3 deve executar `tools/qa/bootstrap_dev3_workspace.sh` no ambiente onde irá trabalhar. A ferramenta recupera ou actualiza um checkout da branch canónica, verifica a existência de `project.godot` e executa uma validação Godot headless antes de devolver o caminho, a branch e o commit. Um relatório só pode declarar bloqueio depois de o bootstrap falhar e de anexar a saída exacta da ferramenta.

| Elemento | Estado operacional | Acção válida |
| --- | --- | --- |
| Repositório Git | Fonte necessária | Clonar ou actualizar a branch canónica. |
| `project.godot` | Necessário para execução | Validar com Godot headless. |
| Mapa e vídeo de referência antigos | Úteis para direcção de arte, mas não necessários para corrigir ou validar código existente | Registar ausência como lacuna de referência; continuar com tarefas instrumentais e de gameplay. |
| Workspace antigo Dev3 | Não-canónico | Recuperar pelo bootstrap; nunca criar uma pasta vazia e declarar a tarefa concluída. |

## Responsabilidades

Dev3 trabalha na composição, câmaras, evidências e critérios cinematográficos usando o checkout recuperado. Dev4 não fica à espera: é proprietário da ferramenta de recuperação, do teste de integridade após o clone, das validações de input, orçamento e estado, e deve entregar os logs/capturas que permitem a Dev3 iniciar o próximo passe.

## Proibição de bloqueio fictício

São inválidas as frases “sem projecto”, “sem repositório” ou “sem `/home/ubuntu/work/...`” quando a branch canónica ou o bootstrap ainda não foram verificados. Um bloqueio é válido apenas se incluir: comando de bootstrap, saída de falha, commit pretendido e a tarefa QA independente que Dev4 iniciou em paralelo.
