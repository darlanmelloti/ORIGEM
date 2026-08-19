# CP-CARTO-092 — Projecção do Horizonte R1→R3

## Decisão

**PASS técnico; REJECTED_VISUAL.** A sonda câmara→mundo projectou os nós visíveis para a janela normalizada do quadrante direito da captura `road_to_arch`. O único candidato devolvido foi a malha `tree_oak_dark` em `(-26.16133, 0.348372, 30.0)`, projectada em `(0.807, 0.569)`.

O carvalho foi ocultado somente no modo QA e a rota foi repetida durante 36 segundos. O ponto azul-ciano persistiu no mesmo local visual, demonstrando que a árvore não é a fonte do artefacto. A instrumentação e a ocultação foram totalmente removidas de `TempleLevel.gd` e do harness. Nenhuma geometria, material, rota ou luz de produção foi alterada.

## Evidência

| Elemento | Caminho |
|---|---|
| Lista de candidatos por projecção | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_projection/projected_candidates.txt` |
| Captura com carvalho oculto | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_projected_hide/road_to_arch_36s.png` |
| Log da ocultação QA | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_projected_hide/runtime_36s.log` |

## Próximo passo

O marcador permanece sem atribuição causal. Não repetir as hipóteses `MarcoRibeirinho` ou `tree_oak_dark`, nem aplicar filtros amplos de cor. O próximo refinamento visual deve voltar a uma lacuna ambiental mensurável e independente deste artefacto, mantendo a rota R1→R3, os marcos do mapa e a fronteira R1–R6.
