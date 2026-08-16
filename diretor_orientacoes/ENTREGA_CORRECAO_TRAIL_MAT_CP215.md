# ORIGEM — Entrega Corrigida: Erro `trail_mat` no Novo Jogo

**Branch:** `feature/dev1-gameplay-core`  
**Módulo corrigido:** `levels/TempleLevel.gd`  
**Pacote substituído:** CP 210  
**Estado:** corrigido, validado e pronto para nova distribuição.

## Diagnóstico

Ao iniciar um novo jogo, o Godot reportava um erro de parser na linha 510 de `TempleLevel.gd`:

```text
Identifier "trail_mat" not declared in the current scope.
```

A função `_build_region7_transition()` declara o material local `stone_mat`, mas a laje do corredor tentava usar a variável inexistente `trail_mat`. O erro não era causado pelo Dev2: tratava-se de uma versão desactualizada de `TempleLevel.gd` que permaneceu dentro do pacote CP 210 depois de a correcção já ter sido integrada no repositório.

## Correcção Aplicada

```gdscript
# Antes — inválido
slab.material_override = trail_mat

# Depois — válido
slab.material_override = stone_mat
```

## Validação da Entrega

| Verificação | Resultado |
|---|---|
| Procura global por `trail_mat` em `levels/*.gd` | ✅ Nenhuma referência encontrada |
| Arranque headless Godot 4.7.1 | ✅ Aprovado |
| Gameplay integrado — prólogo 30 s | ✅ Aprovado |
| Gameplay integrado — Acampamento Majestic → lago 30 s | ✅ Aprovado |

> O pacote corrigido substitui o ZIP anterior. O utilizador deve extrair o novo ZIP numa pasta limpa, importar o `project.godot` e executar novamente o botão **Novo Jogo**.
