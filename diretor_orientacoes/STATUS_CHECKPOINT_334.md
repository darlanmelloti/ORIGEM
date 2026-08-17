# STATUS CHECKPOINT 334 — Macrotextura de terreno revertida

**Estado:** teste concluído e revertido por ausência de ganho perceptível.

## Hipótese

A tomada macro apresentava granularidade intensa no solo do vale. Foi aplicada uma calibração experimental e reversível ao shader de `TerrainPatch.gd`: menor frequência de ruído, amostras PBR mais largas e normal menos acentuada. A malha, a escala do mapa, a rota, a colisão e as Regiões 7–12 permaneceram intocadas.

## Resultado

A validação headless passou e a captura `qa_evidence_voss_vista/cp334_ground_macro.png` foi comparada com a base. A alteração não gerou ganho suficientemente perceptível na leitura do solo nem aproximou a tomada da referência; manter o shader introduziria complexidade sem benefício verificável.

O shader foi restaurado integralmente a partir da base publicada. O CP 334 não altera o estado jogável.

## Continuidade

A próxima melhoria de alto impacto continua dependente da cadeia remota R7–R9, atribuída ao Dev2 no CP-CINE-06. A matriz CP-CINE-07 permanece a autoridade para a recaptura Casa Voss assim que houver integração física remota.
