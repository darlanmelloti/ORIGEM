# Matriz de Continuidade Cartográfica — Regiões 1–6

**Checkpoint:** CP-CARTO-09  
**Data:** 18 de agosto de 2026  
**Autoridade espacial:** `levels/CartographicAnchors.gd`  
**Fronteira:** exclusivamente Regiões 1–6; nenhuma alteração às Regiões 7–12.

> O mapa cartográfico é a autoridade espacial. Esta matriz não substitui a geometria, os handoffs nem a evidência de jogo; organiza as provas e expõe as lacunas que ainda precisam de passe físico.

## 1. Âncoras e profundidade macro

| Ordem | Marco | Âncora mundial `(x, z)` | Distância directa ao marco seguinte | Estado estrutural actual |
| ---: | --- | --- | ---: | --- |
| 1 | Casa Voss | `(-22, 8)` | 4,04 m | Porta por `[E]`, saída e prólogo QA validados. |
| 2 | Estrada do Rio | `(-21,4, 12)` | 36,30 m | Rio lateral, faixa de percurso e Arco à distância. |
| 3 | Arco das Ruínas | `(-16,741, 48)` | 68,44 m | Silhueta preservada; leitura de aproximação estabilizada. |
| 4 | Floresta Densa | `(-9, 116)` | 100,42 m | Limiar com sub-bosque e rota física de saída do Arco. |
| 5 | Acampamento Majestic | `(-88, 178)` | 165,46 m | Ligação ao trilho reforçada para faixa de colisão contínua. |
| 6 | Ruínas Submersas | `(60, 252)` | — | Entrada de margem clareada e vestígios arqueológicos legíveis. |

A distância directa Casa Voss–Ruínas Submersas é **257,41 m**. A cadeia não deve ser comprimida para a caber num enquadramento único; o primeiro vale deve sugerir os destinos, enquanto cada limiar revela a próxima região por geometria real.

## 2. Provas e estado por transição

| Transição | Evidência mais recente | Estado | Decisão de produção |
| --- | --- | --- | --- |
| Casa Voss → Estrada | `cp_carto05_normal30.png` | Aceite | Manter porta, eixo e rio lateral; não voltar a calibrar material de solo rejeitado. |
| Estrada → Arco | `cp_carto05_normal30.png` | Aceite | Manter a correção estrutural da triangulação e do afunilamento de margem. |
| Arco → Floresta | `cp_carto06_arch_forest_understory_scale30.png` | Aceite | Manter sub-bosque fora da faixa de 3,1 m e spawn QA estabilizado. |
| Floresta → Majestic | `cp_carto07_dense_connector30.png` | Aceite tecnicamente | Conector tem 41 lajes e colisores sobrepostos; o llvmpipe limita a distância percorrida na captura, mas W foi recebido, Elias esteve apoiado e começou a avançar. |
| Majestic → Ruínas | `cp_carto08_ruins_approach30.png` e `cp_carto08_ruins_tall_silhouette30.png` | Aceite com refinamento contínuo | Clareira local de margem e vestígios verticais preservados; próximo passe deve tratar leitura macro, não água ou decoração repetitiva. |

## 3. Lacunas abertas e prioridade

| Prioridade | Lacuna verificável | Proprietário | Próxima acção | Critério de aceitação |
| ---: | --- | --- | --- | --- |
| 1 | A leitura contínua do vale não foi ainda capturada numa única prova devido ao limite de renderização do llvmpipe. | Dev1 | Criar sequência QA segmentada, com posições e direcções canónicas, sem teletransportar a versão normal. | Seis segmentos com câmara coerente, log sem erro e 30 segundos de execução por segmento. |
| 2 | A chegada às Ruínas ainda depende de um limiar de baixa altitude; o lago deve manter-se lateral e as ruínas devem conduzir o olhar. | Dev1 | Comparar a abordagem de margem com os vestígios existentes e ajustar somente massas verticais apoiadas se forem ocultadas. | Entrada reconhecível por trilho, clareira e ruínas reais, sem alterar o material da água. |
| 3 | O primeiro vale ainda precisa de uma composição de vista longa que comunique os marcos sem comprimir a escala. | Dev3 em coordenação, sem alterar geometria regional | Reutilizar a matriz e as âncoras na mesma câmara de recaptura para apontar lacunas materiais ao Dev1. | Três tomadas comparáveis: Casa/vale, Arco/Floresta, Majestic/Ruínas. |
| 4 | Orçamento consolidado de colisores por rota precisa ser mantido durante futuros passes. | Dev4 de apoio a Dev2/Dev3 | Atualizar auditoria transversal, sem abrir DIR isolado e sem alterar Regiões 1–6. | Sem excesso de luzes visíveis; scope guard e regressão de rota limpos. |

## 4. Próximo ciclo iniciado

O **CP-CARTO-10** inicia uma prova QA segmentada de continuidade macro. O primeiro segmento será **Casa Voss → Estrada → Arco**, usando a câmara normal e as âncoras existentes para verificar que a primeira vista mantém vale, rio e silhueta do Arco em profundidade real. Não se alteram os materiais da estrada, a água nem as Regiões 7–12 neste ciclo.

## 5. Evidências locais

As capturas e logs permanecem em `/home/ubuntu/qa_evidence_voss_vista/`. Os ficheiros principais desta consolidação são `cp_carto05_normal30.png`, `cp_carto06_arch_forest_understory_scale30.png`, `cp_carto07_dense_connector30.png`, `cp_carto08_ruins_approach30.png` e `cp_carto08_ruins_tall_silhouette30.png`.
