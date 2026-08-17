# CP-CINE-08 — Revelação progressiva R6 → Vila Elevada

A validação usou três câmaras QA de distância fixa. A primeira confirma a estrada a sair das Ruínas Submersas; a segunda traz a borda da Vila Elevada para o plano médio; a terceira confirma a chegada próxima. A escala cartográfica foi preservada em todos os frames.

| Janela | Leitura observada | Resultado |
|---|---|---|
| Saída R6 `(30, 282)` | Lajes conduzem para uma vila remota; vegetação lateral não fecha o eixo | Aprovado |
| Terraços `(68, 307)` | Casas e socalcos ganham leitura intermédia, mantendo estrada visível | Aprovado |
| Vila `(104, 329)` | A primeira conífera `ConiferaElevada_00` bloqueava a chegada | Corrigido na integração |
| Vila corrigida | A árvore foi removida somente da silhueta que atravessava o eixo; coníferas restantes enquadram laterais e edifícios dominam a chegada | Aprovado |

A prova OpenGL de 30 segundos após a correcção passou sem erro de script ou crash. A alteração permanece no branch de integração `feature/cine07-final`; ela não modifica a fronteira da branch Dev1.

## CP-CINE-09 já iniciado

A próxima avaliação deve medir a chegada da Vila Elevada ao Observatório, mantendo os mesmos critérios: estrada física, marcos revelados pela distância correcta, vegetação descontínua e nenhuma redução artificial da escala do mapa.
