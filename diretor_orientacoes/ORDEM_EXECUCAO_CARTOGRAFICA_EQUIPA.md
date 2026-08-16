# ORIGEM — Ordem de Execução Cartográfica da Equipa

**Vigência:** imediata e contínua.  
**Documento-base:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Ordem comum a todos os desenvolvedores

O mapa oficial de doze marcos é agora a referência espacial vinculativa. Cada implementação deve responder a uma pergunta simples: **que relação do mapa esta alteração torna mais legível no mundo 3D?**

Antes de abrir uma subtarefa, cada desenvolvedor deve declarar o marco, a relação espacial e o corredor físico que será protegido. Depois de cada subtarefa, deve validar no Godot, realizar pelo menos 30 segundos de gameplay/captura e fazer push do checkpoint. Não existem pausas após commits.

## Dev1 — Próximo ciclo: CP 218, Leitura Cartográfica do Sudoeste

**Escopo permitido:** apenas Regiões 1–6, Takes 1–11 e os módulos já atribuídos à branch `feature/dev1-gameplay-core`.

### Objectivo

Fazer a abertura Casa Voss → Estrada do Rio → Arco das Ruínas funcionar como o canto sudoeste do mapa: a Casa é o ponto de origem, a estrada é a linha de orientação e o arco é o primeiro limiar vertical do vale.

### Tarefas em sequência

| Ordem | Implementação | Critério de aceitação |
|---:|---|---|
| 1 | Criar/ajustar três pontos de leitura à distância no corredor de saída: Casa atrás, rio lateral e Arco à frente. | Ao olhar para norte depois de sair, o jogador reconhece o eixo de viagem sem HUD. |
| 2 | Reforçar a curva do rio e as margens próximas do Arco com rocha, vegetação húmida e diferenças de cota, sem estreitar o percurso. | O rio parece um elemento geográfico contínuo, não uma faixa decorativa. |
| 3 | Rever a vista do Arco a partir da estrada e a vista da floresta depois do Arco. | O arco cria uma passagem, e não um objecto isolado. |
| 4 | Validar porta `[E]`, ponte, estrada, arco e os primeiros metros da floresta em 30 segundos. | Sem bloqueio de colisor, queda ou sobreposição no trilho principal. |

**Proibido:** alterar `HighlandRegion.gd`, `OrionDestinationRegion.gd`, takes 12–22 ou a geometria interna dos marcos 7–12.

## Dev2 — Próximo ciclo: CP-D2-003, Leitura Cartográfica do Nordeste

**Escopo permitido:** apenas Regiões 7–12, Takes 12–22 e a branch `feature/dev2-mountain-canyon`.

### Objectivo

Transformar o conjunto Vila Elevada → Observatório → Trilha da Montanha → Orion numa leitura topográfica idêntica à metade nordeste do mapa: vila em terraços, observatório acima dela e maciço Orion no horizonte de ascensão.

### Tarefas em sequência

| Ordem | Implementação | Critério de aceitação |
|---:|---|---|
| 1 | Preservar a entrada em `Vector3(140, y, 352)` e testar a ligação do portão do lago à vila. | Não há teleporte, parede invisível ou colisor a bloquear a chegada. |
| 2 | Dar à Vila Elevada uma silhueta estratificada: base de acesso, terraços, telhados e muro de bordo. | A vila é reconhecível de longe como marco 7, não como grupo plano de casas. |
| 3 | Reforçar o Observatório em `(194,404)` como cume visual com domo e baliza subtil, não uma luz excessiva. | O jogador vê o marco 8 da vila e da margem do lago. |
| 4 | Fazer a trilha 9 mostrar alternadamente vale, cascatas/penhascos e Orion, com curvas e rocha real. | A rota sente-se como ascensão de montanha, não corredor recto. |
| 5 | Manter caverna/câmara em `(-116,548)` e `(-116,562)` como culminação do maciço. | Entrada física com profundidade e Câmara distinta da boca da caverna. |

**Proibido:** alterar Casa Voss, Estrada do Rio, Arco, Floresta, Acampamento ou Ruínas Submersas. A única interface autorizada é a chegada ao handoff do portão.

## Dev03 — Direcção Cinematográfica

O Dev03 não altera a geografia. Deve auditar os takes para que cada enquadramento revele relações do mapa: origem sudoeste, linha do rio, massa de floresta, corpo de água central, vila elevada, observatório e maciço Orion. Se uma câmara esconde esses marcos, a correcção é de enquadramento, FOV, posição ou luz — nunca de geometria fora do seu escopo.

## Diretor Geral — Auditoria

O Diretor Geral verifica a cada ciclo se o movimento entre marcos respeita a topologia do mapa. Deve rejeitar alterações que gerem “outdoors”, paredes de floresta, teleporte espacial, marcos duplicados ou escalas que invertam Casa/lago/vila/montanha.
