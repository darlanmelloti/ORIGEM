# CP-CARTO-089 — Activo Focal Poly Haven R1→R3

## Decisão

**REJECTED_VISUAL.** O único activo `island_tree_01_1k.gltf` foi testado como núcleo focal no corredor Estrada–Arco, na posição lateral cartográfica previamente validada. O parser Godot e a travessia `road_to_arch` durante 36 segundos passaram sem regressão de rota, de escala ou de luzes dinâmicas.

A captura de viewport, porém, não demonstrou ganho visual material: o activo não criou uma silhueta legível à distância nem reduziu a leitura técnica do corredor. Não será promovido nesta posição. A variante anterior com o pinheiro PBR será restaurada.

## Preservação e próximo bloqueio

A rejeição não invalida o activo Poly Haven no projecto; ela limita apenas esta aplicação focal R1→R3. O bloqueio visual dominante permanece a recaptura de primeira pessoa, cuja arma cobre a parte inferior do enquadramento e impede Elias de estabelecer escala humana. A próxima prioridade de integração é uma tomada de terceira pessoa no mundo de produção, entregue pela frente Dev5 sem tocar nas Regiões 7–12.

## Evidência

- Rota: `road_to_arch`
- Duração: 36 segundos
- Captura: `/home/ubuntu/qa_evidence_dev1_polyhaven_focal/road_to_arch_36s.png`
- Estado técnico: `PASS`
- Estado visual: `REJECTED_VISUAL`

## Regra

Este candidato não pode ser reintroduzido no eixo R1→R3 sem uma hipótese visual diferente e uma nova evidência de gameplay.
