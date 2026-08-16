# ORIGEM — Checkpoint 184: Iluminação Subaquática das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `19d34da` — `feat(lake): add submerged cold fill lights for atmospheric depth`.

## Incremento aplicado

Duas OmniLight3D submersas foram adicionadas ao nó `RuinasSubmersasDoLago` para simular refração subaquática no gl_compatibility sem SSR nem SDFGI:

**Luz submersa central (`LuzSubaquaticaCentral`):** posicionada a y=−1.80 (abaixo da lâmina de água), cor azul-fria (0.06, 0.28, 0.52), energia 1.40, alcance 38 m. Cria um brilho frio que sobe pelos pilares a partir do fundo.

**Luz submersa lateral (`LuzSubaquaticaLateral`):** deslocada para o quadrante dos pilares mais altos (x=14, y=−2.40, z=8), cor azul-escura (0.04, 0.22, 0.44), energia 0.90, alcance 26 m. Destaca a silhueta de colapso dos pilares irregulares.

| Parâmetro | Luz Central | Luz Lateral |
|---|---|---|
| Posição Y | −1.80 | −2.40 |
| Cor | Azul-fria (0.06, 0.28, 0.52) | Azul-escura (0.04, 0.22, 0.44) |
| Energia | 1.40 | 0.90 |
| Alcance | 38 m | 26 m |
| Sombras | Desativadas | Desativadas |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 11 | `origem_v2_phase118_take11_majestic_lake_transition.png` | Água com brilho azul-frio visível; pilares com contraste melhorado. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase184_SubmergedLighting_Validated.zip`

SHA-256:

`a91c1068984189a880390ff4abee1b00bf7dcc373f5f0ff00e6fc4b230f76e91`

## Próximas prioridades (por ordem de impacto visual)

1. **Variação de altura dos troncos de coníferas** — escala Y entre 0.85–1.35 para quebrar a uniformidade das coníferas económicas.
2. **Pedras no leito do rio** — 3–4 rochas submersas para leitura de profundidade na Estrada do Rio.
3. **Auditoria de Takes 1–9** — recapturar e confirmar que todos os refinamentos dos CPs 144–184 são visíveis nos enquadramentos cinematográficos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
