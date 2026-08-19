# CP-D5-096 — Ficha de Integração R2: Estrada do Rio Viva

## Finalidade

Esta ficha permite ao Dev1 integrar o candidato `R2LivingRiverRoadPreview` em `RiverRoadJourney.gd` sem modificar a escala cartográfica, a água existente, a ponte funcional ou o percurso de Elias.

## Dados de implantação

| Elemento | Posição ou regra | Grupo/colisor | Limite |
|---|---|---|---|
| Ponte modular | Âncora Estrada `(-21.4, 12)`; conservar a orientação usada na rota R2 | Colisor de ponte já existente ou `StaticBody3D` dedicado | Nunca usar a ponte GLB rejeitada |
| Cervo margem oeste | Fora do trilho, distância ≥5 m de Elias e tabuleiro | `decorative_fauna`; sem colisor bloqueante | 1 instância |
| Cervo margem leste | Fora do trilho, distância ≥5 m de Elias e tabuleiro | `decorative_fauna`; sem colisor bloqueante | 1 instância |
| Vegetação | 2 árvores e 2 fetos fora da rota | Colisor apenas se necessário; nunca bloquear | LOD CP-D5-018 |
| Abrigo de margem | 2 pedras laterais; não é cairn ou ponte | Colisor baixo lateral | Manter fora do rio e do trilho |

## Sequência obrigatória de integração

1. Criar um commit isolado em `RiverRoadJourney.gd` e aplicar primeiro a ponte modular/elementos de margem, sem fauna.
2. Executar `road_to_arch` por 36 segundos, confirmar passagem livre e o alinhamento do rio.
3. Adicionar uma fauna de cada vez, verificando que a distância ao trajecto do jogador se mantém em pelo menos 5 m.
4. Adicionar flora e ruínas de margem respeitando o limite de LOD e sem alterar a leitura do Arco em z≈92.
5. Fazer captura interna e validar que o orçamento global não excede 16 luzes dinâmicas.

## Reversão

Se qualquer etapa bloquear o percurso, cobrir a água, aproximar a fauna do tabuleiro, reduzir a legibilidade do Arco ou introduzir regressão visual, reverter exclusivamente o commit R2. A cena Dev5 permanece como evidência e não deve ser apagada.

## Referências QA

- Cena: `levels/dev5/R2LivingRiverRoadPreview.tscn`
- Evidência: `qa_evidence_dev5_r2_living_fixed/r2_living_fixed.png`
- Telemetria: 9 aterramentos, 2 cervos, 4 elementos vegetais, 2 vestígios de abrigo e 4 ciclos de travessia livres.

## Próximo ciclo

**CP-D5-097 — Ficha de integração R4.** Aplicar o mesmo padrão à Floresta Densa, com corredor aberto, LOD vegetal e exclusão do portal estrutural.
