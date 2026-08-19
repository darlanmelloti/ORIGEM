# CP-CARTO-090 — Material de Solo e Margens R1→R3

## Estado

**PASS técnico; REJECTED_VISUAL.** O passe removeu a geometria plana usada nas manchas de margem, tornou os agrupamentos baixos tridimensionais e ancorados à altura real do terreno, e trocou o albedo de solo excessivamente granular pelo conjunto PBR `forest_ground_06`.

O trajecto **Casa Voss → Estrada do Rio → Arco das Ruínas** foi executado durante 36 segundos, sem erros de parser ou de execução e sem alteração da rota, dos marcos cartográficos ou do orçamento de luzes. A composição ainda não atinge o limiar visual de 85%: a forma do vale, a densidade vegetal e a leitura do Arco continuam demasiado simplificadas.

## Alterações verificadas

| Área | Alteração | Resultado |
|---|---|---|
| Material do terreno | Conjunto PBR `forest_ground_06` com mistura macro e mipmap | Menos ruído escuro e melhor separação de planos; insuficiente como passe visual final |
| Margem do rio | Planos de cor substituídos por volumes baixos 3D aterrados | PASS de conformidade; impacto visual focal baixo |
| Taludes | Quatro afloramentos CC0 inclinados fora da rota | PASS técnico; ganho visual não mensurável na tomada |
| Marcadores QA | Tentativa de limpeza selectiva por material azul | O marcador azul-ciano visível persiste; requer identificação pelo nó concreto |

## Evidência

| Item | Caminho |
|---|---|
| Captura final | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_groundscatter/road_to_arch_36s.png` |
| Duração | 36 segundos de gameplay real |
| Log técnico | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_groundscatter/runtime_36s.log` |
| Avaliação comparativa | `/home/ubuntu/qa_evidence_dev1_cp245/road_to_arch_slope_outcrops/avaliacao_visual.md` |

## Próximo ciclo iniciado

O próximo passe deve focar a **silhueta e a distribuição de vegetação do horizonte R1→R3**, com modelos reais já disponíveis, preservando a janela de leitura para o Arco e sem reintroduzir painéis, portais, arcos alternativos ou proxies humanos rejeitados.
