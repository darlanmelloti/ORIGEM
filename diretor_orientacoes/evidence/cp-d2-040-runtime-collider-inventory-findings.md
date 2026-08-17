# CP-D2-040 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Inventário runtime dos colliders nomeados Cube → soleira → Hub.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O inventário foi movido para o fim da construção do harness, depois da criação dos volumes físicos. A execução Godot 4.7.1 confirmou runtime verdadeiro para os três nós: `ColisaoHandoffCubeR11`, `ColisaoHandoffSoleiraR12` e `ColisaoHandoffHubR12`, todos com `present=true`. O parser/headless passou, o gameplay tem exactamente 30 segundos e o print tem 1600×900. A captura completa mantém aproximadamente 18–22 FPS e 320–347 draw calls, sem alteração visual.

**Evidência:** gameplay `b98454014612eaec56d060f802a04de99ccc72e8dedef79ff571506bd35166bf`; print `0ceceb29e7e20cc02b35fef865dd01ce9641a3a51a7f890301b3f9ca4e8ae5f7`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-040 e avançar para o próximo passe integrado de física/wayfinding, usando os três colliders runtime como pontos de auditoria.
