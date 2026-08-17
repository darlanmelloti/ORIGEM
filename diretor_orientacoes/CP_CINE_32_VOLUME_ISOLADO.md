# CP-CINE-32 — Separação do Volume Subterrâneo Orion

A falha CP-CINE-31 demonstrou que um módulo enterrado apenas alguns metros abaixo do terreno ainda pode expor céu através do enquadramento e das lacunas entre geometria aberta. O próximo protótipo será isolado da superfície por posição e por volume.

| Zona | Coordenada/Regra |
|---|---|
| Garganta exterior | Superfície, eixo `x=-116`, até `z=553` |
| Soleira física | Módulo de transição existente; mantém-se oculto até ao gatilho |
| Protótipo fechado | 18 m abaixo da altura do terreno, deslocado para `z=590` |
| Ligação | Apenas contrato lógico neste checkpoint; não haverá passagem visual falsa |
| Cube / altar | Fora do protótipo |
| Câmara QA | Só activa depois de o volume fechado estar carregado |

O volume CP-CINE-32 terá chão, paredes e teto pertencentes ao mesmo nó. O material de pedra será usado de forma contínua e uma única luz neutra ficará integralmente dentro do volume. Se qualquer céu ou superfície exterior aparecer na captura, o protótipo será revertido.
