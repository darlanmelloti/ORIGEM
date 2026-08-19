# CP-D5-040 — Auditoria de câmaras e luzes QA

## Resultado

A auditoria encontrou 16 declarações de `Camera3D` e 16 declarações de luz em 17 cenas/scripts QA Dev5. Cada harness usa, no máximo, uma câmara e uma luz direccional própria; a ausência de uma declaração numa cena corresponde a uma cena que instancia ambiente por outro caminho ou não exige uma câmara adicional. Não foram encontrados OmniLight3D, SpotLight3D ou luzes dinâmicas múltiplas no mesmo harness.

| Verificação | Resultado |
|---|---:|
| Câmaras declaradas | 16 |
| Luzes declaradas | 16 |
| Omni/Spot lights | 0 |
| Cenas/scripts QA inspeccionados | 17 |
| Parser editor Godot Compatibility | Sem erros Dev5 |
| Limite de 16 luzes dinâmicas globais | Não ameaçado por estes harnesses isolados |

A luz contabilizada é luz de ambiente/harness. Os objectos cartográficos não adicionam luzes próprias; a auditoria não promove os candidatos nem altera o mundo principal. R4/R6 continuam pendentes de viewport gráfico válido.

O log completo está em `CP-D5-040_LIGHT_CAMERA_AUDIT.log`.

## Próxima acção

Abrir o CP-D5-041 para a próxima auditoria/ficha QA ou melhoria de fundação permitida.
