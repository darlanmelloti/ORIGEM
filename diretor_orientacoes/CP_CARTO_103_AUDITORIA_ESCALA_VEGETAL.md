# CP-CARTO-103 — Auditoria de Escala Vegetal Casa Voss→Arco

## Resultado estático

O corredor `RiverRoadJourney` declara seis núcleos arbóreos espaçados e mantém a janela sem árvores entre `z=80` e `z=94` para não ocultar o Arco. Os modelos de referência carregados são `PINE_MEDIUM`, `DARK_TREE`, `OAK_DARK` e `FERN`.

A Casa Voss é a fonte com maior peso visual de vegetação: utiliza árvores de profundidade em escala elevada, um sobreiro hero e uma árvore de estrada, além de vegetação periférica. Essa composição explica porque o enquadramento de saída apresenta copas altas mas pouca diferenciação de espécie no horizonte.

| Sector | Situação | Decisão |
|---|---|---|
| Estrada do Rio | Seis núcleos espaçados; janela do Arco preservada | Não densificar |
| Casa Voss | Várias instâncias LOD e hero assets | Auditar por tomada antes de mexer |
| LOD e limites | O corredor respeita a intenção de evitar paredes vegetais | Não trocar modelos de forma cega |

## Próxima hipótese permitida

O próximo passe deve ser uma **recaptura lateral de saída da Casa Voss**, sem alterar activos, para verificar se o excesso percebido é escala, espécie, posição ou apenas a câmara de avaliação. Não repetir o pinheiro PBR focal, a composição de planos simples ou a árvore detalhada isolada já rejeitada.
