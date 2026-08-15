# ORIGEM — Checkpoint 133: Floresta Densa Fisicamente Navegável

**Branch:** `feature/dev1-gameplay-core`
**Escopo permitido:** Regiões 1–6; implementação focada na Região 4 — Floresta Densa.
**Estado:** validado e preservado localmente; pronto para commit e sincronização quando a autenticação GitHub estiver disponível.

## Incremento contínuo

Um subconjunto de troncos focais da Floresta Densa recebeu colisores cilíndricos aterrados, dimensionados pela escala de cada árvore. A alteração dá presença física à floresta e impede atravessamento de troncos selecionados, sem preencher o corredor de lajes com obstáculos ou saturar o orçamento de colisões para a GTX 1050.

A distribuição preserva a regra de afastamento do trilho central e da bacia das Ruínas Submersas. As lajes físicas e as balizas de orientação continuam a definir um percurso claro entre o Arco das Ruínas, o Acampamento Majestic e o lago.

| Verificação | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado. |
| Take 3 | Captura concluída; trilho permanece aberto entre a vegetação. |
| Gameplay | 30 segundos estáveis, sem `Parse Error` nem falha de carregamento. |
| Colisão | Troncos focais selecionados usam cilindros aterrados; trilho central livre. |
| Fronteira | Nenhuma alteração nas Regiões 7–12. |

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `origem_v2_phase116_take3_forest_wayfinding.png` | Evidência visual da floresta e do percurso. |
| `origem_v2_phase113_twilight_stable_30s.png` | Evidência de gameplay estável. |
| `ORIGEM_V2_RegionalWorld_Phase133_DenseForestPhysical_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase133_DenseForestPhysical_Validated.sha256` | SHA-256 `b04a1a7a3e5071d19c74983d18d0675fd60580d26c9d08071154e715baa6b9b1`. |

> O checkpoint é evidência. A consolidação automática das Regiões 1–6 continua ativa.
