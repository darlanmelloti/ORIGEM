# Ordem Contínua CP 255 — Espelho Cartográfico de 12 Marcos

**Em vigor imediatamente.** O objectivo único da equipa é tornar a vista de saída da Casa Voss uma leitura tridimensional, explorável e coerente dos 12 marcos do mapa oficial. Esta ordem não substitui a fronteira de ficheiros: cada frente actua apenas no seu escopo e publica evidência antes de avançar.

> Regra operacional: o commit é evidência, não pausa. Depois de cada validação, cada frente lê esta pasta, escolhe a próxima linha disponível do seu bloco e continua sem aguardar aprovação verbal.

## Dev1 — Regiões 1–6 e fundação física da vista

Dev1 preserva a base estável no commit `336f680`; os passes panorâmicos que ficaram abaixo do limiar de qualidade foram revertidos e não devem ser restaurados. A primeira linha de trabalho é criar a **varanda/soleira real da Casa Voss**, sem impedir a porta `[E]`, para enquadrar a estrada, a ponte, o Arco e a bacia. A segunda é aprofundar o relevo físico e a água das Ruínas Submersas através de terreno, rochas CC0 e superfícies hídricas reais, não por formas rectangulares. A terceira é organizar em camadas os marcos 2–6: ponte, Arco, floresta com clareiras, Acampamento e bacia.

Cada incremento exige validação headless, Novo Jogo, exploração de 30 segundos e captura 16:9 da soleira. Um marco só permanece quando é legível no enquadramento e não reduz a transitabilidade.

## Dev2 — Regiões 7–12 e silhuetas panorâmicas de profundidade

Dev2 mantém a propriedade exclusiva de `HighlandRegion.gd`, `OrionDestinationRegion.gd` e dos módulos futuros das Regiões 8–12. A prioridade não é adicionar mais elementos locais sem ligação; é fazer com que Vila Elevada, Observatório, Trilha, Caverna Orion, Câmara do Cubo e Hub Temporal tenham **silhuetas escalonadas e legíveis desde a Casa Voss**, obedecendo às coordenadas de `CartographicAnchors.gd`.

A sequência contínua é: integrar `CartographicAnchors.gd` nos dois módulos; reduzir qualquer pico de luz para no máximo 12 luzes simultâneas nas Regiões 7–12; montar a Vila em socalcos e o Observatório como cúpula; abrir a Trilha como linha de fuga; modelar a Caverna e a Câmara como uma serra com profundidade; fechar o Hub no canto inferior direito com monólitos reais. Cada subfase deve guardar captura 16:9, gameplay de 30 segundos e `STATUS_CHECKPOINT_CP-D2-...`.

## Dev3 — Direcção cinematográfica e prova da tomada mestre

Dev3 não altera terreno, colisores nem módulos regionais. Deve ampliar `RegionalCinematicDirector.gd` com **Take 0 — Revelação do Vale**, uma tomada de 4,5–6,0 segundos que nasce na soleira da Casa Voss, mantém a casa no limite esquerdo e descreve a rota visual ponte → Arco → bacia → Vila → Orion. Deve também preparar uma grelha de captura lado a lado, com a referência do mapa e a captura Godot, marcando quais dos 12 pontos são legíveis.

A tomada não deve resolver a falta de geometria por ocultação, FOV extremo ou ângulos que escondam a rota. Se menos de nove marcos forem legíveis, Dev3 publica diagnóstico e a próxima correção espacial proposta, sem editar o trabalho dos outros desenvolvedores.

## Dev4 / Diretor Geral — coordenação, fronteiras e mecânicas transversais

Dev4 mantém a matriz `MATRIZ_ESPELHO_MAPA_12_MARCOS_CP255.md`, actualiza a lista de aceitação e publica os briefings de passagem Dev1→Dev2. Deve criar a lista de mecânicas transversais que reforçam a leitura do mapa sem duplicar regiões: descoberta de marco, actualização do destino no mapa `[M]`, registo de posição de Elias e sinalização discreta de rotas.

Dev4 audita cada status de checkpoint, resolve somente conflitos de escopo e confirma que a integração futura preservará a chave `[E]` da porta, colisores, salto, stamina e o orçamento GTX 1050 Ti. Não deve bloquear nenhuma frente à espera de reunião.

## Quadro de entregas em cadeia

| Ordem | Frente | Entrega seguinte | Dependência | Prova obrigatória |
|---:|---|---|---|---|
| 1 | Dev1 | Soleira física + enquadramento limpo dos marcos 1–6 | Nenhuma | Novo Jogo + 30 s + captura 16:9 |
| 2 | Dev2 | Silhuetas 7–12 ancoradas e orçamento de luz | CartographicAnchors | QA regional + captura 16:9 |
| 3 | Dev3 | Take 0 e grelha de legibilidade 1–12 | Capturas Dev1/Dev2 | Clipe e comparação lado a lado |
| 4 | Dev4 | Matriz actualizada e critérios de integração | Status das três frentes | Auditoria escrita sem bloqueio |
| 5 | Todos | Próxima lacuna de leitura cartográfica | Resultado anterior | Novo checkpoint e avanço imediato |

## Proibição explícita

Não usar montanhas, florestas, água, ruínas, Vila, Orion ou Hub como outdoors, painéis, paredes planas ou caixas alongadas. Cada elemento precisa de profundidade, escala, aterramento e continuidade espacial com o próximo marco.
