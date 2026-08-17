# DEV2 — CP-CINE-06: cadeia remota R7–R9

**Estado:** implementação e validação concluídas na branch `feature/dev2-mountain-canyon`.

## Alteração entregue

`HighlandRegion.gd` ganhou o construtor `HandoffRemotoRegiao7`. A nova cadeia mantém as distâncias cartográficas: terraços de passagem em `z=290–306`, borda baixa da Vila em `z=318–334` e contrafortes da subida em `z=338–354`. Todas as massas são instâncias tridimensionais de rocha e pilar, usam `TerrainPatch.height_at`, deixam a estrada `R6→R7` livre e não acrescentam luzes, fundos planos ou painéis.

| Camada | Papel espacial | Estado |
|---|---|---|
| Terraços de passagem R7 | Primeira leitura arquitectónica depois das Ruínas Submersas | Integrada |
| Borda baixa da vila | Antecipa a Vila Elevada, sem comprimir a posição principal em `z≈352` | Integrada |
| Contrafortes R7 | Conduz a estrada até à subida e ao observatório posterior | Integrada |

## Validação

O editor Godot 4.7.1 validou a sintaxe sem erro. A prova OpenGL de 30 segundos concluiu sem `SCRIPT ERROR`, `Parse Error`, chamada inválida ou falha de execução. A captura `dev2_cp_cine06_r7_without_r6_pine_pass2.png` demonstra a cadeia física e isolou uma obstrução externa à frente Dev2.

## Devolução obrigatória ao Dev1

A árvore `ArvoreFocalMargem_02`, criada em `ForestLakeRegion.gd` (R6) na posição `(61, 290)`, ocupa o primeiro plano da câmara de handoff `(30, 282)` e impede a leitura da Vila. O harness de QA ocultou-a apenas temporariamente; isso confirmou a causa sem alterar runtime. Dev1 deve deslocá-la para fora do eixo da rota R6→R7 ou reduzi-la, preservando uma floresta lateral real e evitando uma parede vegetal. Esta correcção pertence exclusivamente a Dev1/R6.

## Próxima tarefa já iniciada

CP-CINE-07 deve agora recapturar Casa Voss e o handoff usando a matriz congelada. O retorno deve verificar a leitura Casa → Estrada → Arco → R6 → terraços R7 → Vila e abrir CP-CINE-08 sem paragem.
