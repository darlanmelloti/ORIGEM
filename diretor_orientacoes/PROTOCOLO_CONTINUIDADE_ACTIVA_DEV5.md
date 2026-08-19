# Protocolo de Continuidade Activa — Dev5

**Aplicação:** imediata e permanente na branch `feature/dev5-cartographic-world-third-person`.

> Dev5 foi criado para acelerar a construção do mundo real a partir do mapa cartográfico. Uma ausência de tarefa escrita nunca autoriza paragem: ela activa a primeira tarefa disponível nesta escada, sempre dentro de `levels/dev5/`, `assets/models_dev5/`, `entities/player/third_person/` e documentação Dev5.

## Regra de fecho obrigatório

Ao terminar qualquer checkpoint, Dev5 deve publicar o resultado, actualizar `CONTINUIDADE_DEV5.md` e escrever a próxima tarefa **ACTIVA** no mesmo commit. Só consulta a ponta remota para incorporar trabalho de outros colaboradores; não fica em espera se a ponta estiver sincronizada.

| Ordem | Quando aplicar | Acção obrigatória | Limite de segurança |
|---:|---|---|---|
| 1 | Existe tarefa `ACTIVA` no marcador | Executar essa tarefa imediatamente | Não alterar módulos regionais R1–R12 |
| 2 | Não existe tarefa `ACTIVA`, mas existe candidato QA pendente de avaliação visual | Executar parser, 36 s, captura e decisão de aceitar/rejeitar | Não promover sem ganho comprovado |
| 3 | Não existe candidato pendente | Usar `CartographicPlacementSystem` para preparar a próxima ficha de marco R1–R6 ainda não catalogada | Deslocamento máximo de 36 m da âncora |
| 4 | Catálogo está actualizado | Auditar activo real local: triângulos, materiais, colisores e custo de luzes | Zero luzes dinâmicas novas |
| 5 | Auditoria concluída | Criar uma única cena QA de objecto 3D para o marco menos coberto, com colisores e passagem verificável | Proibir outdoors, paredes florestais e primitives sem melhoria visual |
| 6 | Criação QA bloqueada por activo externo | Melhorar a fundação QA de Elias, LOD, colisores, capturas internas ou documentação de integração | Não tocar `Player.gd` de produção |
| 7 | Todos os itens anteriores concluídos | Abrir uma auditoria de regressão das cenas QA e limpar candidatos rejeitados | Publicar evidência e abrir a próxima revisão |

## Backlog contínuo autorizado

O backlog é executável sem nova autorização enquanto não tocar módulos de produção.

| Identificador | Entrega Dev5 | Marco | Condição de conclusão |
|---|---|---:|---|
| CP-D5-015 | Ponte GLB leve com colisão própria em QA | 2 | Comparação visual e física com a ponte procedural |
| CP-D5-016 | Captura visual do portal florestal remoto | 4 | Aceitar/rejeitar sem criar parede de árvores |
| CP-D5-017 | Captura visual do cais remoto | 6 | Aceitar/rejeitar lajes, colunas e água não emissiva |
| CP-D5-018 | Auditoria de LOD de pinheiro e feto PBR | 4–5 | Recomendação de densidade com métricas reais |
| CP-D5-019 | Rig/activo humano Elias quando ficheiro recuperável existir | Global | Só após licença e importação QA |
| CP-D5-020 | Matriz de regressão de colisores dos candidatos QA | 1–6 | Uma cena física e 36 s por candidato pendente |

## Proibições

Dev5 não deve repetir candidatos rejeitados, esperar 10 segundos sem trabalho activo, declarar bloqueio apenas pela ausência de `gh auth`, modificar módulos R1–R6 de produção, nem usar a falta de um GLB externo como justificativa para parar a criação.
