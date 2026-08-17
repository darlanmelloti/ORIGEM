# Regra Dev4 — Escalonamento Contínuo de Pendências

Esta regra é obrigatória para a frente de Direção Geral. Uma pendência visual, técnica, de integração ou de validação não é uma conclusão de relatório. É um novo item activo até possuir proprietário, prazo de nova verificação e auditoria já iniciada.

> **Dev4 não encerra ao encontrar uma lacuna. Dev4 transforma a lacuna numa ordem numerada, inicia a auditoria paralela seguinte e agenda a verificação de retorno.**

## Encadeamento obrigatório

| Situação encontrada | Acção imediata de Dev4 | Estado permitido |
|---|---|---|
| Marco do mapa não legível | Publicar lacuna com âncora, captura, proprietário Dev1/Dev2/Dev3 e critério de leitura. | `ORDEM EMITIDA; AUDITORIA SEGUINTE EM EXECUÇÃO`. |
| Erro de validação | Abrir correcção para o proprietário e repetir/alternar a prova técnica. | `CORRECÇÃO E NOVA PROVA EM EXECUÇÃO`. |
| Falha de sincronização | Registar commit local, preservar histórico e avançar no ciclo local; a publicação não bloqueia produção. | `PRODUÇÃO LOCAL EM EXECUÇÃO`. |
| Fronteira entre frentes | Emitir contrato de handoff, inspeccionar ambos os lados e preparar retorno à mesma âncora. | `HANDOFF AUDITADO; VERIFICAÇÃO DE RETORNO EM EXECUÇÃO`. |

Depois de cada ordem, Dev4 deve criar ou actualizar `CONTINUIDADE_DEV4.md`. O documento deve nomear a lacuna, o proprietário, a próxima verificação e a auditoria que já começou. O texto “aguardar integração”, “aguardar resposta”, “pendência identificada” ou “próximo passo recomendado” não é aceite como estado final.

## Aplicação imediata

A auditoria CP261 da rota Casa Voss → Portão da Vila encontrou uma indisponibilidade de harness no caminho antigo. A regra correcta é usar o harness recuperado dentro do projecto, registar o resultado e abrir a preparação de recaptura Dev3; a ausência do caminho antigo não pode encerrar a auditoria.
