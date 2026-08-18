# CP-CARTO-31 — Materialidade da Estela e Limite de Iteração R6

**Branch:** `feature/cine07-final`  
**Escopo:** Região 6, sem alterações nas Regiões 7–12.  
**Estado:** materialidade da estela aprovada; ensaio de soleira adicional revertido por não demonstrar ganho perceptível.

## Decisão baseada em evidência

O primeiro ensaio CP-CARTO-31 adicionou massas laterais de rocha, feto e árvore ao limiar ocidental. A captura comparativa não mostrou ganho perceptível nessa tomada; a alteração foi removida integralmente antes da publicação. Esta reversão evita repetir a densificação lateral sem efeito visual comprovado.

O passe seguinte isolou a causa mais visível: a emissão do `ruin_material` sobre-exponha a estela de chegada. O material recebeu matiz mineral húmida e passou a responder somente à luz do mundo. A estela continua legível e interagível, agora sem o branco estourado da captura anterior.

| Verificação | Resultado |
| --- | --- |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** com `ruins_arrival` e `lake_stela` |
| Harness de interação | Elias e estela posicionados correctamente; aviso `[E] Examinar` visível |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto31_ruin_material_1600x900.png` |
| Erros de script, parse ou crash | **Nenhum detectado** |
| Integridade de diff | **Aprovada** — `git diff --check` limpo |
| Fronteira R7–R12 | **Preservada** |

## Avaliação

A comparação confirma melhora material específica: a estela já não domina a bacia por sobre-exposição e continua clara como ponto de chegada. A macro-composição do vale ainda não é declarada concluída; a próxima lacuna deve partir de uma prova ampla Casa Voss→Arco→Floresta→R6, em vez de acrescentar mais micro-props à mesma tomada curta.

> A publicação deste checkpoint não encerra o ciclo. O próximo passe deve testar a leitura cartográfica ampla usando as âncoras e o harness apropriado, sem alterar módulos Dev2.
