# Estado do Checkpoint 282 — Profundidade Física do Horizonte

O **CP 282** reforça a leitura de profundidade a partir da Casa Voss sem reduzir distâncias do mapa. Foram introduzidos maciços rochosos CC0 posicionados entre os planos remotos do corredor Dev1, dois vestígios de ruína no horizonte, uma depressão topográfica contínua no ombro do vale e um ajuste de material do rio para eliminar a reflexão clara que o fazia parecer uma faixa plana.

| Verificação | Resultado |
|---|---|
| Godot headless | Aprovado, sem erros de parser, script ou recursos em falta |
| Captura de abertura | Actualizada em `qa_evidence_voss_vista/cp274_opening_macro/revelacao_casa_estrada_arco.png` |
| Gameplay real | Prova segmentada de 30 segundos aprovada sem bloqueio da rota |
| Luzes dinâmicas | Não foram adicionadas luzes ao horizonte ou ao rio |
| Limite operacional | Alterações limitadas a `VossHouse.gd`, `TerrainPatch.gd` e `RiverRoadJourney.gd`, dentro das Regiões 1–6 |

A geometria criada mantém-se tridimensional e ancorada no terreno. A abertura topográfica conserva ruído, declive e colisão: é um colo natural de leitura, não um plano removido nem uma simulação de fundo. O ajuste da água reduz a leitura branca do curso do rio e devolve contraste às margens e aos afloramentos.

> O próximo incremento já está iniciado: CP 283 deve concentrar-se nos planos intermédios da revelação, reforçando a ligação visual entre ponte, margens, Estrada e Arco antes de gerar a nova distribuição de teste.

**Estado:** `VALIDADO TECNICAMENTE; CP 283 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.
