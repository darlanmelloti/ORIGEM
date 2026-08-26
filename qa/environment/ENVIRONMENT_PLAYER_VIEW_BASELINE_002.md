# ORIGEM — Auditoria de Vistas do Jogador 002

> **Task ID:** `DEV1-ENVIRONMENT-PLAYER-VIEW-BASELINE-002`
> **Natureza:** QA observacional. Esta tarefa não autoriza alteração de produção.

## Objectivo

Aplicar a direção ambiental 001 através de uma matriz de vistas obtidas pela câmara real de Elias, não por uma câmara de marketing. A auditoria estabelece uma baseline de composição para avaliar se cada transição possui uma intenção espacial legível: chegada, orientação e recompensa de vista.

| Parâmetro | Valor obrigatório |
|---|---|
| Resolução | 1600×900, 16:9 |
| Execução | Cena de jogo, OpenGL Compatibility sob Xvfb |
| Câmara | Câmara ativa do jogador; é proibido alterar FOV, transform ou câmera de produção |
| Conteúdo | Somente mundo existente; sem override de material, geometria, luz, água, partículas, neblina, colisor ou âncora |
| Saída | PNG, log de rota, posição de spawn/câmara, luzes regionais e decisão de leitura |
| Critério técnico | Sem `SCRIPT ERROR`, erro fatal ou mudança de ficheiro de produção |

## Matriz de capturas

| Ordem | Rota QA reconhecida | Intenção visual a verificar | Invariantes regionais |
|---:|---|---|---|
| 1 | `road_to_arch` | A estrada deve conduzir até ao Arco sem comprimir a escala Casa→Arco. | Lajes, água, rota e limite global de 16 luzes. |
| 2 | `arch_to_forest` | O Arco deve marcar a transição sem vedar a entrada da Floresta. | Dois emissores do Arco, rota e clareira pré-Arco. |
| 3 | `forest_to_majestic` | Massas laterais devem orientar para Majestic sem parede de árvores. | R4: uma luz local, corredor ≥8 m e exclusão Orion Z≈126–151. |
| 4 | `majestic_to_lake` | A sequência do acampamento deve ceder a leitura física da margem. | R5: exatamente quatro luzes locais e trilho navegável. |
| 5 | `forest_to_ruins` | A aproximação deve separar trilho, água e ruínas sem antecipar R7. | R6: água, handoff, rota e quatro luzes exatas. |
| 6 | `ruins_arrival` | A chegada deve ler a bacia e os vestígios sem câmara, emissão ou marco falso. | R6: `PreenchimentoMundialDoLago`, `PreenchimentoOpostoDoLago`, `PreenchimentoAzulDaMargem`, `LuzSubaquaticaCentral`. |

## Método de leitura

Cada frame será avaliado por três perguntas, sem fabricar correção para atingir uma resposta favorável:

1. **Orientação:** o jogador percebe para onde avança a rota física?
2. **Profundidade:** primeiro plano, plano médio e silhueta distante estão separados por geometria real e não por um painel ou efeito?
3. **Hierarquia:** existe um marco dominante coerente com a região, sem competir com a rota?

A conclusão permitida é apenas uma de três: `PASS_LEITURA`, `OBSERVAR_SEM_PRODUCAO` ou `HIPOTESE_CAUSAL_REQUERIDA`. A última exige uma fonte por nó/material/posição e aprovação do dono regional antes de qualquer alteração.

## Restrições expressas

Não usar Nanite/Lumen como modelo de desempenho, Megascans densos, *fog cards*, paredes de árvores, fundos falsos, partículas constantes, emissões de água, luz adicional, alteração de rota, câmara de produção ou edição de `CartographicAnchors.gd`. A auditoria reutiliza somente harnesses de rota já existentes; se uma rota não for reconhecida, ela é inválida como evidência e não deve ser substituída por spawn manual.
