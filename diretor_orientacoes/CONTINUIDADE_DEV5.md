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

## CP-D5-002 — CONCLUÍDO EM QA

A Ponte de Pedra do marco 2 foi construída e validada na cena isolada `StoneBridgeLandmarkPreview.tscn`. Possui tabuleiro de 7 lajes com colisores próprios, dois encontros, arcos por aduelas, parapeitos descontínuos e zero luzes dinâmicas. O parser Godot passou e a cena manteve 36 segundos de sessão com captura interna válida. A ponte está **aprovada apenas como candidata**; não deve ser ligada à Estrada do Rio sem revisão e integração pelo proprietário R1–R6.

A evidência técnica está em `CP_D5_002_PONTE_MARCO2_QA.md`.

## CP-D5-003/004 — CONCLUÍDO COMO PROXY QA

A apresentação isolada de Elias recebeu melhorias de silhueta: colete aberto, cinto e fivela, cabelo assimétrico, bolsa lateral e espada com punho. O parser Godot 4.7.1 passou e a cena QA manteve 36 segundos com captura interna. É uma **proxy técnica**, não uma substituição de `Player.gd` nem o modelo artístico final; não toca primeira pessoa, porta E, salto, stamina ou Casa Voss.

## CP-D5-005 — BLOQUEADO POR ACTIVO EXTERNO

O candidato humano rigado está identificado, mas a aquisição automática do GLTF/FBX gratuito foi bloqueada pelo CAPTCHA do fornecedor. Integrar somente quando existir um ficheiro recuperável e uma licença/atribuição documentada.

## CP-D5-006 — CONCLUÍDO EM QA

O anexo tridimensional Casa Voss foi validado isoladamente em `VossWaystationPreview.tscn`: paredes volumétricas, abertura frontal, cobertura física de duas águas e colisores próprios. O objecto ainda não pode ser colocado em `VossHouse.gd`; ver `CP_D5_006_CASA_VOSS_ANEXO_QA.md`.

## CP-D5-007 — ACTIVO

Preparar uma ficha de proposta para os candidatos Dev5 já validados — ponte do marco 2 e anexo da Casa Voss — com âncora X/Z, distância, orçamento de materiais/triângulos, colisores, dependências e proprietário da integração. Não alterar módulos R1–R6 nesta tarefa.

## Fila após CP-D5-007

1. CP-D5-005 — Integrar GLB humano rigado somente depois de activo recuperável/licenciado e orçamento aprovado.
2. CP-D5-008 — Criar o próximo objecto cartográfico apenas em cena QA, depois da decisão Dev1 sobre os candidatos actuais.

## Correcção CEO — Identidade do jogador

A identidade correcta do jogador é **Elias**. Toda a frente Dev5 usa exclusivamente `EliasThirdPersonPresentation` e `EliasThirdPersonPreview`; as nomenclaturas anteriores foram removidas de scripts, cenas, referências e documentação. A cena QA isolada passou o parser Godot 4.7.1 e manteve uma sessão de 36 segundos, com captura interna do corpo 3D provisório de Elias e da câmara externa. Esta apresentação é uma fundação técnica tridimensional, não a versão artística final do personagem.

**Próxima tarefa activa após publicação:** `CP-D5-007` — preparar fichas de integração dos objectos Dev5 já aprovados em QA, sem modificar o mundo principal.
