# DEV3 — CP-CINE-05: Avaliação da abertura limpa Casa Voss

## Estado de entrada

O CP 331 foi publicado no commit `e10551c`. A tomada de abertura passou por validação Godot, prova de gameplay de 30 segundos e auditoria runtime: não existem emissores azuis técnicos visíveis durante a janela QA. A restituição pós-prólogo devolve Geometry, interacções e a câmara de Elias.

## Evidências obrigatórias

| Artefacto | Uso |
|---|---|
| `qa_evidence_voss_vista/cp331_clean_frame_final.png` | Tomada limpa actual a avaliar |
| `qa_evidence_voss_vista/cp329_road_markers.png` | Estado anterior para comparação de estrada e marcos |
| `references/origem_vale_12_pontos_casa_voss.webp` | Referência conceptual obrigatória |
| `reports/CP332_AUDITORIA_MACRO_CASA_VOSS.md` | Restrições e hipótese Dev1 |

## Pedido de avaliação

Avaliar exclusivamente a composição: primeiro plano Casa Voss à esquerda, leitura lateral do rio, linha de fuga da Estrada do Rio, cadência de ruínas intermédias, Arco das Ruínas como destino e profundidade da serra. Não pedir confirmação nem encerrar após a avaliação: entregar uma escolha de prioridade única e imediatamente abrir o CP-CINE-06 com o próximo teste de composição.

## Restrições de integração

O Dev3 não altera `TerrainPatch.gd`, `RiverRoadJourney.gd`, `ForestLakeRegion.gd`, câmaras, colisores nem qualquer módulo das Regiões 1–12. Deve limitar-se a `RegionalCinematicDirector.gd`, evidências e relatórios da frente cinematográfica. Quando houver lacuna espacial, enviar uma ordem precisa ao Dev1, com marco, profundidade, posição no quadro e critério de retorno.

## Orientação inicial da auditoria

A cadeia ainda é menos articulada que a referência entre a Casa e o Arco. A hipótese Dev1 permitida é uma única intervenção de arquitectura de plano médio fora da faixa jogável; estão proibidas micro-rotações, mudanças de altura/fov, escala ou reforço isolado da ponte, janela topográfica, encontros de margem, talude e aumento de fetos. O retorno deve declarar claramente se essa hipótese é justificável antes de a geometria ser alterada.

> Um relatório é evidência, não fim de ciclo. Depois de CP-CINE-05, CP-CINE-06 fica imediatamente em execução.
