# CP-D5-024 — Composição multi-marco aterrada Casa Voss→Estrada

## Resultado

A cena `MultiLandmarkGroundedPreview.tscn` coloca o anexo Casa Voss no marco 1 e a Ponte do marco 2 sobre três volumes de terreno físico irregular. O sistema `CartographicGroundingSystem.gd` aplica raycast vertical e ajusta exclusivamente Y; os X/Z canónicos permanecem intactos.

| Candidato | Marco | Canvas | Y desejado | Y impacto | World X/Z | Grounded |
|---|---:|---|---:|---:|---|---|
| Casa Voss | 1 | `(80,452)` | 15,00 m | -2,52 m | `(-22,8)` | Sim |
| Ponte Marco 2 | 2 | `(234,462)` | 18,00 m | -2,52 m | `(-21,4;12)` | Sim |

A composição mostra os dois marcos no mesmo enquadramento, com ligação visual central e terreno inclinado entre eles. Não inclui o Arco estrutural rejeitado nem repete a composição plana CP-D5-021. Foram criados apenas módulos QA em `levels/dev5/`; nenhum módulo de produção foi alterado.

## Validação

A sessão headless completou 36 segundos. O runtime confirmou `anchors=1,2 irregular_ground=true production_script=false dynamic_lights=0`, com ambos os raycasts aterrados e X/Z preservados. O aviso FSR1 do renderer de compatibilidade é externo à cena.

## Próxima tarefa

A continuidade deve abrir automaticamente o CP-D5-025 após a publicação deste checkpoint.
