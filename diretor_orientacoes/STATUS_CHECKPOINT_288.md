# STATUS — Checkpoint 288: limpeza técnica da tomada Casa Voss

**Frente:** Dev1 — Regiões 1–6 / Takes 1–11  
**Estado:** validado tecnicamente; continuidade CP 289 iniciada.  
**Escopo preservado:** não foram alterados módulos, geometria ou activos das Regiões 7–12.

## Alteração entregue

A activação do prólogo da Casa Voss passou a executar quatro verificações curtas de ocultação de sinais técnicos, aos 0,12 s, 0,42 s, 0,90 s e 1,65 s. O passe tardio agora inclui os emissores Chronos remotos, as balizas arqueológicas de ruína, a luz do observatório e o brilho da caverna. Estes nós são ocultados somente enquanto a câmara do prólogo está activa e são restaurados no fim da sequência normal de abertura.

A intervenção não cria painéis, não reduz a distância cartográfica, não adiciona luzes e não altera a geometria jogável. A experiência visual passa a depender da topografia, do rio, das ruínas e das estruturas tridimensionais já existentes, em vez de pontos ciano de sinalização técnica.

## Validação realizada

| Verificação | Resultado | Evidência |
| --- | --- | --- |
| Compilação Godot 4.7.1 headless | Aprovada | `qa_evidence_voss_vista/cp288_final_headless.log` |
| Cena principal em execução gráfica | Aprovada | 34 s de execução virtual após aquecimento do motor |
| Captura da abertura | Aprovada | `qa_evidence_voss_vista/cp288_warm_main_scene.png` |
| Marcadores técnicos ciano | Reduzidos na captura de abertura | comparação com a captura anterior CP 288 |
| Escopo Dev1 | Aprovado | apenas `levels/VossHouse.gd` alterado |

> Limitação de execução restaurada: depois da reinicialização do ambiente foi necessário recuperar a branch `feature/dev1-gameplay-core` e reinstalar o binário Godot 4.7.1. A cena principal foi executada por 34 s; a automação gráfica do menu ficou limitada pelo foco de janela do Xvfb, razão pela qual a prova foi feita directamente em `scenes/main.tscn`.

## Próximo passo já iniciado — CP 289

Construir uma leitura física mais clara da **Casa Voss na margem esquerda** sem voltar a introduzir uma galeria artificial: a próxima iteração deve analisar uma posição de câmara fisicamente acessível na soleira/terraço e uma estrutura arquitectónica orgânica existente da casa, mantendo ponte, Estrada e Arco em profundidade. A alteração só será conservada se a captura melhorar materialmente a composição e a execução de 30 segundos continuar sem bloqueio.

**Continuidade:** activa; não aguardar nova autorização.
