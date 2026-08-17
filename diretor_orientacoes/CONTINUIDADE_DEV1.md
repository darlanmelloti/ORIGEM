# CONTINUIDADE_DEV1 — CP 330 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos das Regiões 7–12.

## Base preservada

Os CPs 317–330 consolidaram a tomada recuada de Casa Voss, a prioridade da câmara de prólogo, a materialidade PBR de terreno e a confirmação da chegada arqueológica ao Arco das Ruínas. A ponte positiva em `z=58` permanece um marco lateral real; a rota espacial e visual principal é Casa Voss → Estrada do Rio → Arco das Ruínas em `z=92`.

O CP 331 corrigiu a abertura em instâncias normais e QA. O contentor `Geometry`, `Interactables`, o protótipo do interior do santuário e os emissores Chronos são ocultados de forma determinística durante a abertura; a restituição depois do handoff devolve Geometry, interacções e a câmara de Elias. A validação headless, a auditoria de emissões QA, a captura aos 18 segundos e 30 segundos de gameplay normal passaram.

## CPs 332–335 — Auditorias e reversões registadas

O CP 332 comparou a tomada com a referência e determinou que o próximo ganho estrutural não poderia vir de câmara, ponte, talude, atmosfera, vegetação ou escala. O CP-CINE-05 testou uma cadeia arqueológica intermédia no CP 333; a captura não demonstrou ganho perceptível, logo a alteração foi revertida. O CP 334 testou macrotextura de solo sem ganho perceptível e também foi revertido. O CP 335 mapeou os nós da abertura e testou a ocultação de balizas remotas; essa hipótese foi igualmente revertida por não alterar a leitura do frame.

As reversões preservam a base CP317/CP331 e impedem reabertura de candidatos já esgotados. Todos os testes técnicos headless das hipóteses transitórias passaram; nenhum código de runtime destes três testes permaneceu no ramo.

## CP-CINE-07 — Em execução imediata

**Objectivo activo:** recapturar a tomada Casa Voss no FOV e posição CP317 quando o Dev2 integrar a cadeia remota R7–R9 ordenada em `DEV2_CP_CINE_06_CADEIA_MARCOS_REMOTOS.md`. O Dev1 não altera `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem módulos R7–R12; valida somente que a integração não regressa sobre Casa, Estrada, Arco, água, colisores ou escala do vale.

A matriz obrigatória está em `CP_CINE_07_MATRIZ_RECAPTURA_CASA_VOSS.md`. A sequência de evidência mantém Casa Voss, ponte positiva como marco lateral e Arco das Ruínas como destino Dev1, seguida por Vila/Observatório/contrafortes Dev2 em profundidade. Nenhum checkpoint encerra o ciclo: o retorno CP-CINE-07 abre CP-CINE-08 imediatamente.

## CP 336 — Orçamento local validado

A auditoria runtime confirmou que a abertura usa 1 luz local activa (margem 15) e o handoff usa 4 luzes locais activas, das quais 2 têm sombra (margem 12), apesar de o inventário global regional conter luzes em sectores distantes. A configuração é compatível com o limite de 16 luzes simultâneas da GTX 1050 Ti e foi preservada. O **CP-CINE-07 permanece em execução imediata**: ao chegar a integração Dev2 R7–R9, repetir a tomada CP317 sem mudar posição, FOV ou escala e abrir CP-CINE-08 no mesmo ciclo.
