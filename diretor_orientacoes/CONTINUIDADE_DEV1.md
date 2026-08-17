# CONTINUIDADE_DEV1 — CP 330 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos das Regiões 7–12.

## Base preservada

Os CPs 317–330 consolidaram a tomada recuada de Casa Voss, a prioridade da câmara de prólogo, a materialidade PBR de terreno e a confirmação da chegada arqueológica ao Arco das Ruínas. A ponte positiva em `z=58` permanece um marco lateral real; a rota espacial e visual principal é Casa Voss → Estrada do Rio → Arco das Ruínas em `z=92`.

O CP 331 corrigiu a abertura em instâncias normais e QA. O contentor `Geometry`, `Interactables`, o protótipo do interior do santuário e os emissores Chronos são ocultados de forma determinística durante a abertura; a restituição depois do handoff devolve Geometry, interacções e a câmara de Elias. A validação headless, a auditoria de emissões QA, a captura aos 18 segundos e 30 segundos de gameplay normal passaram.

## CP 332 — Em execução imediata

**Objectivo:** auditar a composição macro da tomada recuada da Casa Voss contra a referência cartográfica oficial. Escolher no máximo uma melhoria física de alto impacto para a leitura simultânea de Casa, rio, Estrada do Rio e Arco das Ruínas; não repetir candidatos de câmara, ponte, talude, atmosfera, vegetação ou escala já revertidos.

A sequência de evidência para Dev3 mantém três pontos físicos: Casa Voss, aproximação da ponte positiva como marco lateral e Arco das Ruínas como destino. Nenhum checkpoint encerra o ciclo. O CP 332 deve manter a escala real do vale, a faixa jogável e a fronteira exclusiva das Regiões 1–6/Takes 1–11.
