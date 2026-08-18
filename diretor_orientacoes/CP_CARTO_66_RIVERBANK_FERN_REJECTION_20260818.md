# CP-CARTO-66 — Rejeição do Ensaio Alfa de Fetos Ribeirinhos

## Hipótese

Os pequenos props claros visíveis na prova Estrada do Rio→Arco poderiam pertencer aos nós `FetoMargemRio_*`, um grupo distinto dos fetos da Floresta e das Ruínas anteriormente auditados.

## Ensaio

Foi aplicado material PBR vegetal sem emissão, dupla face e alpha scissor apenas aos fetos da margem do rio da Estrada.

## Validação

O parser Godot 4.7.1 passou e o harness `road_to_arch` foi executado por 36 segundos. A captura `cp_carto66_riverbank_fern_1600x900.png` não mostrou redução perceptível dos props claros ou dos pontos ciano.

## Decisão

O helper e a chamada do ensaio foram removidos integralmente. Não repetir este passe de material nos `FetoMargemRio_*` sem nova evidência causal. CP-CARTO-56 continua aguardando Dev2.
