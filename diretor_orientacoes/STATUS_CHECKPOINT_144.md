# ORIGEM — Checkpoint 144: Leitura do Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `7a42745` — `feat(camp): rebalance majestic fill for twilight readability`.

## Incremento aplicado

O Acampamento Majestic recebeu um preenchimento local reposicionado e reequilibrado para o modo de compatibilidade: energia `2.05`, alcance `31.0`, atenuação `1.12` e altura `5.2`. A lona das quatro tendas agora tem emissão reflexiva contida, mantendo a trama e os remendos visíveis em crepúsculo sem se tornar uma fonte luminosa artificial. A textura `majestic_weathered_canvas_albedo.png` foi anteriormente normalizada como PNG válido no commit `fb5a887`.

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado sem `Parse Error`. |
| Leitura de tenda | Take 10, 1600×900 | Lona e silhuetas das tendas recuperadas na captura de compatibilidade. |
| Continuidade base | Prólogo, porta `[E]` e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Corredor regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Lago e ruínas | Take 11, 1600×900 | Captura atualizada para orientar o próximo passe. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase144_MajesticFill_Validated.zip`

SHA-256:

`ce0da8b7e09eb591e0cad9e7b3f35e83ff06054e3e055cbb9e62aa4396df00df`

> O próximo ciclo continua automaticamente nas Ruínas Submersas: aumentar a leitura da água, dos pilares e do acesso à margem, sem alterar qualquer módulo, geometria, câmara ou ativo das Regiões 7–12.

## Artefactos recentes

| Ficheiro | Finalidade |
|---|---|
| `/home/ubuntu/origem_v2_phase122_take10_majestic_physical.png` | Evidência do Acampamento Majestic após o preenchimento. |
| `/home/ubuntu/origem_v2_phase118_take11_majestic_lake_transition.png` | Diagnóstico visual atualizado das Ruínas Submersas. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência da rota física de 30 segundos até ao lago. |
| `/home/ubuntu/origem_v2_phase113_twilight_stable_30s.png` | Evidência de prólogo, porta e exterior. |

A criação do checkpoint não encerra o desenvolvimento; o passe seguinte permanece restrito às Regiões 1–6.
