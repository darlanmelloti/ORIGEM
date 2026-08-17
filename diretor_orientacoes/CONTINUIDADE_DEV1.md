# CONTINUIDADE_DEV1 — CP 322 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem qualquer módulo das Regiões 7–12.

## Base preservada

O CP 294 ocultou os sinais técnicos do prólogo por nome e por material emissivo. O CP 305 ajustou a materialidade do Rio da Estrada para uma leitura azul-petróleo discreta, sem luzes, sem painéis e sem aproximar marcos. A validação headless Godot 4.7.1 e a execução gráfica de 30 segundos em compatibilidade passaram.

A tomada histórica inclinada mantém uma massa de cobertura Casa Voss à esquerda com Estrada e Arco no plano direito. É uma base **parcial**, não uma aprovação final: a fachada e a ponte ainda não satisfazem a referência de 12 marcos.

## CP 322 — EM EXECUÇÃO IMEDIATA

**Objectivo:** preservar a tomada recuada CP 317 e a prioridade de câmara CP 321; classificar os pequenos pontos residuais da bacia antes de os remover ou integrar como geometria real. Não usar outdoors, painéis, luzes adicionais ou colisores que estreitem a rota.

| Critério | Verificação obrigatória |
| --- | --- |
| Geometria | A origem da Casa torna-se reconhecível sem criar moldura artificial. |
| Profundidade | Rio/ponte, Estrada e Arco mantêm escala e planos distintos. |
| Integridade | Godot 4.7.1 headless sem erros. |
| Jogabilidade | Captura estável em `opengl3` e 30 segundos de execução sem erro GDScript. |
| Reversibilidade | Reverter qualquer candidata sem ganho visual verificável. |

**Próxima acção já iniciada:** inventariar em runtime os elementos do cone da tomada CP 317 e isolar apenas os que se provem técnicos, antes de alterar materiais ou geometria.

> Nenhum checkpoint encerra o ciclo. Cada validação abre imediatamente o próximo passe dentro do escopo Dev1.
