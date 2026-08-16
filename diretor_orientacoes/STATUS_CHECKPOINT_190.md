# ORIGEM — Checkpoint 190: Luz de Preenchimento do Take 9

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `ffc0ad2` — `feat(lighting): add take-9 corridor fill light for panoramic legibility`.

## Incremento aplicado

Foi adicionada uma `OmniLight3D` de preenchimento no corredor do Take 9, posicionada em `(-68.0, 8.5, 172.0)` com cor azul-fria (`0.28, 0.34, 0.40`), energia `0.85` e alcance `52 m`. A luz ilumina o solo frontal do conector Majestic–lago sem criar sombras, melhorando a leitura da composição panorâmica sem comprometer o orçamento visual da GTX 1050.

| Parâmetro | Valor |
|---|---|
| Posição | `(-68.0, 8.5, 172.0)` |
| Cor | Azul-fria `(0.28, 0.34, 0.40)` |
| Energia | `0.85` |
| Alcance | `52 m` |
| Sombras | Desativadas |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 9 | `origem_v2_phase123_take9_majestic_connector.png` | Composição panorâmica estável; fogueira visível; trilho de lajes legível; solo frontal com leitura melhorada. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase190_Take9FillLight_Validated.zip`

SHA-256: `7157efba029756c7cf4516293adaa693c3f2ce7129148191b7deb2662a3f2cdd`

## Próximas prioridades (por ordem de impacto visual)

1. **Nota de direção sobre o Take 6** — remover ou transferir para a branch `dev2` o take que aponta para z=462–535.
2. **Passe de materialidade das lajes de margem do lago** — as lajes de chegada ao lago têm material uniforme; variar a escala e a rugosidade aumentaria a leitura orgânica.
3. **Segundo passe de auditoria de Takes 1–11** — confirmar que os refinamentos dos CPs 182–190 são visíveis em todos os enquadramentos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
