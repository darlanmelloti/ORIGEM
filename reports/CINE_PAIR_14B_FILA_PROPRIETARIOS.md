# CINE-PAIR-14B — Fila de Proprietários após Take 3

## Estado

**EM EXECUÇÃO MATERIAL.** Este ficheiro foi iniciado antes de qualquer checkpoint do CINE-PAIR-14A, cumprindo a regra de que uma captura nunca encerra o ciclo Dev3.

## Evidência Take 3

A recaptura normal Arco→Floresta foi concluída com 36 segundos de execução e imagem 1600×900 no segundo 30.

> Evidência: `director_evidence/cine_pair_14a_take3_arch_forest/arch_to_forest_36s.png`

## Leitura cinematográfica e encaminhamento

| Lacuna visível | Efeito no Take 3 | Proprietário | Pedido específico |
|---|---|---|---|
| Laje flutuante no primeiro plano | Quebra o aterramento e a profundidade do caminho | Dev1 | Auditar a cota da laje e o alinhamento ao TerrainPatch sem alterar o eixo cartográfico |
| Marcador azul-ciano lateral | Polui a leitura natural do limiar | Dev1 | Atribuir por camada de renderização; não esconder candidatos por tentativa |
| Coníferas com leitura azulada e silhueta repetida | Reduz a credibilidade de floresta e escala | Dev1/Dev6 | Validar um candidato ambiental real, dentro do LOD e sem parede vegetal |
| Take 3 ainda não mostra R7–R12 | Não é falha do Take 3; é fronteira narrativa | Dev3/Dev2 | Preparar matriz separada de handoff R7–R12, sem alterar geometria Dev2 |

## Próxima acção material já iniciada

A matriz do `CINE-PAIR-14C` será criada para o handoff R7–R12, com a mesma exigência de FOV bloqueado, captura de 30 segundos e auditoria de luzes. Esta acção não altera a geometria do Dev2 e não espera por resposta dos proprietários acima.
