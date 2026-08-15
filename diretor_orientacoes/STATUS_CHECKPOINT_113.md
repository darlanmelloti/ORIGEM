# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`
**Marco atual:** Checkpoint 114 — Lago das Ruínas Submersas, Margens e Crepúsculo
**Responsável técnico:** Desenvolvimento Principal
**Estado:** Validado localmente; pronto para sincronização remota.

## Estado consolidado

A base regional de doze marcos permanece íntegra. A rota inicial mantém Casa Voss, Estrada do Rio, Arco das Ruínas, Floresta Densa e o setor do Lago das Ruínas Submersas como componentes de um mesmo mundo físico. A escala continua a obedecer ao mapa regional, não à duração da cinemática.

| Componente | Estado | Evidência / decisão |
|---|---|---|
| Terreno regional | Validado | Terreno 640 × 880, bacia do lago e corredores navegáveis permanecem carregados sem regressão técnica. |
| Casa Voss e prólogo | Validado | Salto com `E`, porta interativa e devolução de controlo a Elias preservados. |
| Saída para exterior | Validada | O roteiro de QA passou a capturar o rato e confirmou Elias fora da soleira após abertura da porta. |
| Lago das Ruínas Submersas | Validado | Lâmina de água escura com ondulação, ruínas emergentes e pilares submersos reposicionados para leitura a partir da margem. |
| Margens ribeirinhas | Validado | Rochas foram ampliadas e a vegetação de margem reforçada em grupos descontínuos, sem fechar o percurso. |
| Take cinematográfico 4 | Validado | Câmera aproximada da água, FOV reduzido e duração de QA ampliada para evitar capturar o retorno à câmara do jogador. |
| Crepúsculo litúrgico | Validado | Ambiente azul profundo, luz quente de alpendre e ajuste de exposição após correção de sintaxe. |
| Estabilidade de gameplay | Validada | Execução limpa de 30 segundos no exterior sem `Parse Error`, sem queda livre e sem bloqueio na porta. |

## Correções materiais deste ciclo

O take 4 não estava a ser fotografado durante a cinematografia: a rotina de captura aguardava mais tempo do que a duração da câmara regional. O diretor foi ajustado para manter takes de QA ativos por 35 segundos, enquanto o script passou a capturar aos 18 segundos. Os logs confirmam a ativação da câmara na posição regional antes da gravação.

O lago recebeu material sem emissão ciano, com ondulação em duas frequências, maior aspereza e especularidade controlada. Os pilares interiores foram elevados e escalados; três marcos arqueológicos emergentes foram enfatizados para que a narrativa de ruína submersa seja visível no enquadramento de margem. Rochas e fetos foram reforçados sem criar uma parede vegetal.

O perfil de crepúsculo teve a iluminação ambiente, neblina, exposição e luz solar recalibradas. Durante esta iteração foi identificado e corrigido um erro de indentação em `LevelEnvironment.gd`; após a correção, a validação headless e o gameplay limpo voltaram a concluir sem falhas de carregamento.

> A sequência cinematográfica guia a composição; o mapa de doze marcos continua a definir a escala real do mundo explorável.

## Validação obrigatória concluída

| Verificação | Resultado | Artefacto |
|---|---|---|
| Compilação/editor headless | Aprovado | Godot 4.7.1 concluiu sem erro de GDScript. |
| Take físico do lago | Aprovado | `origem_v2_phase114_take4_lakeshore.png` com log `[ORIGEM_QA]` da câmara regional. |
| Interação de porta e saída | Aprovado | `origem_v2_phase113_twilight_exterior.png` demonstra Elias já no exterior. |
| Estabilidade de 30 segundos | Aprovado | `origem_v2_phase113_twilight_stable_30s.png`. |
| Integridade do checkpoint | Aprovado | `ORIGEM_V2_RegionalWorld_Phase114_LakeRuins_Twilight_Validated.zip`. |

## Artefactos preservados

| Artefacto | Finalidade |
|---|---|
| `ORIGEM_V2_RegionalWorld_Phase114_LakeRuins_Twilight_Validated.zip` | Checkpoint recuperável completo, sem cache `.godot`. |
| `ORIGEM_V2_RegionalWorld_Phase114_LakeRuins_Twilight_Validated.sha256` | SHA-256: `facf3ad714d49e7e6a4478fc079ee2f520a99c82fb3d4ec268f1ff17e0e61b59`. |
| `origem_v2_phase114_take4_lakeshore.png` | Composição de QA para Lago das Ruínas Submersas. |
| `checkpoint114_gameplay_validation_observations.txt` | Registo da validação de porta, exterior e estabilidade de 30 segundos. |
| `levels/ForestLakeRegion.gd` | Lago, ruínas, rochas e vegetação ribeirinha. |
| `levels/LevelEnvironment.gd` | Perfil de crepúsculo e iluminação. |
| `levels/RegionalCinematicDirector.gd` | Takes físicos regionais e duração de QA. |

## Próximo ciclo recomendado

O próximo passe deve seguir para o **Take 5 — Vila Elevada e Observatório**, preservando o mesmo ciclo: alteração material, validação headless, captura durante a câmara realmente ativa, gameplay de 30 segundos e checkpoint antes de qualquer integração seguinte. A frente principal não altera a região de montanha/canyon sem revisão explícita da branch correspondente.

---

**Regra de continuidade:** nenhuma alteração visual, de rota ou de interação é aceite sem validação técnica e pelo menos 30 segundos de gameplay ou captura de cena.
