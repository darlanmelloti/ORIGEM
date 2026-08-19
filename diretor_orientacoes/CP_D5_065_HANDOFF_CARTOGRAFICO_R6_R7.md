# CP-D5-065 — Handoff cartográfico R6 → R7

**Escopo:** cena QA isolada em `levels/dev5/`. A cena utiliza uma baliza abstracta de handoff, não cria geometria, módulos ou activos da Região 7.

## Objectivo

Confirmar que, ao alcançar as Ruínas Submersas, Elias passa a receber a indicação cartográfica para a Vila Elevada conforme a autoridade espacial do mapa, sem Dev5 invadir o escopo de Dev2.

| Elemento | Contrato | Resultado |
|---|---|---|
| Ponto de partida | R6 `(60,252)` | `PASSAGEM: VILA ELEVADA`, âncora 7 |
| Alvo cartográfico | R7 `(140,352)` | Baliza QA atingida em 36 s |
| Elias | Apresentação técnica em terceira pessoa | Câmara interna inactiva |
| Conteúdo Dev2 | Região 7 e módulos associados | Nenhum criado ou alterado |
| Produção | Módulos R1–R12 | Nenhuma alteração |
| Luzes | Ambiente QA | Uma direccional; zero Omni/Spot |

## Validação

O parser Godot 4.7.1 passou. A sessão QA de 36 segundos registou a direcção para a âncora 7 e `reached_marker_r7=true dev2_geometry_created=false production_modules_changed=false`. A captura mostra as duas balizas e Elias no volume técnico, mantendo clara a fronteira operacional.

> Esta prova não é integração R6→R7 no mundo de produção. A integração física permanece dependente do trabalho publicado por Dev2 e da checklist pareada Dev1–Dev2.

## Próxima tarefa automática

**CP-D5-066 — Auditoria de fronteira Dev5/Dev2.** Verificar que os novos artefactos Dev5 permanecem exclusivamente em `levels/dev5/`, `assets/models_dev5/` ou `entities/player/third_person/` e documentar a dependência formal para a integração R6→R7.
