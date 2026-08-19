# CP-CARTO-088 — R1→R3: material de vale e abertura vegetal

## Alteração executada

O passe ajusta exclusivamente a apresentação do corredor cartográfico entre a Estrada do Rio e o Arco das Ruínas. O shader de solo húmido passou a equilibrar a textura PBR com uma base terrosa mais legível no renderizador `gl_compatibility`; não houve alteração a colisores, altura analítica, âncoras X/Z, luzes ou rota.

A distribuição regular de dez árvores laterais foi substituída por seis núcleos descontínuos, afastados do eixo e separados por uma janela de vista entre `z=80` e `z=94`. O Arco canónico em `z=92` permanece livre de nova estrutura e a ponte, o arco estrutural alternativo e os candidatos previamente rejeitados não foram reutilizados.

## Validação técnica

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Renderizador | `opengl3/gl_compatibility` |
| Harness | `road_to_arch` |
| Gameplay real | 36 segundos |
| Snapshot interno | PASS — 1920×1080 |
| Rota e âncora do Arco | PASS — foco em `(-13,8; 92,0)` |
| Luzes dinâmicas novas | 0 |

## Decisão visual

> **REJECTED_VISUAL para promoção final.** O Arco e o caminho ganharam leitura, e a massa vegetal deixou de formar uma barreira contínua no eixo. Contudo, a captura continua dominada pela arma de primeira pessoa, pela silhueta simples das árvores e por planos distantes ainda insuficientes. O passe é preservado como melhoria reversível; não satisfaz o limiar visual de 85% exigido para encerrar o refinamento de abertura.

## Próxima acção legítima

A frente que controla a apresentação de Elias deve fornecer uma recaptura de terceira pessoa sem a arma a ocupar o primeiro plano. Com essa prova, Dev1 avalia os mesmos marcos R1→R3 e apenas então decide se o refinamento do vale pode ser promovido visualmente.
