# ORIGEM — STATUS R4_001: Floresta Densa

**Frente:** Dev4 — Ecologia
**Região:** R4 — Floresta Densa
**Âncora:** `(-9, 116)`
**Entrada / saída:** Arco das Ruínas → Floresta Densa → Acampamento Majestic
**Estado:** **pronta para revisão de integração**, com aprovação artística final reservada à validação em GPU local.

## Entrega implementada

A Região 4 recebeu uma revisão ecológica e de desempenho no construtor `levels/ForestLakeRegion.gd`. A dispersão principal deixou de usar pares laterais previsíveis e passou a usar posições determinísticas, mas irregulares, dentro do corredor R4. A faixa central do trilho mantém uma folga mínima de seis metros, a clareira cartográfica antes do Arco não é preenchida por árvores de dispersão e o conector para R5 permanece desobstruído.

A composição passou a utilizar uma única conífera PBR como âncora focal e árvores escuras detalhadas para as massas laterais. O uso massivo de fetos 1k foi reduzido a dez instâncias de primeiro plano. Foram também removidas as luzes de balizas e de sinais P-0; a região conserva apenas o preenchimento frio central, respeitando o teto de **uma luz dinâmica local**.

| Área | Alteração | Resultado |
|---|---|---|
| Ecologia | Distribuição irregular em X/Z, massas laterais e menor repetição | Corredor permanece aberto sem parede artificial de árvores |
| Ativos | Uma conífera PBR focal; massa com árvores escuras detalhadas | Menor risco de custo excessivo e de silhuetas ciano simplificadas |
| Sub-bosque | Dez fetos, fora do conector R5 | Detalhe de primeiro plano sem dispersão pesada |
| Iluminação | 10 luzes locais R4 anteriores substituídas por 1 luz de preenchimento | Orçamento regional cumprido |
| QA | Novo `qa/regions/verify_r4_dense_forest.gd` | Rota, clareira, ecologia, neblina configurada e luzes validadas |

## Evidência técnica

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado sem erro de parser/GDScript |
| Contratos R1–R6 | Aprovados; R4 declara as rotas `arch_to_forest`, `forest_to_majestic` e `forest_to_ruins` |
| Harness isolado R4 | Aprovado: trilho, colisores, clareira, única conífera PBR, máximo de 10 fetos, neblina declarada e 1 luz local |
| Runtime real | Aprovado durante 36 segundos no fluxo Menu → Novo Jogo → `arch_to_forest`, sem `SCRIPT ERROR`, `ERROR:` fatal ou falha de recursos |
| Captura | Evidência 16:9 obtida em Xvfb; foco de teclado permanece inconclusivo nesse ambiente e não substitui movimentação manual em GPU local |

## Ficheiros da entrega

| Ficheiro | Finalidade |
|---|---|
| `levels/ForestLakeRegion.gd` | Construção e orçamento ecológico de R4 |
| `qa/regions/verify_r4_dense_forest.gd` | Auditoria automatizada específica da Região 4 |
| `reports/r4/runtime_arch_to_forest_36s_final_assets.log` | Log da sessão de 36 segundos |
| `reports/r4/STATUS_R4_001.md` | Este marcador de continuidade |

## Próxima tarefa explícita

Executar a revisão visual em máquina com GPU local na rota `arch_to_forest`, avaliando a densidade percebida, a presença de neblina baixa e o enquadramento da Montanha Orion. A revisão não deve alterar a clareira aprovada, o trilho físico, o orçamento de uma luz local ou as fronteiras de R5–R6.

> A evidência demonstra estabilidade e conformidade técnica da região. A aprovação estética definitiva requer observação em GPU local, onde a vegetação, o renderizador Compatibility e a câmara de gameplay devem ser julgados em movimento.
