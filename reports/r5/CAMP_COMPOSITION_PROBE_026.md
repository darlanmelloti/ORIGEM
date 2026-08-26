# Sonda de Composição do Acampamento Majestic — 026

**Tarefa:** `DEV5-R5-CAMP-COMPOSITION-PROBE-026`
**Estado:** Aprovada por QA; sem alteração de produção.

## Resultado determinístico

A sonda instanciou a região e confirmou sete alvos existentes do núcleo do Acampamento Majestic: mesa de cartografia, mapa de expedição, três rolos de campo e duas lonas de chegada. O centro de leitura calculado é `(-85,46; 1,71; 178,41)` e a posição recomendada exclusivamente para uma câmara de QA futura é `(-77,46; 6,51; 188,41)`.

> A recomendação não altera a `Camera3D` do jogador, nem cria qualquer câmara, geometria, luz, shader, física ou animação em produção.

## Garantias verificadas

| Critério | Resultado |
|---|---|
| Alvos existentes de composição | 7 de 7 localizados |
| Luzes locais R5 | 4 preservadas; 0 criadas |
| `forest_to_majestic` | PASS |
| `majestic_to_lake` | PASS |
| Porta R5 cumulativa | PASS |
| Produção partilhada | Não modificada |

## Próxima tarefa

`DEV5-R5-CAMP-COMPOSITION-POSTPROBE-027` deve capturar o núcleo do acampamento a partir da posição QA recomendada, comparar legibilidade com as capturas de rota existentes e selecionar, no máximo, uma intervenção modular futura em elemento R5 existente. A tarefa continua proibida de alterar `ForestLakeRegion.gd`, câmara do jogador, âncoras, luz, colisores, física ou rotas.
