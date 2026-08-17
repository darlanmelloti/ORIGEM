# CP-CINE-32 — Reversão da Abóbada Isolada

O protótipo de abóbada contínua foi construído abaixo do terreno e validado em sintaxe. A captura da cena principal, contudo, continuou a expor céu e o limite inferior do terreno em vez de revelar o volume. Isto torna a evidência visual inválida; o módulo não será aceite nem integrado.

A reversão removeu o script de abóbada, a sua instanciação em `OrionDestinationRegion` e o estágio QA de câmara associado. Mantêm-se intactos a garganta exterior CP-CINE-24, o gatilho físico CP-CINE-28 e a soleira/primeira secção física CP-CINE-30.

## CP-CINE-33 já iniciado

O próximo ciclo diagnostica a relação entre coordenadas globais de terreno, transformações de módulos e câmara QA. Não criará novo interior antes de produzir uma leitura de câmara verificavelmente colocada no volume pretendido.
