# CP-D2-036 — Estado actual do ciclo activo

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: Regiões 11–12
- **STATUS_CODE**: PASSED
- **TAREFA_EM_EXECUCAO_AGORA**: Auditoria dos colliders e marcadores nomeados do handoff Cube → soleira → Hub.
- **ESCOPO_BLOQUEADO**: Regiões 1–6 permanecem intocadas.

O percurso completo foi executado com construção integral e passou parser/runtime Godot 4.7.1, gameplay de 30 segundos e print 1600×900. A auditoria de código confirmou os marcadores `HandoffCubeR11`, `HandoffSoleiraR12` e `HandoffHubR12`, o corpo `CollidersAproximacaoHubR12` e a cadeia `MarcadorRotaFisicaR12_*`. Estes nós são físicos/nomeados e não acrescentam elementos visuais intrusivos. O inventário integral permanece em `129` meshes, `40` OmniLights e `15` StaticBody3D; as métricas da vista completa ficaram aproximadamente em 18–22 FPS e 320–347 draw calls. A inspecção visual do print 1600×900 confirma que os marcadores físicos não são renderizados, não há texto ou gizmos intrusivos, e a soleira mantém contraste suficiente entre a aproximação e o volume do Hub.

**Evidência:** gameplay `56d06aa3f2af27de2699260a3708ec59ca17f3ffd9c27dcc9ea3d59d4ade68db`; print `9528340488827a8ec2ec62f24d9e78acfcd7d391686ecf64baa35b6165cd65ff`.

**Próxima acção imediata:** empacotar e sincronizar CP-D2-036 e iniciar o próximo passe de validação de contacto físico/wayfinding na soleira R12, sem alterar geometria nem Regiões 1–6.
