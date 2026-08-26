# ORIGEM — Avaliação de Dívida Visual R6 013

**Tarefa:** `DEV6-R6-VISUAL-DEBT-ASSESSMENT-013`  
**Estado:** AUDITORIA CONCLUÍDA; sem alteração de produção.  
**Base de evidência:** `reports/r6/route_regression_pipeline_011/`.

## Leitura runtime observada

As capturas estabilizadas das três rotas confirmam que a R6 carrega e conserva água, relevo, estela, pilares, marcos e sequência física de lajes. Contudo, as vistas de `forest_to_ruins`, `majestic_to_lake` e `ruins_arrival` expõem uma leitura ainda próxima de protótipo: terreno muito amplo, poucos agrupamentos visuais, lajes excessivamente isoladas e alguns elementos de apoio com baixa integração na composição.

| Área observada | Sinal visual | Impacto | Restrição de correção |
|---|---|---|---|
| Aproximação `forest_to_ruins` | Lajes físicas legíveis, mas demasiado destacadas no terreno aberto | A direção é clara, porém pouco natural | Não mover lajes, rota ou colisores; trabalhar só em elementos R6 existentes laterais |
| Conector `majestic_to_lake` | Vazio visual entre marcos e declives | Reduz progressão ambiental para a bacia | Sem estreitar corredor, criar luz ou antecipar R7 |
| Chegada `ruins_arrival` | Estela e vestígios existem, mas sem massa composicional suficiente no plano médio | A bacia perde peso arqueológico à distância | Reutilizar apenas vestígios ou rochas R6 existentes; sem água falsa, shader, painel ou física |
| Plano global | Marcadores QA visíveis em algumas capturas | Poluem a leitura de arte final, embora sirvam à validação | Distinguir marcador QA de conteúdo de produção; não ocultar telemetria por alteração de rota |

## Limites invioláveis

| Garantia | Estado |
|---|---|
| Âncora R6 e handoff R6→R7 | Intactos |
| Rotas `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` | Aprovadas pela baseline e CI comum |
| Água | Sem painel, emissão excessiva ou shader adicional |
| Luz | Exatamente quatro luzes R6; nenhuma adicional |
| Física | Sem `StaticBody3D`, `CollisionShape3D`, alteração de lajes ou bloqueio de corredor |
| Produção nesta tarefa | Sem alteração |

## Incremento recomendado

A próxima entrega deve ser **`DEV6-R6-MIDGROUND-ARCHAEOLOGY-COMPOSITION-014`**. O escopo deve limitar-se a escala, orientação ou agrupamento estático de três a cinco vestígios arqueológicos R6 já existentes no plano médio da chegada, mantendo posições-base, água, luzes, handoff e rota. A entrega deverá incluir prova específica de que nenhum nó, colisor, luz, material emissivo ou elemento R7 foi criado, além de parser, orçamento R6, handoff e as três rotas.

> Esta recomendação corrige leitura composicional real sem camuflar a dívida visual através de pós-processamento, iluminação adicional ou atalhos de água.
