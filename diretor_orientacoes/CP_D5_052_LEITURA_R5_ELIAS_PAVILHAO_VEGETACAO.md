# CP-D5-052 — Leitura R5: Elias, Pavilhão e vegetação aterrada

**Escopo:** cena QA isolada em `levels/dev5/`. Não altera `Player.gd`, `ForestLakeRegion.gd`, `TempleLevel.gd` ou qualquer módulo das Regiões 1–12.

## Objectivo

Comprovar que os candidatos técnicos já validados podem coexistir numa única leitura de Acampamento Majestic sem fechar o corredor de Elias, sem converter a vegetação numa parede e sem ultrapassar o orçamento Dev5 de luzes.

| Elemento | Contrato testado | Resultado |
|---|---|---|
| Pavilhão Majestic | X/Z `(-88,178)`, ajuste apenas em Y por raycast | Aterrado e legível |
| Elias | Corredor `X=-80`, câmara externa exclusiva | Aprovado, apresentação em terceira pessoa visível |
| Folga | Mínimo `4,00 m` | `5,45 m` confirmado |
| Vegetação | 1 árvore detalhada, 2 leves, 2 fetos nos bordos | 5/5 aterrados; corredor aberto |
| Luzes | Apenas uma direccional QA | 1/1; zero Omni/Spot |
| Produção | Módulos Dev1/Dev2 protegidos | 0 alterações |

## Validação

O parser Godot 4.7.1 passou. A cena executou durante 36 segundos, efectuou três ciclos de rota sem bloqueio e gerou captura interna. A telemetria confirmou a preservação de X/Z, a câmara de Elias inactiva e uma câmara QA externa como proprietária da viewport.

A captura é **evidência técnica**, não promoção visual para produção. Ela comprova o corredor, o grounding e a leitura relativa dos volumes; o refinamento artístico do Majestic no mundo integrado permanece responsabilidade de Dev1, sujeito à validação regional de pelo menos 30 segundos.

## Próxima tarefa automática

**CP-D5-053 — Leitura R6: Elias, baliza e vegetação ribeirinha aterrada.** Repetir a composição técnica no marco Ruínas com uma única árvore leve e fetos laterais, preservando a folga R6 e sem reutilizar o cais de lajes rejeitado.
