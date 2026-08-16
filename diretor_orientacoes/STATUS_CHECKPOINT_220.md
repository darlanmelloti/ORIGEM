# CP 220 — Panorâmica Cartográfica Majestic → Lago

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 4–6 — Floresta Densa, Acampamento Majestic e Ruínas Submersas.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Alteração

Foi acrescentado o nó `MiradourosCartograficosDoLago` no `ForestLakeRegion.gd`. Três vestígios de observação com pilares quebrados, rochas e fetos acompanham a aproximação entre o flanco Majestic e a margem ocidental das Ruínas Submersas. Os elementos ficam fora do caminho e não têm colisores ou luzes dinâmicas.

A intenção espacial é tornar legível a relação do mapa: o Acampamento Majestic permanece a oeste da floresta, enquanto a vegetação se abre progressivamente para o lago central e as ruínas submersas.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Colisores novos no percurso | Nenhum |
| Luzes dinâmicas novas | Nenhuma |
| Fronteira Regiões 7–12 | Não tocada |

## Próximo incremento autónomo

**CP 221 — Leitura cartográfica do lago para a Vila Elevada.** Dentro das Regiões 1–6, o trabalho limita-se à margem norte e ao portão de handoff: melhorar a vista através da água e reforçar que a estrada sobe para a Região 7, sem alterar qualquer módulo ou activo pertencente ao Dev2.
