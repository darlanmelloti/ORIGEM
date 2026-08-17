# CP-CINE-22 — Reversão da Soleira Interior Orion

A soleira de três pedras laterais foi testada com a cena principal e com o estágio QA `orion_entrada`. A captura não mostrou ganho perceptível: as pedras não criaram uma leitura clara de transição e não justificaram manter geometria adicional junto à boca Orion.

A alteração em `OrionDestinationRegion.gd` foi revertida para a base `026d3bb`, preservando integralmente:

- a entrada volumétrica CP-CINE-11;
- a ocultação física da Câmara/Cubo fora do raio de Elias;
- os estágios QA CP-CINE-21;
- a fronteira Dev1, sem qualquer alteração nas Regiões 1–6.

## CP-CINE-23 já iniciado

O próximo ciclo abandona adições de rocha de baixo impacto. Será feita uma auditoria de leitura do próprio terreno de montanha e dos contornos da boca Orion, para escolher uma única correcção estrutural que seja visível tanto na aproximação local como na progressão cartográfica.
