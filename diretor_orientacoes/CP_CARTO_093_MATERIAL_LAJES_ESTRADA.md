# CP-CARTO-093 — Legibilidade Material da Estrada do Rio

## Decisão

**PASS técnico; ganho visual local preservado.** O material das lajes da Estrada do Rio recebeu um tom mineral mais quente e uma intensidade normal ligeiramente inferior. A rota manteve a mesma malha, a mesma escala, os mesmos colisores e o mesmo alinhamento cartográfico; não foram alterados água, vegetação, Arco ou luzes.

A captura de 36 segundos torna a sequência de lajes mais destacada contra o solo PBR castanho-esverdeado, sobretudo no primeiro e médio planos. O ganho é incremental, não uma aprovação da composição global: o horizonte e os activos vegetais continuam abaixo do padrão artístico final.

## Validação

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay Casa Voss→Arco | 36 segundos, PASS |
| Rota e colisores | Preservados |
| Luzes dinâmicas adicionais | 0 |
| Captura | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_path_material/road_to_arch_36s.png` |

## Continuidade

O próximo passe deve trabalhar a **massa vegetal do horizonte em planos orgânicos**, sem repetir proxies humanos, arcos alternativos, portais, cairns, estelas, pontes, relva procedural, alterações de água ou filtros de marcador já rejeitados.
