# CP-CARTO-21 — Auditoria Macro e Handoff de Espelho Cartográfico

## Decisão

As capturas canónicas do commit `675ad67` comprovam a leitura bidireccional do corredor inicial: a Estrada do Rio conduz Casa Voss → Arco, e a Casa Voss permanece reconhecível no retorno. A auditoria também estabelece uma lacuna objectiva: a tomada inicial não pode, ainda, tornar **Majestic, Ruínas Submersas e os marcos das Regiões 7–12** reconhecíveis como silhuetas espaciais distintas sem comprimir o vale ou introduzir substitutos planos.

> O mapa continua a ser a autoridade espacial. A resposta correcta não é aproximar artificialmente os marcos, nem colocar painéis de fundo: é completar e integrar geometria tridimensional real nas coordenadas canónicas, com hierarquia de silhuetas e atmosfera de profundidade.

## Estado por marco cartográfico

| Região | Marco | Estado no mundo real | Leitura a partir da abertura | Proprietário |
| --- | --- | --- | --- | --- |
| 1 | Casa Voss | Validada; porta, exterior e retorno funcionais | Clara como origem no retorno | Dev1 |
| 2 | Estrada do Rio | Validada; lajes iniciais densificadas | Clara como eixo imediato | Dev1 |
| 3 | Arco das Ruínas | Validado como marco vertical | Claro em plano médio | Dev1 |
| 4 | Floresta Densa | Validada pelo limiar pós-Arco | Lida como estrato posterior ao Arco | Dev1 |
| 5 | Acampamento Majestic | Conector físico validado | Não é ainda uma silhueta distinta na abertura | Dev1 |
| 6 | Ruínas Submersas | Chegada e margem validadas | Não é ainda uma silhueta distinta na abertura | Dev1 |
| 7–12 | Vila Elevada → Orion | Fora da fronteira Dev1; coordenadas canónicas existem | Dependem da integração real do Dev2 | Dev2 |

## Lacuna CP-CARTO-21 seleccionada

A primeira lacuna macro verificável é a **transmissão de hierarquia de silhuetas após o Arco**. Actualmente, a Estrada e o Arco comunicam correctamente o próximo vector de exploração, mas Majestic e Ruínas só são reconhecidos quando o jogador avança para as respectivas regiões. Isto preserva a profundidade real, mas ainda não cumpre a ambição de o mapa ser reconhecível como um vale único desde a abertura.

A correcção não deve ocorrer como decoração isolada. Deve usar três entregas encadeadas:

| Frente | Entrega contínua | Critério de aceitação |
| --- | --- | --- |
| Dev1 | Definir duas linhas de visão reais e sem colisão no terreno: Casa→Arco→Floresta e Arco→Majestic→Ruínas. Não deslocar âncoras. | Provas de 30 s, sem bloco físico e sem novo plano/outdoor. |
| Dev2 | Garantir que as massas reais das Regiões 7–12 surgem nas coordenadas canónicas e produzem silhuetas de profundidade, não uma parede ou portal antecipado. | Harness integrado 6→7 e panorama de entrada sem alterar R1–6. |
| Dev3 | Bloquear três câmaras de comparação: abertura da Casa, pós-Arco e chegada a Majestic. Avaliar só composição, PBR, atmosfera e escala. | Mesmo FOV e posição por ciclo; quadro antes/depois verificável. |
| Dev4 | Medir a integração 1–12 no mundo principal: luzes Omni visíveis ≤16, colisores, carregamento e regressões. | Log reproduzível e gameplay integrado de 30 s. |

## Próximo ciclo de Dev1 — CP-CARTO-22

Dev1 deve, dentro das Regiões 1–6, construir uma **linha de visão cartográfica real entre o pós-Arco e Majestic**, removendo apenas elementos que ocultem indevidamente a massa já existente e usando geometria apoiada no terreno. Não são permitidas alterações de água, FOV, câmara, altura de lajes, materiais da Estrada, escala do vale ou qualquer módulo das Regiões 7–12. A validação exige captura pós-Arco, prova Floresta→Majestic e 30 segundos de gameplay.

## Evidências de base

- `qa_evidence_voss_vista/cp_carto20_voss_to_arch30.png`
- `qa_evidence_voss_vista/cp_carto20_return_to_voss30.png`
- `qa_evidence_voss_vista/cp_carto20_normal_menu_hold_e30.png`
- `diretor_orientacoes/MATRIZ_CONTINUIDADE_CARTOGRAFICA_R1_R6_20260818.md`
- `levels/CartographicAnchors.gd`

## Regra de continuidade

Este diagnóstico abre o CP-CARTO-22 imediatamente. Nenhuma frente deve declarar o CP-CARTO-21 como ponto de paragem: a auditoria serve para escolher uma única lacuna mensurável e encaminhá-la ao proprietário correcto.
