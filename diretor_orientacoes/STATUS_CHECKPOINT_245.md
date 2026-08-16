# CP 245 — Auditoria Integrada do Vale Cartográfico

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 1–6, marco de handoff da Região 7 e mapa jogável.

## Resultado da auditoria

A cartografia passou de referência ilustrada para estrutura técnica e jogável do vale. Os seis marcos sob responsabilidade Dev1 são consumidos por módulos de mundo, por um registo central de âncoras e pelo mapa consultável durante a exploração.

| Marco | Âncora X/Z | Leitura física confirmada | Integração cartográfica |
|---|---:|---|---|
| 1 — Casa Voss | `-22 / 8` | Casa de abertura, estrada e paisagem | Origem de Elias no mapa |
| 2 — Estrada do Rio | `-21.4 / 12` | Rota, trilho e marcos laterais | Primeiro destino obrigatório |
| 3 — Arco das Ruínas | `-16.741 / 48` | Arco orgânico e coroamento colapsado | Destino após a Estrada |
| 4 — Floresta Densa | `-9 / 116` | Limiar atravessável e massa florestal | Destino após o Arco |
| 5 — Acampamento Majestic | `-88 / 178` | Fogueira, corredor e vista de bacia | Destino após a Floresta |
| 6 — Ruínas Submersas | `60 / 252` | Lago, ruínas, afluente e margem física | Destino após o Acampamento |
| 7 — Vila Elevada | `140 / 352` | Portão de ruína no limite Dev1 | Handoff explícito para Dev2 |

## Resultado técnico

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 246 — Integração de direcção visual para a Vila Elevada.** O próximo ciclo Dev1 continuará apenas no lado permitido da Região 6, reforçando a leitura da passagem para o marco 7 sem criar geometria, câmaras ou conteúdo de Região 7.
