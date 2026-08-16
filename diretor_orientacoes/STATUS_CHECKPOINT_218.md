# CP 218 — Leitura Cartográfica do Sudoeste

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 1–3 — Casa Voss, Estrada do Rio e Arco das Ruínas.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Alteração

Foi introduzido o grupo `MarcosCartograficosSudoeste` em `RiverRoadJourney.gd`. Três pequenos cairns de pedra, sem colisores, foram colocados fora das lajes no percurso entre a saída de Voss e o Arco. Eles reforçam a leitura da sequência cartográfica **origem → rio → limiar arqueológico**, sem criar obstáculos ou nova iluminação dinâmica.

| Marco | Função de leitura | Estado |
|---|---|---|
| Casa Voss | Origem do vale sudoeste | Preservada |
| Estrada do Rio | Eixo físico de orientação | Reforçada por cairns laterais |
| Arco das Ruínas | Limiar vertical e destino de curta distância | Mantido no eixo da rota |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script no fluxo gráfico | Nenhum |
| Fronteira Regiões 7–12 | Não tocada |

## Próximo incremento autónomo

**CP 219 — Leitura cartográfica da entrada da Floresta Densa.** O trabalho permanece exclusivamente nas Regiões 1–6: ampliar a transição visual Arco → Floresta e assegurar que o jogador perceba a floresta central como massa atravessável que conduz ao Acampamento Majestic e às Ruínas Submersas.
