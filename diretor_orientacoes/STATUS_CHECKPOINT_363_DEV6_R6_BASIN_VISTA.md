# STATUS CHECKPOINT 363 — Dev6 R6: leitura de vista da bacia

**Data:** 2026-08-26
**Região:** R6 — Ruínas Submersas
**Tarefa concluída:** `DEV6-R6-BASIN-VISTA-READING-005`

## Entrega

A camada `levels/regions/r6/R6BasinVistaReading.gd` transforma somente as três rochas existentes do `PromontorioOrientalDaBacia`. O ajuste reforça a leitura lateral do promontório e da cascata sem criar qualquer elemento visual ou físico: não há nós de mundo adicionais, malhas, materiais novos, água, emissão, luzes, colisores, partículas, shaders, interface, câmara ou alteração de rota.

| Verificação | Resultado |
|---|---|
| Rochas existentes ajustadas | 3 |
| Luzes novas | 0 |
| Água e cascata | Inalteradas |
| Leito, margem e lajes | Inalterados |
| Orçamento R6 | 4 luzes mantidas |
| Porta R6 | Aprovada |
| Rotas R6 | `forest_to_ruins`, `majestic_to_lake`, `ruins_arrival` aprovadas |

## Sucessão

A tarefa ativa passa a ser `DEV6-R6-OUTER-WATERLINE-SILHOUETTE-006`, limitada à leitura exterior da margem com materiais e instâncias R6 existentes. A R7 continua estritamente fora de escopo. A entrega fica consolidada localmente e será publicada assim que o canal oficial de escrita voltar a estar disponível.
