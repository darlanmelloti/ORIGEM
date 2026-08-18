# CP-CARTO-30 — Profundidade da Bacia e Estela de Chegada R6

**Branch:** `feature/cine07-final`  
**Escopo:** Região 6 e documentação; sem alteração nas Regiões 7–12.  
**Estado:** validado tecnicamente; melhoria visual específica aceite; polimento macro continua aberto.

## Intervenção

A antiga cascata da margem oriental era uma `QuadMesh` azul, que a prova de gameplay mostrava como um painel plano. Ela foi substituída por cinco filetes cilíndricos de água, com variações de raio, altura, posição e inclinação. A nova construção apoia-se visualmente no promontório rochoso, não cria uma superfície outdoor e não recebe sombra dinâmica.

## Validação obrigatória

| Critério | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Erros de script, parse, crash e carregamento | **Nenhum detectado** |
| Gameplay real | **30 segundos aprovados** com Novo Jogo automático e harness `ruins_arrival` + `lake_stela` |
| Posicionamento da prova | Elias: `(52.0, 0.712275, 233.0)`; estela: `(52.0, 0.886538, 231.0)` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto30_lake_stela_refined_1600x900.png` |
| Verificação de diffs | **Aprovada** — `git diff --check` limpo |

## Comparação observável

A captura posterior elimina o rectângulo azul vertical que dominava a tomada anterior e conserva uma leitura tridimensional do promontório, da margem e da estela. A estela continua visível de perto, como pedido para a chegada à bacia. O passe não declara o corredor inteiro concluído: as massas de terreno e a vegetação distante ainda requerem refinamento de linguagem material para atingir a referência cinematográfica.

> **Fila automática seguinte:** melhorar a composição material e a escala orgânica do limiar das Ruínas, sem voltar a testar variantes já rejeitadas de emissão de água, altura do leito, escuridão das lajes ou densificação linear do trilho.

## Dependência Dev2

A ponte R6→R7 continua dependente da publicação remota do CP-D2-214. Esta dependência não bloqueia os passes independentes dentro das Regiões 1–6.
