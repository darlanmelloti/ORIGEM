# ORIGEM — DEV6-R6-WATERLINE-READING-003

**Estado:** implementação local concluída; validação runtime depende do ambiente Godot 4.7.1
**Responsável:** dev6
**Âmbito:** exclusivamente R6 — Ruínas Submersas
**Base integrada:** `origin/integration/r1-r6-sprint1` em `d5fdc827`

## Alteração

A leitura arqueológica da linha de água foi reforçada em `levels/ForestLakeRegion.gd` com nove pedras/detritos assimétricos sob o nó `R6_DetritosLinhaDeAgua`. Todos os elementos ficam fora da elipse da bacia e fora do corredor de chegada Majestic→R6. São exclusivamente visuais e não adicionam luzes, shaders, emissão, painéis, `StaticBody3D` ou `CollisionShape3D`.

A branch foi reconciliada com `origin/dev6/r6-submerged-ruins` em `702f410`, que já contém o merge da integração R1–R6 em `4e8260a` e preserva o handoff físico R6→R7. Nenhuma geometria de R7–R12 foi alterada.

## Auditoria local

| Verificação | Resultado |
|---|---|
| `git diff --check` | Passou |
| Detritos dentro da elipse de água | Zero |
| Detritos no corredor jogável | Zero |
| Colisores no bloco de waterline | Zero |
| Luzes novas no bloco de waterline | Zero |
| Shaders novos no bloco de waterline | Zero |
| Handoff R6→R7 | Preservado a partir de `702f410` |
| Godot 4.7.1 no sandbox | Ausente |

## Porta QA requerida

A porta `tools/qa/run_regional_gate.sh R6` deve executar parser, auditoria de quatro luzes, prova do handoff, porta R6 e as rotas `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival`. A execução local foi bloqueada antes dos testes porque a referência remota `origin/integration/r1-r6-sprint1` ainda não estava materializada no namespace local; a ponta remota foi confirmada como `d5fdc827` via `git ls-remote`. Após criar a referência local, repetir a porta no ambiente com Godot 4.7.1.

## Próxima tarefa ACTIVE

`DEV6-R6-CONTINUITY-AUDIT-004`: após a publicação e integração, repetir a matriz de quatro luzes, porta R6, handoff e as três rotas, comparando a linha de água antes/depois. Manter o foco em R6 e não adicionar novos efeitos até fechar essa auditoria.
