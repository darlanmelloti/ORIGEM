# ORIGEM — CP-D2-CONVERGENCE-076

### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

| Campo | Estado |
|---|---|
| Região actual | R7–R9 — Vila Elevada, Observatório e Trilha da Montanha |
| STATUS_CODE | `REJECTED_VISUAL` |
| Validação técnica | Godot 4.7.1; parser/headless limpo; gameplay 30.000 s; print 1600×900 |
| Resultado CP074 | A vista elevada revelou a montanha e a aldeia, mas deixou os sujeitos pequenos e no canto |
| Resultado CP075/076 | A aproximação tornou a estrada e as casas visíveis, mas a composição continua demasiado escura, esparsa e com casas semelhantes a marcadores |
| Próxima acção imediata | CP-D2-CONVERGENCE-077 — composição dedicada de handoff R7→R9: câmara principal frontal/lateral, contraste de leitura nos materiais R7, escala vertical da Vila e Observatório legível ao fundo |
| Luzes | Sem expansão; manter teto máximo Dev2 de 16 |
| Fronteira | R1–R6 read-only |

O runtime passou tecnicamente e os artefactos de 30 segundos/1600×900 foram produzidos. A evidência visual não é aceite como `PASSED`: a cadeia de percurso existe, mas o sujeito urbano R7 não domina a imagem e o conjunto ainda não comunica uma Vila Elevada cinematográfica. A rejeição abre CP077 imediatamente; não é estado de espera.

O CP073/074/075/076 alterou apenas o harness visual `levels/Take8ValidationScene.gd` para corrigir o salto de câmara e impedir ocultação da trilha. O próximo passe deve continuar a partir desta base e não tocar nas Regiões 1–6.
