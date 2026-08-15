# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`  
**Marco:** Checkpoint 113 — Corredor Ribeirinho, Floresta e Crepúsculo  
**Responsável técnico:** Desenvolvimento Principal  
**Estado:** Em evolução contínua; base jogável preservada e sincronizada.

## Estado consolidado

A base regional de doze marcos permanece funcional. A rota de entrada inclui a Casa Voss, a Estrada do Rio, o Arco das Ruínas, a Floresta Densa e a transição para as Ruínas Submersas. A porta, o salto do prólogo, a stamina e os corredores iniciais mantêm comportamento estável nas sessões de validação.

| Componente | Estado | Evidência / observação |
|---|---|---|
| Branch de gameplay | Publicada | `feature/dev1-gameplay-core` contém a base regional e a correção ribeirinha. |
| Terreno regional | Validado | A malha cobre a escala regional dos 12 marcos sem regressão na área inicial. |
| Estrada do Rio e Arco | Validada | Corredor físico e arco carregam sem erros de GDScript. |
| Floresta Densa | Em refinamento | A mistura de espécies, fetos e árvores focais foi ampliada; ainda requer ativos menos estilizados. |
| Lago e margem | Em refinamento | A bacia elíptica e as margens rochosas existem; o acesso é fisicamente materializado por lajes, mas a automação de captura é lenta demais para concluir a travessia integral no llvmpipe. |
| Crepúsculo litúrgico | Em calibração | Perfil persistente após o prólogo criado; o preenchimento ambiente está a ser elevado para melhorar a legibilidade do solo e da vegetação. |
| GitHub | Operacional | Escrita confirmada; commits já publicados na branch dev1. |

## Validação recente

A validação técnica headless concluiu sem erros de script. O ciclo de gameplay mantém captura após saída e observação superior a 30 segundos. No renderizador de captura `gl_compatibility` com Mesa llvmpipe, a simulação decorre significativamente abaixo do tempo de parede; por isso, percursos extensos até ao lago exigem tempos de captura desproporcionais. A correção de rota foi validada estruturalmente pela continuidade das lajes, relevo de baixa inclinação e bacia lateral sem vegetação dentro da água.

## Decisões técnicas adotadas

> A sequência cinematográfica orienta a composição e o ritmo, mas o mapa de 12 marcos define a escala real do mundo.

A frente de desenvolvimento principal não altera a região da montanha/canyon. Qualquer integração da branch `feature/dev2-mountain-canyon` deve ocorrer apenas depois de a referência remota estar disponível e de as mudanças serem revistas contra os corredores já construídos.

A vegetação foi concentrada fora do eixo de lajes e a margem do lago foi deslocada para a lateral do corredor. Isso preserva a exploração e evita que árvores, pedras ou água fechem a progressão.

## Próximo ciclo recomendado

1. Confirmar a legibilidade do novo crepúsculo com captura pós-prólogo e manter apenas valores que preservem leitura de chão, ruínas e silhuetas.
2. Substituir progressivamente as copas estilizadas restantes por modelos orgânicos PBR de instância econômica.
3. Executar uma validação manual ou em GPU com desempenho normal para documentar a travessia completa Casa Voss → margem do lago; o llvmpipe permanece adequado para estabilidade e regressões, não para medir tempo de deslocação regional.
4. Integrar a frente da montanha/canyon apenas por merge/revisão, depois que a branch dev2 passar a existir no remoto.

## Artefactos locais relevantes

| Artefacto | Finalidade |
|---|---|
| `WORLD_BLUEPRINT_12_LANDMARKS.md` | Distribuição regional dos doze marcos e corredores. |
| `levels/RiverRoadJourney.gd` | Estrada do Rio e Arco das Ruínas. |
| `levels/ForestLakeRegion.gd` | Floresta Densa, Acampamento Majestic, margem do lago e Ruínas Submersas. |
| `levels/LevelEnvironment.gd` | Perfis ambiental diurno, tempestade e crepúsculo persistente. |
| `levels/RegionalCinematicDirector.gd` | Camada reutilizável dos sete takes cinematográficos. |

---

**Regra de continuidade:** cada alteração visual ou de rota deve passar por validação técnica e por pelo menos 30 segundos de gameplay/captura antes de ser preservada.
