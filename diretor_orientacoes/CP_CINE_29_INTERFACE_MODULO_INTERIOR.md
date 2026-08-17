# CP-CINE-29 — Interface do Módulo Interior Orion

O primeiro módulo interior será criado como filho de `OrionDestinationRegion`, mas começa **oculto e desligado da interacção**. O gatilho CP-CINE-28 limitar-se-á a activar o módulo; o jogador não é reposicionado até existir uma passagem física validada.

| Interface | Regra |
|---|---|
| Activação | `GatilhoFisicoInteriorOrion` marca `interior_handoff_ready` e activa a soleira |
| Posição | A soleira nasce abaixo da garganta, com origem local própria e sem coincidir com o Cube existente |
| Movimento | Sem teletransporte automático neste bloco |
| Saída | Não implementada no bloco inicial; a soleira continua reversível porque nenhum estado de campanha é modificado |
| Cube / altar | Mantidos ocultos e fora do módulo |
| Câmaras | A câmara do jogador permanece inalterada |

A geometria inicial será composta somente por piso contínuo, duas paredes curtas e um teto baixo, todos pertencentes ao mesmo módulo. O teste exigirá a cena principal renderizável e 30 segundos de execução.
