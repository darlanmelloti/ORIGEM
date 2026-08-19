# CP-D5-079 — Orientação exterior de Elias em R1

**Escopo:** revalidação de um preview Dev5 isolado. A cena não abre, altera ou corrige a porta da Casa Voss; também não modifica `VossHouse.gd` ou `Player.gd`.

## Contrato QA

| Critério | Resultado |
|---|---|
| Origem | Casa Voss R1 `(-22,8)` |
| Rumo inicial | Estrada do Rio R2, id `2` |
| Actor | Elias em terceira pessoa |
| Câmara | Externa; câmara interna de Elias inactiva |
| Aterramento | Casa técnica e ponte modular por raycast |
| Passagem | 10 ciclos de rumo em 36 segundos, sem bloqueio QA |
| Produção | Casa e Player inalterados |

## Revisão visual

A captura posiciona a casa técnica de referência, Elias e a ponte modular no mesmo enquadramento. A leitura espacial é suficiente para a validação de orientação R1→R2, mas não substitui o teste integrado da porta [E] dentro da Casa Voss de produção, que continua sob responsabilidade Dev1.

## Próxima tarefa automática

**CP-D5-080 — Matriz de fronteira Dev5/Dev1.** Explicitar quais contratos QA Dev5 podem ser entregues ao Dev1 para integração e quais continuam apenas como evidência técnica, sem promover alterações automaticamente.
