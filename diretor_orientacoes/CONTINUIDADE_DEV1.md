# CONTINUIDADE_DEV1 — CP 296 EM EXECUÇÃO

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem qualquer módulo das Regiões 7–12.

## Base aceite

O miradouro compacto de Casa Voss mantém a câmara física de abertura. O CP 294 passou a ocultar sinais técnicos do prólogo por nome e por material emissivo, com novas passagens tardias; a captura em `opengl3` é agora o método obrigatório de comparação estável no sandbox recuperado.

## CP 296 — EM EXECUÇÃO IMEDIATA

**Objectivo:** reforçar por geometria orgânica a leitura de primeiro plano Casa–soleira–ponte, sem deslocar a lente para dentro da casa, sem criar painéis e sem reduzir a profundidade cartográfica do vale.

| Regra | Critério de aceitação |
| --- | --- |
| Geometria | A origem física do percurso torna-se reconhecível sem qualquer fundo plano ou galeria artificial. |
| Profundidade | Rio/ponte, Estrada e Arco mantêm-se em planos separados; o vale conserva escala distante. |
| Integridade | Godot 4.7.1 headless sem erros. |
| Jogabilidade | Execução gráfica mínima de 30 segundos e captura válida, sem colisores novos a bloquear a saída. |
| Reversibilidade | Reverter qualquer alteração que reduza a leitura do vale. |

**Próxima acção já iniciada:** localizar a linha de geometria de soleira/ponte que pode ganhar silhueta de pedra real à esquerda sem bloquear a rota, depois comparar em `opengl3` e encaminhar o frame aceite à grelha CP-CINE-03 do Dev3.

> Nenhum checkpoint é ponto de paragem. Depois de cada validação, publicar evidências, actualizar este ficheiro e abrir imediatamente o próximo passe dentro do escopo Dev1.
