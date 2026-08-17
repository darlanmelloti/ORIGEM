# CP-D2-064 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–12
- **STATUS_CODE**: REJECTED_VISUAL
- **TAREFA_EM_EXECUCAO_AGORA**: Continuar o passe de desempenho da Cúpula Final, preservando a silhueta monumental com decoração remota reduzida.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.
- **DEADLINE_PROXIMO_PUSH**: Próximo ciclo imediato após a captura e sincronização deste passe.

O passe CP-D2-064 reduziu o anel decorativo da Cúpula de dez para oito pilares. O inventário runtime caiu de `meshes=129` para `meshes=121`, de `omni_lights=35` para `omni_lights=34`, e `CupulaFinal` passou de 45 para 37 meshes e de 5 para 4 OmniLights. Os três handoffs Cube/Soleira/Hub, as posições cartográficas, o parser Godot 4.7.1, o guard, os contratos, gameplay de 30 segundos e print 1600×900 continuam válidos.

A melhoria estrutural é mensurável, mas o critério de desempenho ainda não passa: o percurso registou 17–19 FPS no trecho final, com draw calls entre 320–340.

**Evidência:** gameplay `766c0769fe31c4bca8a9400057c5bdb6c06b9dde8e0fdaf7fb0c51dac634018f`; print `5ec40a81e961614cfdb68228b79e955d6250c082dfe7336eb0f04f5d09683f3f`.

**NEXT_ACTION_IMMEDIATE:** reduzir apenas os elementos de iluminação e geometria decorativa mais distantes do gateway, sem remover gateway, núcleo, soleira, âncora ou colliders; repetir a validação completa e só marcar PASSED se o trecho final recuperar pelo menos 20 FPS.
