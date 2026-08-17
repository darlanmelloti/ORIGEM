# CONTINUIDADE DEV1 — ACTIVA

**Fronteira obrigatória:** Regiões 1–6 e Takes 1–11. Não alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd` nem qualquer módulo das Regiões 7–12.

Os CP 281–288 foram validados com compilação Godot headless e execuções/capturas de abertura. A frente recuperada encontra-se na branch `feature/dev1-gameplay-core`, restaurada no commit remoto `e8a05b5` após a reinicialização do ambiente. O binário Godot 4.7.1 foi reinstalado para manter a validação local.

## CP 288 concluído — limpeza de sinais técnicos

`VossHouse.gd` passou a ocultar, apenas durante o prólogo, os marcadores Chronos e emissores remotos que contaminavam a leitura física do vale. A ocultação é repetida nos primeiros frames de construção regional e os nós são restaurados no fim normal da abertura. A validação headless passou e a cena principal foi executada por 34 segundos em ambiente gráfico virtual, com captura guardada em `qa_evidence_voss_vista/cp288_warm_main_scene.png`.

## CP 289 — EM EXECUÇÃO IMEDIATA

**Objetivo:** tornar a Casa Voss uma moldura arquitectónica real na margem esquerda da tomada sem regressar a uma galeria rectangular artificial, sem reduzir distâncias e sem esconder rio, ponte, Estrada ou Arco.

| Regra | Critério de aceitação |
| --- | --- |
| Geometria | Casa, soleira, cobertura, parede ou pilar real da Casa Voss entra no limite esquerdo; nenhum painel ou fundo plano. |
| Profundidade | Rio/ponte, Estrada e Arco continuam em planos separados; montanhas mantêm escala distante. |
| Integridade | Godot 4.7.1 headless sem erros. |
| Jogabilidade | Cena principal em execução por pelo menos 30 segundos e captura gráfica válida; sem colisores novos a bloquear a saída. |
| Reversibilidade | Desfazer qualquer ajuste se a captura reduzir a leitura do vale. |

**Próxima acção já iniciada:** medir uma posição de câmara física na soleira ou na borda compacta do terraço que deixe a fachada visível à esquerda, conservando a câmara actual como fallback.

> Nenhum checkpoint é ponto de paragem. Depois de cada validação, publicar evidências, actualizar este ficheiro e abrir imediatamente o próximo passe dentro do escopo Dev1.
