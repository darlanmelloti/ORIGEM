# CP-CARTO-65 — Rejeição do Ensaio Alfa de Fetos Arco→Floresta

## Hipótese

Os pequenos props claros da tomada Arco→Floresta poderiam pertencer aos grupos `FetoLimiarFloresta`, `FetoTransicaoArco` e `FetoSubBosqueLimiar`, que não participaram do passe ribeirinho R6.

## Ensaio

Foi aplicado material PBR vegetal sem emissão, rugosidade elevada, dupla face e alpha scissor apenas aos três grupos referidos.

## Validação

Godot 4.7.1 passou e o harness `arch_to_forest` foi executado por 36 segundos. A captura `cp_carto65_arch_fern_alpha_1600x900.png` manteve os props claros na mesma leitura, sem ganho visual perceptível.

## Decisão

O helper e a chamada do ensaio foram removidos integralmente. Não repetir esta materialização alfa nos fetos do limiar sem nova evidência causal. CP-CARTO-56 continua aguardando Dev2.
