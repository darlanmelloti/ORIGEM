# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`
**Marco atual:** Checkpoint 115 — Vila Elevada e Observatório de Orion
**Responsável técnico:** Desenvolvimento Principal
**Estado:** Validado localmente e pronto para sincronização remota.

## Síntese do ciclo

O Take 5 foi desenvolvido como a primeira leitura física da subida regional entre o Lago das Ruínas Submersas, a Vila Elevada e o Observatório de Orion. A composição foi revista para que a vila funcione como um aglomerado habitável em terraços de pedra e o observatório surja acima dela como um destino astronómico reconhecível, com lente azul de Orion.

| Componente | Estado | Resultado validado |
|---|---|---|
| Vila Elevada | Validado | O conjunto passou de sete volumes repetidos para casas com dimensões variáveis, telhados de ardósia, portas, janelas calorosas, vigas e chaminés intercaladas. |
| Terraços e muralhas | Validado | Três níveis de pedra, muros de contenção e pilares quebram a silhueta em vez de criar uma parede uniforme. |
| Observatório de Orion | Validado | Base astronómica, anéis escalonados, domo, oito pilares e lente azul emissiva reforçam o marco visual. |
| Vegetação e rochedos | Validado | Coníferas e pedras PBR foram colocadas de forma irregular para enquadrar o percurso, a vila e o observatório sem fechar o caminho. |
| Take 5 | Validado | Câmara transferida para `(72.0, 27.5, 313.0)` e alvo em `(168.0, 12.0, 385.0)`, garantindo vila e observatório no mesmo arco visual. |
| Validação técnica | Validada | Editor/headless sem erro de GDScript. |
| Gameplay de 30 segundos | Validado | Execução limpa, sem `Parse Error` ou falha de carregamento; rota inicial, porta e exterior continuam funcionais. |

## Evidências

| Artefacto | Finalidade |
|---|---|
| `origem_v2_phase115_take5_highland.png` | Captura física do Take 5 com Vila Elevada, coníferas, lente azul e serra de fundo. |
| `origem_v2_phase113_twilight_stable_30s.png` | Estabilidade de 30 segundos após a alteração regional. |
| `ORIGEM_V2_RegionalWorld_Phase115_HighlandObservatory_Validated.zip` | Checkpoint recuperável completo, sem a cache `.godot`. |
| `ORIGEM_V2_RegionalWorld_Phase115_HighlandObservatory_Validated.sha256` | SHA-256 `7722f50424f281583b5586673ca4fe50bc228cec754759d34dc72a9cb742b468`. |

## Decisão de continuidade

> O mapa de doze marcos continua a definir as distâncias reais. A câmara do Take 5 serve apenas para orientar a leitura narrativa entre a Vila Elevada e o Observatório.

O próximo ciclo deve avançar para o **Take 6 — Trilha da Montanha**, com o mesmo método obrigatório: ajuste material, validação headless, captura quando a câmara estiver ativa, gameplay de 30 segundos, checkpoint e sincronização.
