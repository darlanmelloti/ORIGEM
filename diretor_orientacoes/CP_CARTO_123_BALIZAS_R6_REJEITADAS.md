# CP-CARTO-123 — Balizas das Ruínas Submersas rejeitadas

A remoção das três balizas azul-ciano dos marcos emergentes R6 foi testada sem alterar pilares, colisores, água ou rota. O parser Godot 4.7.1 passou e a chegada foi capturada no segundo 30 de uma sessão de gameplay de 36 segundos.

A pequena luz azul ainda visível na chegada não pertence às balizas removidas; a silhueta arqueológica também não obteve ganho suficiente para justificar a remoção. A alteração foi revertida integralmente.

| Critério | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Gameplay R6 | 36 s |
| Captura tardia | PASS, 1600×900 |
| Ganho de silhueta | Insuficiente |
| Produção | Revertida |

**Próxima investigação:** atribuir a luz azul residual a um marco diferente antes de qualquer alteração adicional; não repetir a remoção das balizas `BrilhoMarcoRuina`.
