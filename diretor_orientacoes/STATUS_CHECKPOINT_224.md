# CP 224 — Orientação Cartográfica Casa → Estrada → Arco

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 1–3, sem alterações nos módulos das Regiões 7–12.

## Alteração

A leitura inicial do vale foi alinhada explicitamente ao mapa oficial. Os três marcos existentes na Estrada do Rio deixam de depender de valores de posição isolados e passam a ser calculados a partir de `CartographicAnchors.gd`.

| Marco visual | Fonte cartográfica | Função no percurso |
|---|---|---|
| Saída da Casa Voss | Âncora da Estrada do Rio | Confirma ao jogador a direcção inicial do vale. |
| Curva do Rio | Interpolação Estrada → Arco | Sustenta a leitura da rota na margem ribeirinha. |
| Vista do Arco | Âncora do Arco das Ruínas | Torna o destino arqueológico legível antes da chegada. |

Os cairns mantêm-se fora das lajes e não recebem colisores, preservando corrida, salto e a rota principal. Esta mudança torna a sequência observada no mundo físico consistente com a ordem 1 → 2 → 3 da cartografia.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 225 — Topologia cartográfica da Floresta Densa.** O próximo ciclo fixa a leitura de entrada da Floresta e a saída para o Acampamento Majestic como um corredor orgânico, coerente com o centro arborizado do mapa.
