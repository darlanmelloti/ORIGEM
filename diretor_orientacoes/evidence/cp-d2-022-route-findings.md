# CP-D2-022 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Validação jogável separada da cadeia Região 11 → Região 12.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

Foram executados dois passes do mesmo harness, um com `QA_VALIDATION_REGION=11` e outro com `QA_VALIDATION_REGION=12`. Ambos passaram o parser/headless Godot 4.7.1, mantiveram gameplay de 30 segundos e produziram prints de 1600×900. A comparação visual dos dois prints mostra a mesma composição limpa, sem clipping dominante; as âncoras de validação permanecem invisíveis e não alteram o enquadramento.

| Região | Gameplay | Print |
|---|---:|---:|
| 11 | `96b6d74d24408374c5a6518297fa2db1b8e5400fd1bc717f69871f17f62551af` | `5800f9660654e9036334e1b60babb796b069000ac87ab1288e4b88687e6f6cab` |
| 12 | `843d59898f656a04b536b75a10dfa4200043bf54f242d957e424c23d7f7c7f60` | `154e0953035ae40ed8ced52e840021431a7965a674b8ef9f040111ccdf49c9fe` |

**Próxima acção imediata:** empacotar CP-D2-022 com o ZIP e SHA-256, sincronizar a evidência textual para `feature/dev2-mountain-canyon` e iniciar o próximo passe de integração física do percurso.
