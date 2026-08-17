# CONTINUIDADE_DEV1 — CP 314 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem qualquer módulo das Regiões 7–12.

## Base preservada

O CP 294 ocultou os sinais técnicos do prólogo por nome e por material emissivo. O CP 305 ajustou a materialidade do Rio da Estrada para uma leitura azul-petróleo discreta, sem luzes, sem painéis e sem aproximar marcos. A validação headless Godot 4.7.1 e a execução gráfica de 30 segundos em compatibilidade passaram.

A tomada histórica inclinada mantém uma massa de cobertura Casa Voss à esquerda com Estrada e Arco no plano direito. É uma base **parcial**, não uma aprovação final: a fachada e a ponte ainda não satisfazem a referência de 12 marcos.

## CP 314 — EM EXECUÇÃO IMEDIATA

**Objectivo:** preservar a captura cinematográfica limpa e a leitura diurna/fachada dos CPs 306–313, convertendo a abertura em evidência comparável para o Dev3 antes do próximo ganho macro. Não usar outdoors, painéis, luzes adicionais ou colisores que estreitem a rota.

| Critério | Verificação obrigatória |
| --- | --- |
| Geometria | A origem da Casa torna-se reconhecível sem criar moldura artificial. |
| Profundidade | Rio/ponte, Estrada e Arco mantêm escala e planos distintos. |
| Integridade | Godot 4.7.1 headless sem erros. |
| Jogabilidade | Captura estável em `opengl3` e 30 segundos de execução sem erro GDScript. |
| Reversibilidade | Reverter qualquer candidata sem ganho visual verificável. |

**Próxima acção já iniciada:** publicar a captura limpa no pacote de evidência Dev3 e isolar, pela matriz de 12 marcos, a primeira intervenção macro com ganho visual verificável antes de recapturar em `opengl3`.

> Nenhum checkpoint encerra o ciclo. Cada validação abre imediatamente o próximo passe dentro do escopo Dev1.
