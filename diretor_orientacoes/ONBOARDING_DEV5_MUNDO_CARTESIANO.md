# ORIGEM — Onboarding Dev5: Mundo Cartesiano e Jogador em Terceira Pessoa

**Branch de trabalho:** `feature/dev5-cartographic-world-third-person`.

**Base de integração:** `feature/cine07-final` no commit `3ba5638`.

**Missão:** acelerar a transformação do mapa oficial numa geografia 3D navegável, começando por objectos tridimensionais que tornam os marcos reconhecíveis no mundo sem comprimir distâncias nem introduzir painéis, outdoors ou colisores invisíveis fora da rota. Em paralelo, o Dev5 prepara uma base isolada de apresentação em terceira pessoa para o jogador **Elias**, orientada visualmente pela referência de Elias fornecida pelo CEO.

> A imagem de Elias é uma referência artística, não um modelo 3D rigado. Não deve ser aplicada como plano, billboard, textura de personagem ou mesh sem esqueleto. A primeira entrega de personagem deve usar uma apresentação 3D provisória construída por hierarquia de nós; a substituição por um GLB humano rigado será uma integração posterior, sempre validada.

## Estrutura de trabalho

| Área | Caminho | Propriedade Dev5 | Regra |
|---|---|---:|---|
| Referências | `references/dev5/` | Sim | Ler e preservar os dois anexos fornecidos. |
| Biblioteca de modelos novos | `assets/models_dev5/` | Sim | GLB/GLTF optimizados, com nota de licença e orçamento. |
| Objectos cartográficos R1–R6 | `levels/dev5/` | Sim | Criar novos módulos; não editar módulos regionais existentes no primeiro ciclo. |
| Apresentação de Elias | `entities/player/third_person/` | Sim | Implementação isolada, sem substituir `Player.gd` no primeiro ciclo. |
| Ligação opcional de QA | `levels/Dev5CartographicObjects.gd` | Sim | Só pode ser chamada por `TempleLevel` após prova validada. |
| Coordenação e evidência | `diretor_orientacoes/` | Sim | Registar cada checkpoint e a próxima tarefa activa. |

## Fronteiras intransponíveis

O Dev5 não deve modificar `levels/VossHouse.gd`, `levels/RiverRoadJourney.gd`, `levels/ForestLakeRegion.gd`, `levels/TempleLevel.gd`, `levels/CartographicAnchors.gd`, `entities/player/Player.gd`, `ui/menus/` ou qualquer módulo das Regiões 7–12 na primeira entrega. Alterações em módulos centrais só podem ser propostas por um documento de integração e aceites depois de uma comparação visual e física.

O escopo do Dev5 abrange apenas **objectos adicionais desacoplados** para as Regiões 1–6 e a **base isolada** de terceira pessoa. Regiões 7–12 continuam exclusivamente sob Dev2. O Dev5 não cria uma DIR isolada nem aguarda instruções após um commit: abre o próximo item da sua fila dentro do escopo.

## Referências fornecidas

| Ficheiro | Finalidade | SHA-256 |
|---|---|---|
| `references/dev5/MAP.webp` | Autoridade espacial e visual dos doze marcos. | `445ff9f1d0a5db5e299a25e9c2a31d3db71f8b87c4ebcbf8a41e7413458e4d6c` |
| `references/dev5/Elias1600x900.jpg` | Direcção artística para Elias: silhueta humana, cabelo escuro, camisa clara, colete castanho, calças escuras, botas e espada lateral. | `0e5cd525fa037d30fb3c4b9a575341ac1ac7a65a76e63ed6bd1f6c55e4719068` |

A versão jogável de base está nesta própria branch. O novo membro deve clonar o repositório e mudar para a branch indicada antes de qualquer edição:

```bash
git clone https://github.com/darlanmelloti/ORIGEM.git
cd ORIGEM
git switch feature/dev5-cartographic-world-third-person
```

## Primeira fila contínua do Dev5

| Checkpoint | Entrega | Critério de aceitação | Dependências |
|---|---|---|---|
| `CP-D5-001` | Criar `levels/dev5/CartographicLandmarkObjects.gd` com um módulo vazio e orçamento de activos. | Parser Godot passa; nenhum módulo central alterado. | Nenhuma. |
| `CP-D5-002` | Criar o primeiro objecto 3D de mapa: **Ponte de Pedra do marco 2**, composto por pilares e arco real, separado da estrada existente. | Vista de QA legível, colisores no próprio objecto, máximo 2.500 triângulos e zero luzes. | CP-D5-001. |
| `CP-D5-003` | Criar `entities/player/third_person/EliasThirdPersonPresentation.gd` e uma cena de apresentação: root, pivot de câmara, corpo provisório e espada lateral. | Sem modificar `Player.gd`; referência de Elias reflectida por materiais e proporções; câmera a 3.6–4.2 m. | CP-D5-001. |
| `CP-D5-004` | Criar uma cena QA que mostra Elias em terceira pessoa junto ao marco 1, sem substituir o controlador actual de primeira pessoa. | 30 s de gameplay/captura; não bloquear Casa Voss, porta E, salto ou stamina. | CP-D5-003. |
| `CP-D5-005` | Propor um primeiro activo GLB licenciado para substituir o corpo provisório. | GLB ≤10 MB, ≤12.000 triângulos, materiais PBR, licença documentada, importação Godot sem erro. | Receber activo recuperável. |

## Requisitos técnicos

A GPU de referência é GTX 1050 Ti. Cada objecto novo deve documentar triângulos aproximados, materiais, colisores e luzes. As regras são: até 16 luzes dinâmicas totais no mundo, nenhuma luz por defeito no objecto Dev5, sombreado calculado por materiais já existentes quando possível, malhas com `cast_shadow` justificado e colisores apenas sob superfícies que o jogador pode alcançar.

O padrão visual é geometria real tridimensional. Não é permitido usar a referência do mapa como textura frontal, plano vertical, billboard, cartão de vegetação ou fundo falso. Montanhas, edifícios e pontes são entregues como volumes, mesmo quando inicialmente simplificados.

## Validação obrigatória

Cada checkpoint deve passar o parser Godot 4.7.1 e uma sessão de pelo menos 30 segundos. A evidência deve incluir log, captura 1600×900 ou captura interna de viewport, avaliação visual, diff de escopo e commit. Se a leitura não atingir 85% da intenção do mapa, a hipótese deve ser refinada ou revertida antes de promoção.

## Integração

O Dev5 trabalha com commits pequenos e publicáveis. Ao fim de cada checkpoint, deve actualizar `diretor_orientacoes/CONTINUIDADE_DEV5.md` com o resultado, os ficheiros tocados, a evidência e a próxima tarefa activa. Integrações de objectos no mundo principal são feitas por pedido de pull ou cherry-pick para `feature/cine07-final` apenas depois da validação do proprietário R1–R6.

**Estado inicial:** `CP-D5-001` activo.
