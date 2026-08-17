# Estado do Checkpoint 284 — Aterramento Majestic → Ruínas

O **CP 284** reforça a chegada entre o Acampamento Majestic e as Ruínas Submersas com três agrupamentos físicos descontínuos. Cada grupo combina rocha, árvore e feto, todos aterrados por `TerrainPatch.height_at()`, distribuídos fora da faixa de lajes e sem novos colisores ou luzes dinâmicas.

| Verificação | Resultado |
|---|---|
| Godot headless | Aprovado, sem erros de parser, script ou recursos em falta |
| Gameplay regional | Prova segmentada de 30 segundos aprovada sem bloqueio introduzido |
| Orçamento de luzes | Sem luzes adicionadas |
| Percurso | A rota de lajes mantém abertura física entre Majestic, margem e Ruínas |
| Escopo | Apenas `ForestLakeRegion.gd`, pertencente às Regiões 4–6 do Dev1 |

A intervenção evita tanto a margem despida como a parede de vegetação: as espécies e as rochas aparecem em intervalos assimétricos, preservando linhas de visão para a bacia e para os vestígios submersos.

> O CP 285 está aberto automaticamente para auditar a materialidade da água, das lajes húmidas e dos encontros rochosos da bacia, mantendo a mesma regra de testes e de orçamento GTX 1050 Ti.

**Estado:** `VALIDADO TECNICAMENTE; CP 285 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.
