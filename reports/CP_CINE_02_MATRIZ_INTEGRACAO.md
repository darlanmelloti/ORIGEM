# CP-CINE-02 — Matriz de Integração da Tomada Mestre

A composição Casa Voss → Vale de Kheper é um contrato visual entre frentes. Esta matriz converte a referência cartográfica e a imagem conceptual em tarefas de retorno verificável. O Dev3 não altera geometria: enquadra, mede, recaptura e encaminha lacunas à frente proprietária.

| Lacuna observada | Acção solicitada | Proprietário | Evidência de retorno | Critério cinematográfico |
| --- | --- | --- | --- | --- |
| Casa Voss não ocupa claramente a margem esquerda | Testar ponto físico de câmara na soleira/terraço compacto ou abrir linha de vista com arquitectura existente | Dev1 | Captura 16:9 da abertura e execução de 30 s | Parede, porta, cobertura ou soleira reais entram à esquerda sem encobrir o vale |
| Ponte, Estrada e Arco pouco separados | Manter as silhuetas acima de taludes e colocar a Estrada como diagonal de fuga | Dev1 | Captura da soleira com pontos 2 e 3 | Ponte, lajes e arco lêem-se em três planos distintos |
| Bacia, Acampamento e floresta ainda não formam massa central | Consolidar profundidade por água, clareiras e copas em camadas | Dev1 | Captura entre a soleira e a entrada da floresta | O centro do vale tem água, relevo e vegetação orgânica, sem parede vegetal |
| Vila, Observatório e Orion não possuem leitura panorâmica contínua | Construir massas em socalcos e silhuetas de serra de acordo com as âncoras cartográficas | Dev2 | Captura de handoff panorâmico 16:9 | Flanco direito urbano e pico Orion são distinguíveis sem painéis ou faróis técnicos |
| Sinais Chronos ciano contaminam o prólogo | Manter emissões técnicas ocultas até ao fim da abertura | Dev1 / Dev2 | Captura sem HUD de prólogo | Nenhum ponto técnico compete com leitura de rocha, água e construção real |
| Tomada não cobre toda a cadeia | Configurar e repetir o take de QA no `RegionalCinematicDirector.gd` quando os frames físicos chegarem | Dev3 | Captura de take + relatório comparativo | Ordem espacial 1→12 coincide com a autoridade cartográfica |

## Procedimento de recaptura

O Dev3 recebe a próxima evidência Dev1 ou Dev2, compara-a com `references/MAP.webp` e `references/origem_vale_12_pontos_casa_voss.webp`, e publica uma nota com três campos: ganho visual, lacuna remanescente e próximo proprietário. Um take só é dado por aceite quando a arquitectura da Casa enquadra a saída, a rota rio–Arco guia o olhar e os marcos remotos se apresentam por continuidade real de terreno.

## CP-CINE-03 — iniciado automaticamente

Preparar a recaptura comparativa do Take 1 a partir do primeiro frame CP 289 enviado por Dev1. Se a captura não incluir a Casa na margem esquerda e ao menos ponte/Estrada/Arco em planos distintos, devolver imediatamente uma nota de correcção para Dev1 e manter a próxima recaptura em execução.
