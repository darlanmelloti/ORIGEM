# Auditoria Regional Dev2 — Regiões 7–12

## Resultado executivo

A auditoria foi executada na branch `feature/dev2-mountain-canyon` com o código activo existente, sem reescrita da base e sem tocar nas Regiões 1–6. Cada região recebeu validação headless e captura formal; as Regiões 8, 10, 11 e 12 também foram executadas através dos seus harnesses dedicados quando a captura principal revelou enquadramento não representativo.

O resultado técnico é **PASSED** para parser/runtime nas seis regiões. O resultado visual é **PASSED_WITH_FOLLOWUP**: as Regiões 7–10 têm rota e wayfinding legíveis com passes incrementais já publicados; a Região 11 precisa de captura dedicada representativa; a Região 12 recebeu uma correcção de harness e um passe de polimento visual com assets orgânicos, céu procedural e fog de baixo custo.

## Matriz final por região

| Região | Harness / fonte | Headless | Evidência 30s + 1600×900 | Avaliação visual | Próxima acção |
|---|---|---:|---:|---|---|
| 7 | `scenes/main.tscn` | PASS | PASS — gameplay `68c343ee…`, print `35f7ffa9…` | Rota legível, relevo demasiado uniforme | Reforçar âncora vertical e contraste alpino sem alterar a rota |
| 8 | `scenes/Take8Validation.tscn` | PASS | PASS — gameplay `c7a0f230…`, print `115b3c07…` | Trilha ascendente legível; destino distante comprimido no frame | Ajustar enquadramento da trilha e manter wayfinding frio discreto |
| 9 | `scenes/main.tscn` | PASS | PASS — gameplay `1125c789…`, print `75a53d5a…` | Limiar físico existe, mas o frame ainda é dominado pelo exterior anterior | Captura dedicada do limiar e reforço de escala do destino |
| 10 | `scenes/Region10Validation.tscn` | PASS | PASS — gameplay `dd42fcd5…`, print `594835ff…` | Boca, fissuras e luzes legíveis; núcleos demasiado intensos | Contenção de brilho, preservando luz de segurança |
| 11 | `scenes/Region11Validation.tscn` | PASS | PASS — gameplay `b98649d8…`, print `0da2fbb1…` | Câmara dedicada executa; evidência requer nova leitura de saída para Hub | Repetir captura com percurso Câmara→Hub enquadrado |
| 12 | `scenes/Region12Validation.tscn` | PASS | PASS — gameplay `4cef5f05…`, print `5818f201…` após polimento | Cúpula finalmente representada; silhueta ainda baixa no frame | Aproximar ligeiramente a câmara e reforçar a base/santuário |

## Correcção técnica efectuada nesta auditoria

A validação dedicada da Região 12 revelou uma atribuição inválida de `material_override` ao `Node3D` raiz de um asset CC0. O harness foi corrigido para aplicar o material aos `MeshInstance3D` internos. O mesmo passe substituiu a base cilíndrica do proxy por `stone_largeB.glb`, adicionou céu procedural violeta, fog de baixa densidade e preservou a pulsação do núcleo. O runtime voltou a passar sem `SCRIPT ERROR`.

## Evidência formal

O QA integrado usado foi `validation/test_checkpoint_cp_d2_regions7to12_continuity.sh`. Para a Região 12, o resultado final do passe polido é:

| Artefacto | SHA-256 |
|---|---|
| Gameplay 30s | `4cef5f059c9e492ded947d0776b1906093e605856180897bdda6e2546a38f852` |
| Print 1600×900 | `5818f20147194da2eb94dc30d5fbd256f5ab69336c465bf5662641e5c09a07ad` |

As conclusões visuais completas estão em `evidence/auditoria-regioes-7-8-findings.md`, `evidence/auditoria-regioes-9-10-findings.md`, `evidence/auditoria-regioes-11-12-findings.md` e `evidence/auditoria-regiao-12-polish-findings.md`.

## ⚡ ESTADO ATUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 7–12 — auditoria concluída, polimento incremental em continuidade
- **STATUS_CODE**: PASSED_WITH_FOLLOWUP
- **TAREFA_EM_EXECUCAO_AGORA**: empacotar o relatório e as evidências regionais, commitar e sincronizar o checkpoint de auditoria
- **TARGET_REGION**: Região 11 → Região 12
- **NEXT_ACTION_IMMEDIATE**: capturar a saída Câmara do Orion Cube→Hub Temporal e aproximar a câmara da Cúpula Final no próximo passe
- **SCOPE_LOCK**: `REGIONS_7_12_ONLY`
- **DEADLINE_PROXIMO_PUSH**: próximo ciclo de 30 minutos

## Decisão

A base regional não será reescrita. A equipa continuará com passes pequenos, orgânicos e auditáveis, tratando falhas de evidência como gatilhos para nova captura e não como motivo para encerrar o desenvolvimento.
