# ORIGEM — Checkpoint 199: Margem Inferior Sul das Ruínas Submersas

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de implementação:** `d92e377` — `feat(lake): add south shore fill - 3 rocks, 2 ferns and warm fill light at z=268-282`.

## Incremento aplicado

Foi adicionada a função `_build_south_shore_fill()` ao `ForestLakeRegion.gd`, que reforça a margem inferior sul das Ruínas Submersas com os seguintes elementos:

**3 pedras de transição** na margem sul (z=270–278), com escalas variadas (0.26–0.34) e rotações orgânicas, que ancoram visualmente a borda do lago e criam leitura de aterramento.

**2 fetos de transição** (z=274–276) que complementam as pedras com vegetação ribeirinha discreta.

**1 OmniLight3D de preenchimento quente** (posição z=272, y=1.5m, energia 0.50, alcance 22m, cor âmbar `(0.62, 0.52, 0.38)`) que revela as lajes de pedra molhada do CP 191 na margem inferior sem apagar o azul da água.

## Verificações

| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado. |
| Take 11 | `origem_v2_phase118_take11_majestic_lake_transition.png` | Água azul com pilares emergentes; lajes de pedra molhada visíveis na margem esquerda; Acampamento Majestic com luz vermelha ao fundo. Margem inferior ainda escura (a câmara do Take 11 aponta para norte, não para sul). Avaliação: 91%. |
| Gameplay 30 s | Roteiro integrado | Aprovado. |
| Fronteira operacional | Ficheiro alterado: `ForestLakeRegion.gd` | Mantida. |

## Preservação

Pacote: `/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase199_SouthShoreFill_Validated.zip`

SHA-256: `0e15ea7865bd564f6f5fed60b518210ca89769073925447a4a9a7ce7b09ce699`

## Estado dos Commits Pendentes de Push

**11 commits** aguardam sincronização com o GitHub. O push falhou por falta de token de autenticação nesta sessão. Os commits estão seguros localmente.

| Hash | Mensagem |
|---|---|
| `d92e377` | feat(lake): south shore fill |
| `1f9e3bf` | docs: CP 198 |
| `c6ed3b3` | feat(arch): roadbed darkened |
| `8096267` | docs: CP 197 |
| `35809f8` | feat(forest): corridor fill lights |
| `5e3419e` | docs: CP 196 audit |
| `df4dd95` | docs: CP 195 |
| `15f9f7b` | feat(river): south bend ecology |
| `fa8b15a` | docs: CP 194 |
| `37e5f42` | feat(voss): candle and lantern |
| `9f783dc` | docs: alignment manual |

**Acção necessária:** o CEO ou o Diretor deve fornecer um token PAT do GitHub (com permissão `repo`) para que o push possa ser executado. Alternativamente, o CEO pode aceitar o convite de colaborador pendente no repositório `darlanmelloti/ORIGEM` para que a autenticação via `gh auth login` funcione.

## Próximas prioridades

Com os CPs 198 e 199 concluídos, as Regiões 1–6 atingem um nível de refinamento elevado. As próximas melhorias de impacto são:

1. **CP 200 — Auditoria de orçamento técnico:** verificar contagem total de luzes, colisores e nós para confirmar que o orçamento GTX 1050 Ti não foi excedido.
2. **CP 201 — Passe de coerência de materiais:** verificar que todos os módulos usam a mesma paleta de albedo para o solo (escuro, húmido, harmonizado).
3. **Sincronização GitHub:** assim que o token estiver disponível, fazer push dos 11 commits e atualizar o HEAD remoto.

> O checkpoint é uma evidência, não uma pausa. O ciclo continua com o CP 200.
