# ORIGEM — Ordem Imediata ao Dev2: CP-D2-002

**Branch exclusiva:** `feature/dev2-mountain-canyon`  
**Responsável:** Dev2  
**Estado de entrada:** `CP-D2-001 = REJECTED_VISUAL`  
**Início:** imediato; este documento não exige autorização, reunião ou resposta do Diretor.

> O último checkpoint do Dev2 confirmou que os Takes 6–7 já carregam, compilaram e foram validados tecnicamente, mas a avaliação visual rejeitou a silhueta por ainda transmitir leitura low-poly. O próximo ciclo não pode ser uma pausa: deve corrigir primeiro o orçamento de luzes e, em seguida, elevar a forma, a escala e a variação material das colunas e paredes dos Takes 6–7.

## Fronteira Operacional

| Permitido | Proibido |
|---|---|
| `levels/Takes5to7Director.gd` | Módulos e activos das Regiões 1–6 |
| `levels/HighlandRegion.gd` | `VossHouse.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, `DaylightValley.gd` |
| `levels/OrionDestinationRegion.gd` | Alterar o portão de handoff Dev1→Dev2 em `TempleLevel.gd` |
| Registos e evidências dentro de `diretor_orientacoes/` | Criar geometria nas Regiões 1–6 |

O ponto de entrada validado pelo Dev1 continua em **`Vector3(140, y, 352)`**. Não modifiques a geometria, os materiais nem os colisores do corredor de handoff; constrói apenas para além desta fronteira, dentro da área Dev2.

## CP-D2-002A — Correcção de Orçamento no Take 6

No método `_build_take_6_canyon_ascent()` em `Takes5to7Director.gd`, as três chamadas `_add_canyon_brazier(...)` estão actualmente dentro do ciclo de `range(16)`. Isso multiplica os três braseiros por cada segmento do cânion, gerando uma quantidade excessiva de luzes e repetição visual.

**Acção obrigatória:** desloca estas três chamadas para fora do ciclo, deixando exactamente três braseiros de orientação no Take 6:

```gdscript
# Depois do fim do for index in range(16):
_add_canyon_brazier(canyon, Vector3(-4.6, 1.2, -18.0), "BraseiroAzul_Ascensao_L")
_add_canyon_brazier(canyon, Vector3(4.6, 1.2, -28.0), "BraseiroAzul_Ascensao_R")
_add_canyon_brazier(canyon, Vector3(-3.8, 2.0, -39.0), "BraseiroAzul_FendaProfunda")
```

Mantém as fendas tectónicas existentes, mas confirma que o Take 6 não excede **7 luzes simultâneas**: 3 braseiros + no máximo 4 fendas. Todas devem permanecer com sombras desactivadas.

## CP-D2-002B — Passe de Silhueta e Material do Take 7

A praça ciclópica precisa deixar de parecer um conjunto uniforme de rochas repetidas. No ciclo de `ColunaCiclopea` dentro de `_build_take_7_open_orion_chamber()`, aplica três famílias de leitura, alternadas de forma determinística:

| Família | Índices | Material | Tratamento de forma |
|---|---|---|---|
| Pedra húmida monumental | `index % 3 == 0` | `stone_wet` | Base larga e altura dominante |
| Pedra com musgo | `index % 3 == 1` | `moss_stone` | Inclinação suave e copa fracturada |
| Pedra escura em ruína | `index % 3 == 2` | `stone_dark` | Secção mais estreita e rotação mais marcada |

Acrescenta **seis pedras de base** e **quatro fragmentos de coroamento** em pontos alternados da praça. Usa `_add_organic_rock`, escalas diferentes e rotação discreta. Não adiciones colisores a estes adornos e não bloqueies o eixo visual entre a entrada da praça, a arena e o Cubo de Orion.

## CP-D2-002C — Evidência Obrigatória

Depois de cada subfase, executa e conserva as evidências:

```bash
# 1. Compilação técnica
GODOT_SILENCE_ROOT_WARNING=1 timeout 90 "$GODOT" --headless --path "$ROOT" --editor --quit

# 2. Take 6 — 30 segundos
ORIGEM_VALIDATION_TAKE=6 xvfb-run --auto-servernum --server-args="-screen 0 1600x900x24" \
  timeout 35 "$GODOT" --path "$ROOT"

# 3. Take 7 — 30 segundos
ORIGEM_VALIDATION_TAKE=7 xvfb-run --auto-servernum --server-args="-screen 0 1600x900x24" \
  timeout 35 "$GODOT" --path "$ROOT"
```

Guarda em `diretor_orientacoes/evidence/cp-d2-002-take6-budget-silhouette/` e `diretor_orientacoes/evidence/cp-d2-002-take7-columns-material/` os respectivos logs, clipes de 30 segundos e capturas de `1600×900`.

## Critérios de Aceitação

| Critério | Resultado exigido |
|---|---|
| Take 6 | ≤ 7 luzes dinâmicas simultâneas, sem repetição de braseiros |
| Take 6 | Paredes de canyon com três leituras de material e escala orgânica |
| Take 7 | Colunas com três materiais, bases e coroamentos irregulares |
| Take 7 | Eixo entrada → arena → Cubo Orion mantém-se legível e livre |
| Teste técnico | Headless aprovado |
| Gameplay | Take 6 e Take 7 executados por pelo menos 30 s |
| Escopo | Zero ficheiros das Regiões 1–6 alterados |

## Publicação e Continuidade

Usa o commit:

```text
feat(dev2): CP-D2-002 - canyon light budget and cyclopean material variation
```

Publica o estado em `STATUS_CHECKPOINT_CP-D2-002_BUDGET_SILHOUETTE.md`, faz push e inicia **imediatamente** o CP-D2-003: ecologia vertical do desfiladeiro — fissuras, raízes de rocha, vegetação de altitude e guias de navegação de baixa emissão. O commit é evidência, não é uma paragem.
