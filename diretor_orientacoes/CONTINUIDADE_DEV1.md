# CONTINUIDADE_DEV1 — CP 310 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem qualquer módulo das Regiões 7–12.

## Base preservada

O CP 294 ocultou os sinais técnicos do prólogo por nome e por material emissivo. O CP 305 ajustou a materialidade do Rio da Estrada para uma leitura azul-petróleo discreta, sem luzes, sem painéis e sem aproximar marcos. A validação headless Godot 4.7.1 e a execução gráfica de 30 segundos em compatibilidade passaram.

A tomada histórica inclinada mantém uma massa de cobertura Casa Voss à esquerda com Estrada e Arco no plano direito. É uma base **parcial**, não uma aprovação final: a fachada e a ponte ainda não satisfazem a referência de 12 marcos.

## CP 310 — EM EXECUÇÃO IMEDIATA

**Objectivo:** preservar a leitura diurna e a fachada/ala conquistadas nos CPs 306–309 e recuperar a ponte lateral como marco físico de plano intermédio, mantendo rio, Estrada e Arco em planos separados. Não usar outdoors, painéis, luzes adicionais ou colisores que estreitem a rota.

| Critério | Verificação obrigatória |
| --- | --- |
| Geometria | A origem da Casa torna-se reconhecível sem criar moldura artificial. |
| Profundidade | Rio/ponte, Estrada e Arco mantêm escala e planos distintos. |
| Integridade | Godot 4.7.1 headless sem erros. |
| Jogabilidade | Captura estável em `opengl3` e 30 segundos de execução sem erro GDScript. |
| Reversibilidade | Reverter qualquer candidata sem ganho visual verificável. |

**Próxima acção já iniciada:** construir uma leitura arqueológica de encontro da ponte integrada na margem, sem aumentar a massa no primeiro plano da Casa, recapturar em `opengl3` e encaminhar o primeiro frame melhorado para a grelha CP-CINE-03 do Dev3.

> Nenhum checkpoint encerra o ciclo. Cada validação abre imediatamente o próximo passe dentro do escopo Dev1.
