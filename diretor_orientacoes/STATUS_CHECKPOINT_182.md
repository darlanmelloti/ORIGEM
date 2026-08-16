# ORIGEM — Checkpoint 182: Copas Focais de Folha Larga Ampliadas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `06f6fcb` — `feat(forest): enlarge focal canopy trees for visual variety`.

## Incremento aplicado

As sete copas focais alternadas (ISLAND_TREE e OAK_DARK) da Floresta Densa foram ampliadas de uma escala média de 0.38–0.52 para 0.52–0.64. A variação de escala entre as sete instâncias foi preservada para evitar uniformidade visual. O trilho físico permanece desobstruído com abertura superior a cinco metros a partir do eixo central.

| Posição Z | Lado | Escala anterior | Escala nova |
|---|---|---|---|
| 138 | Esquerdo | 0.48 | 0.60 |
| 146 | Direito | 0.42 | 0.56 |
| 155 | Esquerdo | 0.38 | 0.52 |
| 163 | Direito | 0.52 | 0.64 |
| 173 | Esquerdo | 0.44 | 0.56 |
| 184 | Direito | 0.40 | 0.54 |
| 196 | Esquerdo | 0.46 | 0.58 |

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Take 3 | `origem_v2_phase116_take3_forest_wayfinding.png` | Copas mais presentes; trilho desobstruído. |
| Prólogo, porta e exterior | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Majestic → lago | Roteiro integrado | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida: nenhuma alteração nas Regiões 7–12. |

## Preservação

Pacote reproduzível:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase182_LargerForestCanopies_Validated.zip`

SHA-256:

`e6c6af7aab449d2f58ebcc85020eab7cc815d85c4749d1bffff41137c225a1df`

## Próximas prioridades (por ordem de impacto visual)

1. **Fogueira animada do Acampamento Majestic** — emissão de partículas ou luz pulsante mais legível no crepúsculo de compatibilidade.
2. **Iluminação subaquática das Ruínas Submersas** — OmniLight3D submersa de baixa energia para aumentar a atmosfera fria dos pilares.
3. **Variação de altura dos troncos de coníferas** — escala Y entre 0.85–1.35 para quebrar a uniformidade das coníferas económicas.
4. **Pedras no leito do rio** — 3–4 rochas submersas para leitura de profundidade na Estrada do Rio.
5. **Auditoria de Takes 1–9** — recapturar e confirmar que todos os refinamentos dos CPs 144–182 são visíveis nos enquadramentos cinematográficos.

> O checkpoint é uma evidência, não uma pausa. O refinamento contínuo mantém-se dentro das Regiões 1–6.
