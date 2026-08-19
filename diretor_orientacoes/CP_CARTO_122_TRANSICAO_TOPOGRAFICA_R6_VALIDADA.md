# CP-CARTO-122 — Transição topográfica R5→R6 validada

## Problema causal

A auditoria de caixas envolventes demonstrou que as instâncias locais e as camadas de interface não explicavam a massa rectangular escura no quadrante direito da chegada às Ruínas Submersas. A causa estrutural estava na própria função de altura: o corredor ribeirinho usava uma fórmula de altura baixa até `z=252`, enquanto a célula seguinte regressava directamente ao terreno regional, criando uma transição de relevo abrupta numa única faixa de malha.

## Correcção aplicada

A zona ribeirinha passou a estender-se até `z=270`. Entre `z=238` e `z=270`, a sua altura é agora interpolada com `smoothstep` entre o perfil baixo de margem e o perfil regional. A rota, a água, os marcos, as luzes e as Regiões 7–12 não foram alterados.

## Validação

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay da chegada R6 | 36 segundos |
| Captura de evidência | Xvfb, 1600×900, segundo 30 real |
| Falésia rectangular à direita | Removida |
| Continuidade física R5→R6 | Preservada |
| Luzes dinâmicas adicionais | 0 |

> Evidência: `/home/ubuntu/qa_evidence_dev1_cp245/ruins_arrival_cp122_transition/ruins_arrival_36s.png`

## Decisão

**PROMOVIDO.** A chegada às Ruínas Submersas deixa de apresentar a parede rectangular escura e passa a revelar uma encosta contínua, compatível com a escala cartográfica e com a premissa de geometria tridimensional real.
