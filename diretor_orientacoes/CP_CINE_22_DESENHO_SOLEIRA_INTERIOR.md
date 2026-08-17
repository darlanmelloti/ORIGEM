# CP-CINE-22 — Desenho da Soleira Interior Orion

A solução inicial aprovada para teste é deliberadamente menor que os protótipos anteriores. Em vez de tentar fechar a caverna com uma abóbada ou erguer paredes de activos escalados, será criada apenas uma **soleira de três pedras baixas** entre `z=550` e `z=556`.

Cada pedra será posicionada pelo limite inferior medido e terá escala uniforme; a altura será calculada directamente com `height_at`. O caminho físico continua a ser assegurado pelo terreno e por um colisor baixo de segurança, sem uma laje visível em caixa. As pedras serão laterais e descontínuas, preservando um eixo central de 4,4 m para Elias.

| Secção | Posição Z | Papel | Regra visual |
|---|---:|---|---|
| Soleira | 550 | Marca a passagem exterior → interior | Baixa e aterrada; não fecha a boca |
| Curva | 553 | Direcciona o olhar para a Câmara | Duas pedras laterais; eixo central livre |
| Ante-câmara | 556 | Prepara a revelação do Cube | Sem mostrar altar ou emissão Chronos |

A integração só será preservada se a captura da cena principal mostrar as três leituras sem massas suspensas, sem um painel de fundo e sem a exposição exterior do Cubo.
