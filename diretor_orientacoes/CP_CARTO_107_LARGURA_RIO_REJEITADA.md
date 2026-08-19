# CP-CARTO-107 — Largura Inicial do Rio Rejeitada

## Teste reversível

A largura inicial da `SuperficieRioEstrada` foi reduzida de 14,0 m para 10,8 m e, numa segunda iteração, para 8,6 m. Ambas as variantes preservaram eixo, rota, margens e marcos e passaram 36 segundos de gameplay nas tomadas lateral e Casa Voss→Arco.

Nenhuma variante atingiu ganho visual suficiente: a massa escura lateral permaneceu materialmente semelhante nas capturas, enquanto a redução de largura começava a comprometer a escala hídrica definida no mapa cartográfico. A largura canónica foi restaurada para **14,0 m**.

| Variante | Evidência | Decisão |
|---|---|---|
| 10,8 m | `voss_lateral_cp106_width` e `road_to_arch_cp106_width` | REJECTED_VISUAL |
| 8,6 m | `voss_lateral_cp106_width86` | REJECTED_VISUAL |
| 14,0 m | Estado restaurado | PRESERVADO |

A próxima tarefa não pode reduzir a largura do rio, trocar o seu material, alterar neblina ou acrescentar uma rocha isolada. A auditoria seguinte deve localizar o segundo contribuinte de geometria escura que permanece visualmente independente da largura do rio.
