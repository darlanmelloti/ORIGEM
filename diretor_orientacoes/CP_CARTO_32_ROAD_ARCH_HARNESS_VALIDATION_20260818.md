# CP-CARTO-32 — Harness Estrada→Arco em OpenGL QA

**Branch:** `feature/cine07-final`  
**Escopo:** infraestrutura de QA em `TempleLevel.gd`; evidência cartográfica das Regiões 1–3.  
**Fronteira:** sem alterações a activos, geometria ou módulos das Regiões 7–12.

## Problema e correcção

A captura baseada em `ORIGEM_CAPTURE_TAKE=1` abriu a câmara cinematográfica mas devolveu um frame negro no OpenGL de QA. Esse frame foi explicitamente rejeitado. Para não alterar a composição física aprovada nem depender da segunda câmara, foi criado o harness `ORIGEM_QA_ROUTE=road_to_arch`.

O harness usa a câmara real de Elias, posiciona-o no primeiro segmento livre da Estrada do Rio e aponta-o para o Arco físico em `z=92`. O modo reduz o mundo de validação às Regiões 1–6, evitando a inicialização de módulos Dev2 durante a prova.

| Critério | Resultado |
| --- | --- |
| Parser Godot 4.7.1 headless | **Aprovado** |
| Sessão de gameplay real | **30 segundos aprovados** |
| Spawn | `(-20.05, 0.605985, 22.0)` |
| Foco físico | `(-13.8, 0.0, 92.0)` |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto32_road_to_arch_harness_1600x900.png` |
| Estrada e Arco | **Legíveis no mesmo eixo físico** |
| Erros de script, parse ou crash | **Nenhum detectado** |
| Regiões 7–12 | **Não instanciadas no harness** |

## Continuidade

O harness preto cinematográfico permanece rejeitado para a execução OpenGL actual; o harness `road_to_arch` passa a ser a via confiável de evidência ampla R1–R3. Esta publicação não encerra o ciclo. A próxima lacuna é a leitura do rio e das massas laterais nessa mesma tomada, preservando a distância real até ao Arco e sem reabrir candidatos já rejeitados.
