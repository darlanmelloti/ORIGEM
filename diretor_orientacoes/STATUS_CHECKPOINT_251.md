# CP 251 — Orientação física Casa Voss → Estrada do Rio

**Branch:** `feature/dev1-gameplay-core`  
**Âmbito:** Regiões 1–6, exclusivamente.

## Resultado entregue

Foram colocados três marcos baixos de ruína em posições laterais ao corredor inicial, nos sectores `z=17`, `z=24` e `z=39`. Os dois primeiros dão continuidade visual à saída da Casa Voss; o terceiro confirma a curvatura do trajecto antes da aproximação ao Arco das Ruínas. Cada marco recebeu uma rocha de base, criando contacto visual com o terreno em vez de aparentar um objecto suspenso ou uma baliza artificial.

Os marcadores permanecem a 3,25 metros do eixo da estrada. Não têm corpos de colisão: a rota central de lajes e o percurso de Elias mantêm-se inteiramente livres.

## Evidência de validação

| Critério | Resultado |
|---|---|
| Godot 4.7.1 em modo headless | Aprovado |
| Novo Jogo e deslocação contínua | Aprovado |
| Duração de exploração | 30 segundos |
| Erros de parser ou script | Nenhum |
| Bloqueio introduzido na rota | Nenhum detectado |
| Imagem de evidência | `qa_evidence_new_game/walk_30s/depois_30s_movimento.png` |

## Próximo ciclo

O CP 252 deve tornar o Arco das Ruínas mais legível como marco da Região 3, com foco em aterramento orgânico das suas bases e leitura nocturna compatível com o orçamento de luzes da GTX 1050 Ti. Nenhum ficheiro das Regiões 7–12 será modificado.
