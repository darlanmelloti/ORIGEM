# ORIGEM — Alinhamento Operativo do Mapa e da História

**Branch:** `feature/dev2-mountain-canyon`  
**Escopo vigente:** Regiões 7–12; Takes 12–22  
**Base consultada:** `pasted_content_3.txt`, `pasted_content_4.txt` e `ORIGEM—Sequênciahitoriaparadesenvolvimentodecenáriosemapasdojogo.md`

## Diretiva vigente

O manual operativo global anexado pela direção prevalece sobre a formulação anterior de Takes 7–10. O Novo Desenvolvedor deve construir somente as Regiões 7–12, iniciando sobre a base consolidada das Regiões 1–6. Não serão modificadas a Casa Voss, a Estrada do Rio, o Arco, a Floresta, o Acampamento Majestic ou as Ruínas Submersas.

A sequência histórica exige continuidade espacial: a vila deve ser alcançada pela subida desde o vale; o observatório deve apontar para a face escondida da montanha; a trilha deve conduzir à entrada da caverna sob raízes e queda de água; a galeria deve abrir para a Câmara do Orion Cube; e o Hub Temporal deve funcionar como espaço exterior de transição depois da revelação.

## Mapa oficial aplicado ao código

| Região | Marco obrigatório | Relação física e narrativa | Estado de implementação observado |
|---|---|---|---|
| 7 | Vila Elevada | Terraços de pedra, arquitetura antiga e mural de eras sobrepostas; chegada pela estrada ascendente | `HighlandRegion.gd` já instancia o marco `VilaElevada`; requer validação visual e substituição de qualquer leitura greybox por kit orgânico/GLB validado |
| 8 | Observatório | Torre superior com mecanismo quebrado que projeta a rota da caverna | `HighlandRegion.gd` já instancia `ObservatorioDaOrion`; mecanismo de projeção e continuidade de rota precisam ser validados/expandidos |
| 9 | Trilha da Montanha | Encosta íngreme, ponte natural, raízes, fissuras luminosas e vista vertical da vila | `HighlandRegion.gd` já instancia `TrilhaDaMontanhaOrion`; precisa receber fissuras e validação de câmara conforme a cinematografia |
| 10 | Caverna do Orion | Entrada escondida por raízes e queda de água; transição gradual do vento para ressonância subterrânea | `OrionDestinationRegion.gd` já instancia `CavernaDoOrion`; deve ser tratada como entrada da Região 10, não como reabertura do Take 5 |
| 11 | Câmara do Orion Cube | Galeria das três eras, sala circular com anéis suspensos e revelação do artefacto | `OrionDestinationRegion.gd` já possui marcadores `CamaraDoOrionCube` e `CuboOrion`; a construção deve avançar organicamente a partir da entrada da Região 10 |
| 12 | Hub Temporal | Círculo de menires exteriores, núcleo e portais de transição temporal | `OrionDestinationRegion.gd` já instancia `HubTemporal`; requer ligação narrativa posterior à revelação, sem deslocar a entrada da caverna |

## Ordem de produção autorizada

1. Validar e consolidar a continuidade Vila Elevada → Observatório → Trilha da Montanha.
2. Implementar a transição Trilha → Entrada da Caverna do Orion, incluindo raízes, queda de água e luz azul restrita às fissuras.
3. Expandir a galeria subterrânea e a Câmara do Orion Cube com três camadas históricas, anéis suspensos e órbita curta de validação.
4. Consolidar o Hub Temporal exterior como espaço de transição, preservando a orientação da montanha e a leitura do percurso de retorno.
5. Em cada subtarefa, executar F5, gerar print 1600×900, gameplay de 30 segundos, comparação visual e log de fecho antes do commit/push.

## Regras visuais e técnicas

Nenhum cenário novo deve ser composto por caixas de greybox. Estruturas permanentes devem utilizar o `OrganicRuinKit.gd` ou modelos `.glb` CC0 validados. O azul temporal deve ser localizado e motivado pela espada, pelas fissuras ou pelo Cubo; não deve transformar a montanha em um painel luminoso. A escala deve permanecer alpina, com leitura vertical real e continuidade física entre os marcos.

## Nota de auditoria

A implementação anterior de Take 8 foi iniciada como eco temporal após o santuário do Take 7. Essa linha só pode permanecer se for reposicionada como validação interna da progressão das Regiões 10–12 e não como avanço independente fora do mapa oficial. A próxima captura deve demonstrar o marco regional correspondente, não apenas uma órbita abstrata.

**Estado:** alinhamento documental concluído; próxima ação técnica: corrigir o plano de validação e executar o primeiro ciclo da Região 7/8 ou, caso a base já esteja visualmente aprovada, avançar pela ligação para a Região 9.

## Critérios narrativos adicionais incorporados

A partir da entrada na Casa Voss, a câmera de exploração deve permanecer contínua e evitar teletransportes. As Regiões 7–10 devem funcionar como exploração livre e caminho navegável; a Caverna deve usar FPS com luzes reativas; e a Câmara do Orion Cube pode alternar brevemente para inspeção, devolvendo sempre o controlo ao jogador.

A Câmara do Cube deve mostrar uma câmara vertical, o artefacto suspenso sobre pedra e metal, linhas de energia azul-violeta e distorção atmosférica localizada. A espada deve iluminar-se integralmente e o Cube deve projetar fragmentos do vale, da Casa Voss, do arco, da floresta, da vila e de versões temporais da montanha. A revelação termina em mistério; a Cena 22 converte a revelação em gameplay, com três destinos iniciais — passado remoto, época de Elias e futuro em ruínas — e o objetivo: **“Descobrir o que o avô escondeu na montanha.”**

O critério de aceitação é espacial e funcional: o jogador deve reconhecer todos os marcos como partes do mesmo mundo e conseguir atravessar a cadeia sem bloqueios. O critério narrativo é que a sequência comunique que o avô encontrou a pedra na caverna, que a espada é a chave de comunicação e que o Orion Cube permite viajar entre eras, mantendo Majestic/MJ-12 como ameaça ativa.

**Fonte histórica interna:** `ORIGEM—Sequênciahitoriaparadesenvolvimentodecenáriosemapasdojogo.md`, cenas 21–22 e critérios de aceitação.
