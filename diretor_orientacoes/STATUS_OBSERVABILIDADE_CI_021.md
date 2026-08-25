# STATUS — OBSERVABILIDADE DO CICLO CONTÍNUO 021

**Workflow:** `ORIGEM Regional Continuous Gate`  
**Data:** 25 de agosto de 2026  
**Coordenação:** Dev1

## Evidências automáticas em falha

Cada job regional agora preserva os ficheiros `origem_<região>_*.log` como artefacto GitHub se parser, contrato, estabilidade física ou rota QA falhar. Os artefactos são mantidos por 14 dias e recebem o nome `origem-<região>-qa-logs`.

O primeiro teste após a alteração concluiu com sucesso. Os jobs de R2 a R6 ignoraram corretamente a etapa de upload porque não houve falha; em qualquer falha futura, a mesma etapa recolherá os logs já gerados pela porta regional.

## Resultado operacional

O ciclo passa a fornecer três camadas contínuas: bloqueio no merge, execução técnica automática e evidência de depuração em caso de regressão. Assim, a equipa pode corrigir diretamente a partir de parser, contrato, grounding ou rota afetada sem interromper as outras regiões.
