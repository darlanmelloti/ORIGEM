# CP-D2-029 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Região 12
- **STATUS_CODE**: PASSED_VISUAL_TECHNICAL / PERFORMANCE_UNCHANGED
- **TAREFA_EM_EXECUCAO_AGORA**: Redução do número de luzes de rim no anel temporal.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O anel temporal passou de oito luzes de rim para quatro, distribuídas nos índices pares. O parser/runtime Godot 4.7.1 passou, o gameplay tem 30 segundos e o print tem 1600×900. A leitura violeta do Hub e a silhueta dos monólitos permanecem preservadas. O harness, porém, continua aproximadamente em 18–22 FPS e 320–347 draw calls, demonstrando que a redução de luzes não é o custo dominante nesta configuração.

**Evidência:** gameplay `cd4d022b8580cf55050bfaa63c2c11c9f88896db22ac79ffef34f53109ddbe00`; print `61679d4d4fb05b1661308a255087a81d145cc7aef73589b0b0d56c7c4098f78a`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-029 e iniciar a instrumentação de contagem de malhas por região no harness, sem reduzir ainda a geometria orgânica validada.
