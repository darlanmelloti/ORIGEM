# CP 225 — Topologia Cartográfica Floresta → Majestic

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 4–5; fronteira das Regiões 7–12 mantida intacta.

## Alteração

A transição da Floresta Densa para o Acampamento Majestic passou a calcular os pontos estruturais a partir de `CartographicAnchors.gd`.

| Elemento | Âncora aplicada | Resultado físico |
|---|---|---|
| Limiar da Floresta Densa | `FLORESTA_DENSA_ENTRADA` | Árvores, rochas e fetos acompanham a entrada real do bosque. |
| Acampamento Majestic | `ACAMPAMENTO_MAJESTIC` | Centro do acampamento deixa de depender de coordenadas isoladas. |
| Conector Majestic–trilho | `ACAMPAMENTO_MAJESTIC` | Lajes, colisores e margem ecológica preservam a transição contínua até ao eixo florestal. |

A geometria, os colisores e o orçamento de luzes existentes foram preservados. A alteração é espacial: liga os marcos físicos 4 e 5 à mesma planta que o jogador consulta no mapa por `M`.

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 226 — Bacia central cartográfica.** O próximo ciclo alinha as Ruínas Submersas e as margens do lago ao marco 6, tornando a leitura Floresta → Acampamento → Lago ainda mais fiel ao centro hídrico da cartografia.
