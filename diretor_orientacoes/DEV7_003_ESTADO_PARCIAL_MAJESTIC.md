# DEV7-003 — Estado Parcial do Abrigo CC0 Majestic

A captura contextual prova que o abrigo CC0 é carregado correctamente com Elias, fauna e corredor livre. Contudo, permanece **REJECTED_VISUAL**: terreno plano, vegetação insuficiente e silhuetas ainda técnicas.

Nenhuma promoção ao mapa real é autorizada. A próxima iteração deve manter o mesmo abrigo e corredor, mas substituir o plano por relevo orgânico e melhorar a composição vegetal de plano médio e distante sem formar parede florestal.

## Passe de composição — relevo, luz e câmara

A primeira recomposição elevou claramente a leitura do abrigo: Elias, o abrigo CC0 e um cervo são simultaneamente visíveis; a rota continua livre, o grounding passou e a luz quente define a estrutura. A captura de 1920×1080 ainda permanece **REJECTED_VISUAL**. O plano distante está excessivamente vazio, o solo mantém leitura de material único e a silhueta do proxy de Elias continua demasiado técnica para uma promoção de produção.

A próxima iteração pode apenas acrescentar acentos orgânicos de baixa densidade — afloramentos rochosos existentes e uma atmosfera mais graduada — sem construir um muro vegetal, deslocar X/Z cartográfico ou aumentar o orçamento de uma luz dinâmica.

## Passe de solo texturizado — melhoria parcial

A textura `regional_wet_forest_floor.png` foi aplicada com UVs reais à malha de relevo. O parser Godot e uma sessão de 36 segundos passaram sem erro; a clareira deixou de ler como um plano verde uniforme e preservou 15 aterramentos, duas faunas, nove vegetações, três afloramentos e uma única luz dinâmica.

A captura mostra ganho material inequívoco, mas a avaliação permanece **REJECTED_VISUAL**: o horizonte atmosférico é pouco informativo e a apresentação provisória de Elias ainda expõe uma silhueta técnica. O abrigo CC0, a textura de solo e o contrato de rota mantêm-se como base; nenhuma promoção ao mapa real é autorizada antes de uma recaptura de terceira pessoa com Elias artístico e planos distantes legíveis.

## Passe de enquadramento — decisão actual

A recaptura final passou o parser Godot e 36 segundos de gameplay: `grounded=15`, corredor livre, fauna a mais de 27 m, textura de solo carregada, três afloramentos e exactamente uma luz dinâmica. A moldura passou a mostrar Elias, abrigo e cervo sem bloquear a rota.

A captura ainda não alcança a referência de mundo real e fica **REJECTED_VISUAL**. A silhueta provisória de Elias e a linha de horizonte sem geometria regional tornam prematura qualquer promoção do abrigo ao mapa de produção. O próximo trabalho legítimo deixa de ser acumular elementos na clareira QA: é entregar a ficha de recaptura para Dev1/Dev3 aplicar a câmara de terceira pessoa e os planos distantes no mundo de produção, preservando este contrato técnico como candidato reversível.
