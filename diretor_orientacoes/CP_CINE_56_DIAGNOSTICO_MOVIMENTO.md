# CP-CINE-56 — Diagnóstico de Movimento no Corredor Orion

## Validação executada

A trajectória QA foi executada com três pontos físicos sobre a rota interior: soleira `(0.00, 0.90, 0.45)`, primeiro desvio `(-0.85, 0.90, 5.20)` e profundidade `(-2.15, 0.90, 10.80)`. A validação técnica headless e uma sessão renderizada de 30 segundos concluíram sem erros.

## Evidência dos estágios 0 e 1

O avanço desde a soleira até ao primeiro desvio não altera a leitura predominante: a parede próxima ocupa a maior parte do enquadramento e o espaço de circulação permanece como uma zona escura à direita. Isto confirma que o problema não é a orientação inicial da câmara nem a ausência de comprimento do corredor. A geometria visual do anel lateral aproxima-se em excesso da câmara no eixo actual, reduzindo a legibilidade da progressão.

A correcção seguinte deverá ajustar a secção transversal inicial da malha — em particular o raio do flanco esquerdo e o ponto onde começa a curvatura — sem afectar suporte físico, spawn, handoff ou orçamento de duas luzes locais.

## Evidência do estágio 2 e decisão

No ponto profundo, o enquadramento conserva a mesma assimetria: material de rocha muito próximo à esquerda e uma abertura preta à direita, sem marco que confirme a direcção da rota. A persistência nos três pontos exclui uma falha localizada de luz ou de spawn.

**Próximo passe aberto — CP-CINE-57:** alargar selectivamente o volume do flanco esquerdo nos primeiros anéis e atrasar a curva a oeste para depois do primeiro desvio. A alteração será única, reversível e limitada à malha visual; a base física invisível continuará a suportar Elias sem alterações.

## CP-CINE-57 — Reversão do perfil aberto

O perfil experimental alargado e a curva atrasada foram testados pela mesma trajectória de 30 segundos. O resultado não melhorou a leitura: a massa de rocha continuou a ocupar a tomada e a abertura negra continuou sem indicar destino. O ajuste foi revertido integralmente.

> **Candidato rejeitado:** aumentar apenas o raio lateral e adiar a curva nos anéis iniciais. Não repetir sem uma alteração complementar de linguagem espacial.

O próximo CP deverá introduzir **um marco volumétrico real de orientação** no fundo da rota — por exemplo, uma formação de rocha central ou uma abertura de câmara lateral — em vez de continuar a modificar o volume uniforme do corredor.

## CP-CINE-58 — Reversão da luz de orientação pessoal

A calibração mais forte da luz direccional já anexa à câmara de Elias foi testada durante 30 segundos depois de restaurado o identificador canónico `Flashlight`, necessário ao controlador de combate. A alteração não produziu ganho visual material no enquadramento. Os valores padrão foram restaurados.

> **Candidato rejeitado:** aumentar energia, alcance e cone da luz pessoal sem alterar a linguagem espacial do corredor.

**Próxima melhoria aberta:** criar um marco tridimensional de orientação, aproveitando geometria existente e sem emitir nova luz dinâmica; a decisão será validada primeiro em captura estática e depois em movimento.
