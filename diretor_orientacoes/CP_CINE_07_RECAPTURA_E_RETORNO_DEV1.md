# CP-CINE-07 — Recaptura Casa Voss e retorno de eixo R6→R7

A integração Dev2 foi publicada na branch `feature/dev2-mountain-canyon` no commit `e4a9d7d`. A cadeia R7 contém terraços de passagem, borda baixa da vila e contrafortes físicos em profundidade, sem painéis ou compressão da cartografia.

A recaptura Casa Voss em `cp_cine07_casa_voss_dev2_integration.png` preservou a escala do vale e não introduziu regressão na base CP317/CP331. A nova cadeia começa depois de R6 (`z≈288`), pelo que não obteve ganho perceptível a partir da Casa Voss; a leitura correcta foi confirmada pelo harness de handoff R6→R7.

> A evidência de handoff isolou a obstrução real: `ArvoreFocalMargem_02` de `ForestLakeRegion.gd`, coordenada base `(61, 290)`, atravessa o cone da aproximação a partir de `(30, 282)`. Quando ocultada apenas no harness, os terraços e a Vila Elevada permanecem legíveis. A árvore não pertence à cadeia Dev2 e será tratada no CP 338 por Dev1.

## Próxima tarefa já em curso: CP 338

Reposicionar `ArvoreFocalMargem_02` para o bordo da margem R6, fora da estrada `R6→R7`, mantendo vegetação orgânica lateral e sem alterar quaisquer módulos R7–R12. Depois da validação de 30 segundos, o CP-CINE-07 será repetido na branch de integração com a mesma matriz de câmara.
