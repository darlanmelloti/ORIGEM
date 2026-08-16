# CP 250 — Orientação de Elias na Cartografia

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** mapa cartográfico e Regiões 1–6.

## Implementação

O marcador azul de Elias no mapa recebeu uma seta geométrica dourada, com sombra de alto contraste. A seta recebe a rotação mundial de Elias em cada frame; assim, a posição e a direcção do jogador são apresentadas na mesma convenção espacial do mapa cartográfico.

A primeira implementação com glifo tipográfico foi substituída por uma geometria explícita após a auditoria visual. Um erro de compatibilidade entre `Polygon2D` e `mouse_filter` foi identificado, corrigido e revalidado antes da publicação.

## Validação

| Verificação | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Mapa aberto em 1920×1080 | Aprovado |
| Seta de direcção visível | Aprovado |
| Novo Jogo + exploração | 30 segundos aprovados |
| Erros de parser ou script | Nenhum |

## Continuidade

O próximo ciclo Dev1 deve priorizar a leitura física da rota inicial para que os sinais no mundo e o mapa jogável permaneçam mutuamente consistentes. O Dev2 mantém a ordem autónoma CP-D2-004 para ligar os marcos 7–12 ao mesmo registo de âncoras e reduzir o orçamento de luzes.
