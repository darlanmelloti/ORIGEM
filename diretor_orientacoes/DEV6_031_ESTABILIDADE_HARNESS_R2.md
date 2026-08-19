# DEV6-031 — Estabilidade do Harness R2

O harness externo mantém a execução determinística de 36 segundos: limpa as capturas anteriores, inicia Xvfb, define `ORIGEM_QA_ROUTE=road_to_arch`, mantém `W` pressionado, captura um frame intermédio e um final e acrescenta a telemetria de duração ao log.

A actualização Dev5 `f96d569` valida a composição aterrada R1/R2, mas altera apenas documentação e log de regressão. Não publica câmara de terceira pessoa, código de jogador ou prova `road_to_arch` na configuração exigida por DEV6-014.

| Verificação | Resultado |
|---|---:|
| Script QA R2 | PASS — entradas, capturas e telemetria explicitadas |
| Evidência Dev5 de grounding R1/R2 | PASS como referência técnica |
| Câmara de terceira pessoa R2 | Não publicada |
| Recaptura de terceira pessoa | Não disponível |
| Aceitação visual R2 | Mantém `REJECTED_VISUAL` |

Dev6 continuará pronto para aplicar a matriz de recaptura assim que a frente proprietária publicar uma evidência válida.
