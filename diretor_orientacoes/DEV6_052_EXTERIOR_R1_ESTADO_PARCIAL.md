# DEV6-052 — Exterior Vivo R1: Estado Parcial

A integração exterior R1 passou o parser e a rota `road_return_voss` durante 36 segundos, com 7/7 contactos de grounding e X/Z preservado. A Casa Voss, a porta, Elias e a câmara não foram alterados.

A captura, porém, mostrou a malha do cervo visualmente elevada em relação ao solo. O contrato do nó raiz é válido, mas o offset interno do recurso CC0 exige correcção de apresentação. O passe seguinte reduz somente o offset Y da malha do cervo; não altera o grounding do nó, as coordenadas X/Z nem os elementos da Casa Voss.

## Incidente de evidência

A segunda captura R1 registou a câmara abaixo do terreno depois de entrada automática contínua. A telemetria de 36 segundos, o parser e o grounding 7/7 permaneceram válidos; o defeito pertence à sequência de entrada do harness, não à Casa, porta, jogador ou candidato exterior. A próxima sessão limitará o deslocamento inicial à janela comprovadamente segura e manterá o processo activo durante os 36 segundos completos.

## Recaptura estável

A sessão ajustada completou 36 segundos com o primeiro deslocamento real limitado a quatro segundos e sem nova captura sob o terreno. O grounding 7/7, o X/Z e a rota mantiveram-se válidos. A compensação interna do cervo reduziu a leitura de flutuação.

A decisão visual global permanece `REJECTED_VISUAL`: a vista de primeira pessoa mantém a arma no enquadramento e os taludes/activos ainda revelam a fase técnica. A integração R1 pode permanecer como candidato técnico reversível, não como promoção visual final.
