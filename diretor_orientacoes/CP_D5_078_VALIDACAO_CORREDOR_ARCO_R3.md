# CP-D5-078 — Corredor cartográfico Elias no arco R3

## Resultado

O preview `EliasArchCorridorPreview.tscn` passou uma sessão QA de 36 segundos em Compatibility headless. O corredor de Elias manteve a passagem aberta no arco R3 e apontou correctamente para a Floresta R4.

| Critério | Resultado |
|---|---|
| Âncora R3 X/Z | `(-16,741;48)` |
| Arco físico Z | `92` |
| Próximo destino | `RUMO À FLORESTA`, id `4` |
| Câmara de Elias actual | `false` |
| Estrutura artística do arco | `false` — preview estrutural isolado |
| Ciclos de rota | 2 |
| Rota aberta | `true` em ambos |
| Runtime | 36 segundos |
| `SCRIPT ERROR` | 0 |

A prova confirma a transição R3→R4 sem criar geometria de produção ou alterar `Player.gd`. A advertência FSR1 pertence ao renderer Compatibility local.

O log está em `CP-D5-078_ELIAS_ARCH_RUNTIME.log`.
