# Auditoria de Escala Macro — Espelho Cartográfico

## Diagnóstico

As âncoras actuais mantêm correctamente a ordem espacial do mapa, mas a leitura da saída da Casa Voss ainda sofre de compressão: Casa Voss está em `(-22, 8)`, a Estrada começa em `(-21,4, 12)` e o Arco em `(-16,7, 48)`. A relação preserva a rota, porém o primeiro destino monumental ocupa aproximadamente quarenta unidades de profundidade e ainda pode parecer próximo quando a lente abre o vale.

A cadeia completa Casa Voss → Câmara Orion estende-se até cerca de 556 unidades no eixo norte. Para comunicar um mundo de escala épica, os marcos não devem ser trazidos para junto da Casa; devem ser apresentados em três estratos de profundidade e, gradualmente, migrados para uma escala física maior.

| Estrato | Marcos | Intervalo alvo de leitura | Regra espacial |
|---|---|---|---|
| Primeiro plano | 1–3: Casa, Estrada, Arco | 0–300 m equivalentes | A rota é física, com superfícies e colisores; o Arco é visível mas não imediatamente alcançável. |
| Vale médio | 4–6: Floresta, Acampamento, Ruínas Submersas | 300–1 200 m equivalentes | Massa vegetal, água e ruínas devem criar parallax, ocultação parcial e transições de relevo. |
| Horizonte e maciço | 7–12: Vila, Observatório, Trilha, Orion, Hub | 1,2–3,0 km equivalentes | Silhuetas reais de baixo custo e LOD; não podem ser painéis, nem exigir colisão activa antes do jogador se aproximar. |

## Contrato de reescala

A meta de migração é uma referência de **2,5×** a partir da Casa Voss: `posição macro = CasaVoss + (âncora - CasaVoss) × 2,5`. A aplicação não será um deslocamento cego de todos os nós. Cada frente deve primeiro manter a âncora lógica usada pelo mapa, depois mover geometria, caminhos, handoffs, spawns e LOD de forma coordenada, comprovando que a rota continua jogável.

> **Regra de composição:** profundidade vem de distância, relevo, oclusão e parallax. Não é permitido diminuir FOV, aproximar marcos, colar silhuetas ao jogador ou usar fundos falsos para simular escala.

## Primeira aplicação Dev1

O CP de profundidade começa no corredor Casa–Estrada–Arco. A Casa preserva o primeiro plano; a Estrada passa a desenvolver-se em camadas; o Arco recebe posição de plano médio e deve permanecer visível como destino, não como portal imediato. A migração dos marcos 4–6 acompanha esse ajuste depois da validação do primeiro corredor. Os marcos 7–12 serão executados por Dev2 sob o mesmo contrato.
