# CP-CARTO-35 — Passe de Activos da Floresta Densa

**Branch:** `feature/cine07-final`  
**Escopo:** Região 4 dentro de `ForestLakeRegion.gd`; sem módulos das Regiões 7–12.  
**Estado:** aprovado como melhoria localizada; o polimento macro continua aberto.

## Iterações avaliadas

A troca de copas focais por `tree_detailed_dark.glb` não produziu ganho perceptível na tomada Floresta→Ruínas e foi revertida. A causa estava na dispersão próxima, onde instâncias `Island Tree` maiores dominavam a câmara. A iteração aceite converte as instâncias próximas seleccionadas (`index % 7 == 0`) em `ez_pine_tall_pbr.glb`, activo já presente no repositório, preservando exactamente posições, escalas-base, rota e colisores existentes.

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** via `ORIGEM_QA_ROUTE=forest_to_ruins` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto35_pine_pbr_1600x900.png` |
| Rota de lajes Floresta→Margem | **Mantida legível e física** |
| Orçamento de luzes | **Inalterado** — sem nova luz dinâmica |
| Regiões 7–12 | **Não instanciadas pelo harness** |

## Avaliação visual

A camada lateral de pinheiros PBR cria profundidade e uma silhueta vertical mais natural na margem direita do corredor. O resultado melhora a leitura localizada, mas não é tratado como conclusão do objectivo de realismo do vale: a árvore de primeiro plano restante, a uniformidade do solo e os elementos de escala remotos permanecem em fila de refinamento.

> A continuidade automática segue para a análise de composição ampla e substituição selectiva de activos de primeiro plano, sem repetir a troca de copas focais que não demonstrou ganho.
