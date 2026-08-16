# Correcção de compilação — `trail_mat` em `TempleLevel.gd`

## Diagnóstico

O arranque de Novo Jogo falhava na linha do trilho da Região 7 porque `_build_region7_transition()` atribuía `slab.material_override = trail_mat`, embora `trail_mat` não estivesse declarado no escopo da função. A função já possuía o material local `stone_mat`, preparado imediatamente antes do loop de lajes.

## Correcção aplicada

A linha foi alterada para:

```gdscript
slab.material_override = stone_mat
```

A alteração é mínima, preserva a lógica do trilho, os colisores e a fronteira das Regiões 1–6, e elimina a referência a um identificador inexistente.

## Validação

| Verificação | Estado |
|---|---|
| Godot 4.7.1 headless/editor parser | Sem `trail_mat`, `Parse Error` ou `SCRIPT ERROR` |
| Arranque headless da cena principal | Sem diagnóstico de compilação; processo mantido sob timeout de teste |
| Alteração de geometria regional | Não realizada |
| Ficheiro alterado | `levels/TempleLevel.gd` |

## Estado

`PASSED_TECHNICAL` — correcção pronta para sincronização na branch `feature/dev1-gameplay-core`. Recomenda-se executar F5 localmente e clicar em **Novo Jogo** para confirmar a transição interactiva na instalação do director.
