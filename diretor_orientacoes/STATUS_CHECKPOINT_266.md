# CP 266 — Profundidade macro da Estrada do Rio

**Estado:** ciclo contínuo em execução; passe técnico e físico validado, composição cinematográfica ainda em refinamento.

## Alterações aplicadas

O corredor Casa Voss → Estrada do Rio → Arco das Ruínas recebeu camadas laterais de afloramentos de rocha e vestígios arqueológicos, sem colisores no eixo da rota. A malha de terreno passou a manter a faixa jogável baixa e a elevar gradualmente os ombros a partir da margem da Estrada. Este perfil forma uma bacia longitudinal perceptível, preservando o Arco em `z=92` e evitando a compressão artificial do mapa.

A materialidade do leito da Estrada foi elevada para manter uma linha de leitura castanho-pedra entre as lajes. A prova de presença regional confirmou a construção simultânea de `EstradaDoRioExploravel`, `SoloCompactadoEstradaDoRio`, `ArcoDasRuinas_EstradaDoRio` e `RegiaoFlorestaLagoExploravel`.

## Validação

| Prova | Resultado |
|---|---|
| Carregamento headless Godot 4.7.1 | Aprovado, sem erro de parser ou recurso |
| Sonda regional headless | Aprovada; Estrada, Arco e Floresta presentes |
| Captura em display isolado | Aprovada; corredor, camadas laterais e Arco visíveis |
| Exploração | Mantida em curso pelo ciclo segmentado devido ao limite conhecido do llvmpipe |

## Limitação conhecida e próximo ciclo

A composição ainda não atinge a referência de vale monumental: a camada hídrica lateral e a leitura de ruínas do rio precisam de maior presença antes da recaptura Dev3. O **CP 267 — Hidrologia lateral e profundidade da margem** está iniciado pelo marcador Dev1. Nenhum módulo das Regiões 7–12 foi alterado.
