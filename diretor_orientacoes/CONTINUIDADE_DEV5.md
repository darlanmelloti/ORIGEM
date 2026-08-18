# CONTINUIDADE_DEV5 — Mundo Cartesiano e Terceira Pessoa

**Branch:** `feature/dev5-cartographic-world-third-person`.

**Base:** `3ba5638` de `feature/cine07-final`.

**Regra permanente:** um checkpoint é evidência, não paragem. Depois de publicar, ler este ficheiro, iniciar o item seguinte permitido e manter o ciclo de parser Godot + 30 segundos de gameplay/captura + avaliação visual + commit/push.

## Fronteira

Dev5 cria módulos novos em `levels/dev5/`, `assets/models_dev5/` e `entities/player/third_person/`. Não altera módulos existentes R1–R6 nem qualquer módulo R7–R12 no primeiro ciclo. A integração com o mundo principal requer prova autónoma e revisão Dev1.

## Referências obrigatórias

- `references/dev5/MAP.webp` — mapa oficial, autoridade espacial.
- `references/dev5/Elias1600x900.jpg` — direcção artística para a apresentação de Elias em terceira pessoa; não é um modelo rigado.
- `diretor_orientacoes/ONBOARDING_DEV5_MUNDO_CARTESIANO.md` — estrutura, orçamento e protocolo.

## CP-D5-001 — CONCLUÍDO

Foi criado `levels/dev5/CartographicLandmarkObjects.gd` como root modular de objectos cartográficos, com biblioteca de materiais, orçamento técnico e gerador isolado de ponte. O parser Godot 4.7.1 passou sem tocar em módulos regionais centrais.

## CP-D5-002 — ACTIVO

Integrar em **cena QA isolada** a Ponte de Pedra do marco 2, construída por `create_stone_bridge_landmark()`. A primeira validação deve posicionar a ponte sobre uma lâmina de água de teste, inspeccionar pilares, lajes e colisores próprios, e medir a leitura em 30 segundos. Não alterar `RiverRoadJourney.gd` nem a ponte existente até a cena isolada atingir 85% de leitura como marco cartográfico.

### Aceitação

| Critério | Exigência |
|---|---|
| Escopo | Apenas `levels/dev5/`, evidência Dev5 e este marcador. |
| Orçamento | Máximo 2.500 triângulos, até três materiais, zero luzes dinâmicas. |
| Validação | Parser Godot 4.7.1 e 30 segundos de gameplay/captura. |
| Próxima tarefa | CP-D5-003, base isolada `EliasThirdPersonPresentation`. |

## Fila após CP-D5-002

1. CP-D5-003 — Base `EliasThirdPersonPresentation`, sem substituir `Player.gd`.
2. CP-D5-004 — Cena QA de Elias em terceira pessoa, isolada da Casa Voss e da porta E.
3. CP-D5-005 — Integrar um GLB humano rigado somente depois de activo recuperável/licenciado e orçamento aprovado.

## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Próxima tarefa activa após publicação:** `CP-D5-002` — validar a ponte 3D do marco 2 em cena QA isolada, sem modificar a Estrada do Rio.
