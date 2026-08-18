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

## CP-D5-001 — ACTIVO

Criar `levels/dev5/CartographicLandmarkObjects.gd` como root modular de objectos cartográficos novos. A primeira versão deve conter somente constantes de orçamento, utilitários de materiais e um grupo vazio `Dev5CartographicObjects`. Não deve instanciar objetos no mundo principal.

### Aceitação

| Critério | Exigência |
|---|---|
| Escopo | Só ficheiros Dev5 novos e este marcador. |
| Validação | Godot 4.7.1 headless passa. |
| Evidência | Log + nota de checkpoint. |
| Próxima tarefa | CP-D5-002, ponte de pedra tridimensional do marco 2. |

## Fila após CP-D5-001

1. CP-D5-002 — Ponte de Pedra do marco 2 em módulo isolado, geometria/colliders próprios, zero luzes.
2. CP-D5-003 — Base `EliasThirdPersonPresentation`, sem substituir `Player.gd`.
3. CP-D5-004 — Cena QA de Elias em terceira pessoa, isolada da Casa Voss e da porta E.
4. CP-D5-005 — Integrar um GLB humano rigado somente depois de activo recuperável/licenciado e orçamento aprovado.

## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Próxima tarefa activa após publicação:** `CP-D5-001` — consolidar o módulo isolado de objectos cartográficos e iniciar a ponte 3D do marco 2 sem modificar a Estrada do Rio.
