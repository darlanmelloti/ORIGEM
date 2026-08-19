# CP-D5-072 — Auditoria de reversibilidade Dev5

**Objectivo:** demonstrar que os previews técnicos Dev5 podem ser removidos sem afectar módulos regionais de produção ou conteúdo Dev2.

## Previews incluídos

| Preview QA | Papel | Referência de produção proibida | Estado |
|---|---|---|---|
| `EliasForestClearancePreview.tscn` | Corredor Elias R4 | `ForestLakeRegion.gd`, `TempleLevel.gd` | Isolado |
| `EliasMajesticClearancePreview.tscn` | Corredor/pavilhão R5 | `ForestLakeRegion.gd`, `TempleLevel.gd` | Isolado |
| `R6EliasVegetationReadPreview.tscn` | Margem e baliza R6 | `ForestLakeRegion.gd`, `TempleLevel.gd` | Isolado |
| `EliasR6R7HandoffPreview.tscn` | Handoff de baliza R6→R7 | módulos R7–R12 | Isolado |

## Critérios de reversão

| Verificação | Resultado requerido |
|---|---|
| Caminho | Código e cenas dentro de `levels/dev5/` |
| Referências directas | Zero preloads dos módulos regionais de produção |
| Saída de produção | `production_modules_changed=false` em provas R4/R6/R6→R7 |
| Dev2 | Nenhuma geometria ou script R7–R12 criado por Dev5 |
| Remoção | Apagar uma cena preview não deixa dependência inversa em R1–R6 |

## Decisão

> Os previews são instrumentos de validação e **não dependências de runtime**. A sua remoção elimina apenas a prova Dev5 correspondente; qualquer integração posterior exige implementação explícita do proprietário Dev1/Dev2, validação técnica e gameplay regional de 30 segundos.

## Próxima tarefa automática

**CP-D5-073 — Auditoria de cobertura de regressão.** Mapear as provas Dev5 R1–R6 para lacunas ainda sem harness e seleccionar a próxima melhoria de fundação permitida, sem repetir candidatos rejeitados.
