# CP-D5-023 — Catálogo de alturas e contratos de aterramento R1–R6

**Objectivo:** estabelecer uma regra única e auditável para futuros candidatos Dev5 que precisem de chegar ao solo real sem alterar a cartografia. Este documento é um contrato de integração, não uma autorização para modificar módulos de produção.

> **Invariante cartográfica:** o sistema Dev5 conserva sempre o X/Z canónico e usa raycast vertical apenas para resolver Y. Alturas manuais não podem ser promovidas a integração.

| Região | Marco e âncora X/Z | Proprietário do terreno | Origem de altura válida | Colisor esperado / exclusões | Candidato Dev5 elegível | Contrato de aterramento |
|---|---|---|---|---|---|---|
| R1 | Casa Voss `(-22, 8)` | `VossHouse.gd` | `_ground_height()` sobre `TerrainPatch` pai | `TerrainPatch`; a Soleira Panorâmica não é colisor de chão | Anexo Casa Voss | Raycast obrigatório antes de proposta; Y somente |
| R2 | Estrada do Rio `(-21,4, 12)` | `RiverRoadJourney.gd` | `TerrainPatch` e altura das lajes da rota | `ColisorLajeEstradaRio_*` (`BoxShape3D`); não deformar a estrada | Ponte Marco 2 | Raycast no terreno; não interceptar o tabuleiro da estrada |
| R3 | Arco das Ruínas `(-16,741, 48)` | `RiverRoadJourney.gd` | `TerrainPatch` regional | Bordo do `TerrainPatch`; excluir `ColisorPilarArco_*` | Nenhum | Não repetir o arco estrutural rejeitado no CP-D5-010 |
| R4 | Floresta Densa `(-9, 116)` | `ForestLakeRegion.gd` | `TerrainPatch` sob o corredor | `TerrainPatch`; excluir `ColisorLajeFloresta_*` da faixa jogável | Vegetação média R4 | Raycast fora de lajes, rota e troncos com colisão |
| R5 | Acampamento Majestic `(-88, 178)` | `ForestLakeRegion.gd` | `TerrainPatch` e patamar de acampamento | `TerrainPatch`; excluir `ColisorTendaMajestic_*` e ligação Majestic | Pavilhão Majestic | Raycast lateral; preservar o anel e a ligação física |
| R6 | Ruínas Submersas `(60, 252)` | `ForestLakeRegion.gd` | `TerrainPatch` da margem | `TerrainPatch`; excluir lajes de chegada e pilares submersos | Nenhum | Não repetir o cais de lajes rejeitado no CP-D5-017 |

## Regras de integração

A cena QA pode demonstrar contacto em terreno inclinado, mas a integração exige uma segunda validação no módulo do proprietário. Um candidato não pode usar a altura de uma laje, tenda, pilar ou outra peça como substituto do solo quando essa peça pertença à rota ou constitua obstáculo. A prova deve indicar explicitamente o colisor atingido, a posição de impacto e a preservação de X/Z.

Os marcos R3 e R6 têm a restrição adicional de não reabrir candidatos já rejeitados. A ausência de candidato elegível não é bloqueio operacional: obriga a frente Dev5 a passar ao próximo item da escada de contingência.

## Evidência técnica prevista

`CartographicHeightContracts.gd` contém os seis contratos legíveis por máquina. `CartographicHeightContractsPreview.tscn` verifica cobertura, X/Z, proprietário, fonte de altura, colisor esperado e modo de aterramento antes de gerar telemetria e captura interna.

## Continuidade automática

Após a validação e publicação deste checkpoint, o **CP-D5-024** torna-se activo: uma composição QA multi-marco que compare o anexo Casa Voss e a Ponte Marco 2, ambos aterrados no mesmo terreno físico irregular. A composição deve validar escala, X/Z e ausência de objectos suspensos, sem reintroduzir a composição R1→R3 de planos simples rejeitada no CP-D5-021.
