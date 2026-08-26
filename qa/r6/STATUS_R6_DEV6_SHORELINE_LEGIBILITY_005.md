# ORIGEM — DEV6-R6-SHORELINE-LEGIBILITY-005

**Estado:** concluída localmente
**Responsável:** dev6
**Âmbito exclusivo:** R6 — Ruínas Submersas

## Diagnóstico

A captura `ruins_arrival` em 1600×900 mostrou que a rota e a estela estavam ativas, mas a linha de água e as ruínas não apresentavam leitura arqueológica clara em todos os ângulos iniciais. A sonda de geometria confirmou que a água está a `0,820 m` acima da cota de referência, que a estela existe em `(52, 2,27, 231)` e que os nove detritos WATERLINE-003 estão presentes.

## Correção causal

A correção cria `R6_LeituraArqueologicaDaMargem` dentro de `_build_waterline_reading()`. A composição contém um fragmento de coluna e duas pedras assimétricas na margem exterior oeste, em coordenadas externas à elipse de água e ao corredor de chegada. Os três objetos são exclusivamente visuais: não criam `Light3D`, shader, emissão, painel, `StaticBody3D` ou `CollisionShape3D`.

## Evidências de validação

| Verificação | Resultado |
|---|---|
| Sonda de composição | 9 detritos, 3 vestígios de chegada, 0 luzes, 0 colisores |
| Parser Godot 4.7.1 | Aprovado |
| Orçamento R6 | Quatro luzes aprovado |
| Handoff R6→R7 | Aprovado |
| `forest_to_ruins` | Aprovada |
| `majestic_to_lake` | Aprovada |
| `ruins_arrival` | Aprovada |
| `git diff --check` | Aprovado |

As evidências visuais e logs foram arquivados fora do repositório para revisão, sem introduzir imagens ou artefatos de renderer no diff de produção.

## Próxima tarefa ACTIVE

`DEV6-R6-APPROACH-FRAMING-006`: validar se o enquadramento de chegada comunica a bacia, a estela e a margem arqueológica de forma coerente em `gl_compatibility`. A tarefa permanece exclusiva de R6, não altera R7–R12 e não pode introduzir luz, shader, emissão, painel ou colisão nova.
