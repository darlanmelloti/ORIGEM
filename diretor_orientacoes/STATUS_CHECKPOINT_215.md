# ORIGEM — Checkpoint 215: Auditoria de Colisores do Percurso Principal

**Branch:** `feature/dev1-gameplay-core`  
**Âmbito:** Casa Voss → Estrada do Rio → Ponte de Pedra → Floresta Densa → Acampamento Majestic → Ruínas Submersas.  
**Resultado:** aprovado; nenhuma correcção de código foi necessária neste checkpoint.

## Escopo da Auditoria

A auditoria verificou a distribuição programática dos volumes físicos e executou os percursos automatizados que cobrem o prólogo, a rota Majestic→lago e a Ponte de Pedra. A geometria visual recentemente introduzida no CP 214 não recebeu colisor, pelo que não pode bloquear a ponte nem criar um desvio na rota principal.

| Módulo | `CollisionShape3D` declarados | Leitura da auditoria |
|---|---:|---|
| `VossHouse.gd` | 4 | Estrutura da casa e saída mantêm passagem operacional |
| `RiverRoadJourney.gd` | 3 | Lajes e margens controladas; sem bloqueio da Estrada do Rio |
| `DaylightValley.gd` | 1 | Colisor principal da Ponte de Pedra preservado |
| `ForestLakeRegion.gd` | 14 | Lajes, troncos e acampamento distribuídos fora do eixo de passagem |
| `TempleLevel.gd` | 2 | Integração do mundo e transição preservadas |

## Verificação Obrigatória

| Verificação | Resultado |
|---|---|
| Headless Godot 4.7.1 | ✅ Aprovado pelo QA integrado |
| Gameplay — prólogo 30 s | ✅ Aprovado |
| Gameplay — Acampamento Majestic → lago 30 s | ✅ Aprovado |
| Gameplay — Ponte de Pedra 30 s | ✅ Aprovado |
| Pedras emergentes CP 214 | ✅ Sem colisor; não bloqueiam a ponte |
| Fronteira Regiões 7–12 | ✅ Mantida |

> Os avisos ALSA observados no contêiner de validação referem-se apenas à indisponibilidade de dispositivo de áudio físico. O motor usa o fallback de áudio e o teste de arranque e percurso termina aprovado.

## Próximo Passo do Dev1

Iniciar **CP 216 — reforço da leitura hídrica do rio**, acrescentando apenas detalhe visual de baixa carga às águas da Estrada do Rio e mantendo os mesmos percursos livres. O checkpoint deverá ser validado por headless e gameplay de 30 segundos antes de sincronização.
