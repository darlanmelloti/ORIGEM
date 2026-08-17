# CP-CINE-33 — Calibração de Transformações Orion

A sonda na cena principal confirmou que as transformações globais da Região Orion coincidem com o sistema de terreno. Não existe um deslocamento de pai ou de região responsável pela captura inválida da abóbada CP-CINE-32.

| Medição | Coordenada global |
|---|---|
| Câmara QA de aproximação | `(-116, 43,469, 532)` |
| Boca Orion | `(-116, 39,987, 548)` |
| Câmara do Cube | `(-116, 45,143, 562)` |
| Altura de terreno em `z=559` | `41,484` |
| Altura de terreno em `z=590` | `52,903` |

A posição prevista do protótipo CP-CINE-32 era coerente com as medições. A origem provável da leitura sem abóbada é a orientação/culling da malha interior, não uma coordenada global errada. A instrumentação foi removida após a medição.

## CP-CINE-34 já iniciado

O próximo ciclo reconstrói uma amostra mínima da abóbada na mesma posição validada, com orientação de faces e material calibrados para visão **a partir do interior**. Nenhuma alteração à abertura Casa Voss ou às Regiões 1–6 será feita.
