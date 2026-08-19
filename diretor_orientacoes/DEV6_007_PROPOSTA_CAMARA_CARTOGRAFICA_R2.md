# DEV6-007 — Proposta de Câmara Cartográfica R2

## Observação da evidência actual

A rota `road_to_arch` passou tecnicamente, mas a câmara QA actual é em primeira pessoa e deixa a espada ocupar uma zona dominante do primeiro plano. O corredor surge correcto e desimpedido, contudo o Arco e as novas camadas laterais aparecem pequenos, sem uma relação clara entre Elias, o percurso e a profundidade do vale. Esta limitação não é um defeito de colisão, grounding ou LOD R2; é uma limitação de enquadramento.

| Elemento | Estado na captura actual | Recomendação ao proprietário |
|---|---|---|
| Perspectiva | Primeira pessoa; espada domina o terço direito | Usar câmara de terceira pessoa atrás de Elias na evidência cartográfica |
| FOV | Amplo para leitura de detalhe, fraco para escala | FOV entre 52° e 56° para conservar profundidade do Arco |
| Altura | Ao nível do olhar | Elevar ligeiramente a câmara, mantendo Elias inteiro e o trilho no terço inferior |
| Eixo | Estrada e Arco apenas parcialmente enquadrados | Apontar o foco para o Arco em z≈92 e manter a curva da estrada no centro |
| Escala ambiental | Existe, mas é periférica | Recuar a câmara 2–3 m e enquadrar uma silhueta lateral por lado sem bloquear a rota |

> **Contrato para Dev1/Dev3:** esta proposta não pede alteração da rota, do jogador de produção, dos X/Z cartográficos ou dos módulos Dev6. Pede exclusivamente uma câmara de evidência de terceira pessoa que revele Elias, Estrada do Rio, Arco e planos laterais numa só leitura.

## Resultado Dev6

O DEV6 não alterou a câmara nem o jogador, respeitando o escopo de arte técnica. A recomendação está pronta para implementação pelo proprietário de gameplay/cinemática, devendo a recaptura reutilizar o mesmo harness `road_to_arch` durante 36 segundos.
