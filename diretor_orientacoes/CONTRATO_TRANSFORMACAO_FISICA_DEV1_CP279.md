# Contrato de Transformação Física Dev1 — CP279

## Decisão executável

O mapa cartográfico é a autoridade espacial. A rota jogável Dev1 passa a usar o **eixo positivo Z** como direcção única de progressão:

| Marco | Âncora cartográfica | Faixa física Dev1 | Responsável |
|---|---:|---:|---|
| Casa Voss | `(-22, 8)` | `z≈8–12` | Dev1 |
| Estrada do Rio | `(-21,4, 12)` | `z≈12–92` | Dev1 |
| Arco das Ruínas | `(-16,741, 48)` | portal monumental em `z=92`; a diferença de escala é intencional para preservar a viagem macro | Dev1 |
| Floresta Densa | `(-9, 116)` | limiar em `z≈101–116` | Dev1 |
| Acampamento Majestic | `(-88, 178)` | chegada em `z≈178` | Dev1 |
| Ruínas Submersas | `(60, 252)` | bacia e margem em `z≈252` | Dev1 |

## Regra de alinhamento

> Nenhum novo elemento de rota, ponte, água navegável, colisor ou marco principal pode ser criado no eixo negativo Z como continuação da Casa Voss.

A geometria de `DaylightValley.gd` entre `z=12` e `z=-142`, incluindo a Ponte de Pedra em `z=-57`, é um **vestígio diurno lateral**. Ela não constitui a rota Casa → Estrada → Arco, não pode servir de destino da câmara de abertura e não pode receber extensões de progressão até ser migrada por um checkpoint próprio, com colisores e passagem validados.

## Primeira correcção aprovada

O CP280 cria uma **ponte de leitura do corredor positivo** no sector da Estrada (aproximação `z≈58`), com encontros rochosos e sem colisores novos. Ela será uma silhueta de vale visível desde a Casa e um marco antes do Arco em `z=92`. A ponte legada negativa permanece intacta e não é deslocada neste ciclo.

## Critérios de aceitação

A correcção só é aceite quando o Godot valida sem erros, a estrada central continua livre, a prova segmentada atinge 30 segundos de mundo jogável e a captura mostra Casa/estrada/ponte/Arco em camadas, sem encurtar a distância física ao Arco.

## Continuidade

Ao concluir CP280, Dev1 deve iniciar CP281: auditoria da leitura Floresta → Acampamento → Bacia sob o mesmo eixo positivo. Dev3 recebe a condição de recapturar Take 0C somente após a primeira ponte positiva e os marcos Dev2 de horizonte estarem presentes.
