# CP 243 — Arco das Ruínas sem Fragmentos de Greybox

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Região 3 — Arco das Ruínas.

## Alteração

Os cinco fragmentos de coroamento do Arco das Ruínas deixaram de usar `BoxMesh`. Foram substituídos por instâncias do activo de rocha de ruína já utilizado no cenário, com escala, inclinação e rotação determinísticas variadas. A silhueta mantém a leitura de lintel colapsado, mas deixa de revelar geometria rectangular de protótipo.

| Critério | Resultado |
|---|---|
| Activo visual | Rocha de ruína orgânica reutilizada do kit local |
| Material | Pedra arqueológica existente |
| Colisores | Nenhum novo colisor no arco ou no percurso |
| Luzes | Nenhuma luz adicional |
| Rota cartográfica | Marco 3 preservado |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 244 — Auditoria de activos primitivos residuais.** O ciclo seguinte fará uma procura limitada aos módulos Dev1 para priorizar apenas primitivas ainda visíveis junto da rota cartográfica, sem afectar colisores ou módulos Dev2.
