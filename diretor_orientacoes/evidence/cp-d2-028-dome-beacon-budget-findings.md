# CP-D2-028 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED_VISUAL_TECHNICAL / PERFORMANCE_FOLLOWUP
- **TAREFA_EM_EXECUCAO_AGORA**: Redução controlada das balizas de coroa da Cúpula Final.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

As balizas `LuzCoroaCupula_*` foram reduzidas de energia `1.15` para `0.95` e alcance `8.0` para `6.5`. O parser/runtime Godot 4.7.1 passou, o gameplay tem 30 segundos e a captura tem 1600×900. As métricas do harness ficaram aproximadamente em 19–23 FPS e 320–347 draw calls, indicando que o ajuste de luz preserva a silhueta e o wayfinding, mas não resolve isoladamente o custo dominante de malhas repetidas.

**Evidência:** gameplay `29c1f79b32dd19ea47f4bbb9b0640bbddd7b5d9690fc27db87ef8ccf6771fbf3`; print `38ec7afac40985a3dd7ac755a49b04a86dc6a61c9839e645374157a03b3091f0`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-028 e avançar para uma análise de instanciamento/custo de malhas repetidas da Cúpula, mantendo a construção orgânica e o escopo 7–12.
