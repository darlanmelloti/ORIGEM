# CP 254 — Distribuição integral testada

**Branch:** `feature/dev1-gameplay-core`  
**Pacote:** `ORIGEM_V2_CP254_Cartografia_Integrada_ParaGodot.zip`  
**Tamanho:** aproximadamente 288 MB.

## Conteúdo de distribuição

A distribuição contém o projecto Godot completo com os CPs 211–253, incluindo a cartografia jogável, o marcador direccional de Elias, os reforços físicos Casa Voss → Estrada do Rio, o Arco das Ruínas aterrado e a robustez corrigida do prólogo.

Durante a primeira extracção limpa, foi identificado que a exclusão genérica de ficheiros `.uid` removia os UIDs dos autoloads declarados pelo `project.godot`. O pacote foi reconstruído com os UIDs de `EventBus`, `GameManager`, `SaveManager`, `QuestManager`, `InventoryManager` e `TimelineManager`, restaurando a criação correcta de todos os autoloads numa instalação nova.

## Validação a partir da extracção limpa

| Verificação | Resultado |
|---|---|
| Extração em diretório vazio | Aprovada |
| Estrutura e activos críticos | Presentes |
| Importação Godot 4.7.1 | Aprovada |
| Autoloads | Resolvidos sem falhas |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser, script ou recursos | Nenhum |

A evidência de gameplay foi preservada em `qa_evidence_cp254_clean/cp254_extracao_limpa_30s.png` e o registo técnico em `qa_evidence_cp254_clean/`.

## Entrega

Este é o pacote apto para entrega. Para testar, extrair o ZIP numa pasta local e abrir o ficheiro `project.godot` no Godot 4.7.1. A primeira abertura importará os activos; depois, seleccionar **Novo Jogo** no menu principal.
