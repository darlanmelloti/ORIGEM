# ORIGEM — Checkpoint 183: Fogueira do Acampamento Majestic Reforçada

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `944c947` — `feat(camp): enhance campfire with ember core and stronger fire light`.

## Incremento aplicado

A fogueira do Acampamento Majestic recebeu três melhorias coordenadas para aumentar a legibilidade no crepúsculo de compatibilidade (gl_compatibility / llvmpipe):

**Chama principal (`FogoDoAcampamento`):** raio aumentado de 0.34 para 0.38, emissão subida de 1.6 para 2.4, cor de emissão mais saturada em laranja-âmbar.

**Núcleo de brasa (`BrasaCentralDoAcampamento`):** nova esfera emissiva de raio 0.18 posicionada ao nível do solo (y=0.14), com emissão vermelho-âmbar de energia 1.8. Cria a leitura de profundidade de um leito de brasas.

**Luz principal (`LuzPrincipalDaFogueira`):** energia aumentada de 2.10 para 3.2, alcance expandido de 14 para 18 metros. Ilumina as tendas e o solo do acampamento com mais presença.

**Luz de brasa do solo (`LuzDeBrasaDoSolo`):** nova OmniLight3D de baixa energia (1.6) e alcance curto (6 m) ao nível do anel de pedras, com tom vermelho-âmbar quente.

**Flicker de escala:** amplitude ampliada de ±7% para ±18%, com frequência e fase distintas por instância para evitar sincronismo visual.

| Parâmetro | Antes | Depois |
|---|---|---|
| Raio da chama | 0.34 | 0.38 |
| Emissão da chama | 1.6 | 2.4 |
| Energia da luz principal | 2.10 | 3.2 |
| Alcance da luz principal | 14 m | 18 m |
| Núcleo de brasa | Ausente | Presente (emissão 1.8) |
| Luz de brasa do solo | Ausente | Presente (energia 1.6, alcance 6 m) |
| Amplitude do flicker | ±7% | ±18% |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 10 | `origem_v2_phase122_take10_majestic_physical.png` | Fogueira visível como ponto de luz âmbar no centro do acampamento. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase183_CampfireEnhanced_Validated.zip`

SHA-256:

`65e203c2abba9296e2d300b6d6ee9175298fe250ed0c9b8d2e7ca0999ca1ee64`

## Próximas prioridades (por ordem de impacto visual)

1. **Iluminação subaquática das Ruínas Submersas** — OmniLight3D submersa de baixa energia para aumentar a atmosfera fria dos pilares.
2. **Variação de altura dos troncos de coníferas** — escala Y entre 0.85–1.35 para quebrar a uniformidade das coníferas económicas.
3. **Pedras no leito do rio** — 3–4 rochas submersas para leitura de profundidade na Estrada do Rio.
4. **Auditoria de Takes 1–9** — recapturar e confirmar que todos os refinamentos dos CPs 144–183 são visíveis nos enquadramentos cinematográficos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
