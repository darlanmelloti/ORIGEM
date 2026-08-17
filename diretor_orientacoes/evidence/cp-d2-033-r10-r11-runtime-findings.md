# CP-D2-033 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 10–11
- **STATUS_CODE**: PASSED_TECHNICAL / COST_LOCALIZED
- **TAREFA_EM_EXECUCAO_AGORA**: Validação discriminada da Caverna Orion (R10) e da Câmara do Orion Cube (R11).
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

A validação separada confirmou uma diferença estrutural importante. A Caverna R10 apresenta aproximadamente 31–32 FPS e 76–107 draw calls no harness, enquanto a execução R11 activa a construção completa do bloco de destino e regista aproximadamente 19–22 FPS e 320–347 draw calls. O parser/runtime Godot 4.7.1 passou nos dois casos; cada execução tem gameplay de 30 segundos e print 1600×900.

| Região | Gameplay | Print | Métricas observadas |
|---|---|---|---|
| R10 | `07af2bf986cdf2994ed377235658b1a3bbd53f96465fdffe53dc3a5ca06e8820` | `6b81ce67da1e8ce82794366b425028dff8fadd6487a8804baf1ea6ffce8a3fe3` | 31–32 FPS; 76–107 draw calls |
| R11 | `76306c8b076d5f80a8355221798487f65cba832e716031bc68674bea058a2324` | `e12135303a9a78eaedd3fca7d83bbc98c81e141245bf23f935f39c97599ddf4a` | 19–22 FPS; 320–347 draw calls |

A leitura operacional é que o custo alto não vem da Caverna; está concentrado na construção agregada de R11–R12, especialmente na Cúpula Final com 45 meshes. **Próxima acção imediata:** empacotar e sincronizar CP-D2-033 e iniciar um passe de construção condicional para evitar criar a Cúpula Final quando a validação é estritamente R11, sem alterar o percurso jogável completo quando R12 é alvo.
