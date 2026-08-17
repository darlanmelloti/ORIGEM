# Dev2 — Especificação de handoff para CP-CINE-06 / CP-CINE-07

## Leitura do estado existente

`HighlandRegion.gd` já contém uma Vila Elevada em `(140, 352)` e Observatório em `(194, 404)`. Estas massas pertencem correctamente às Regiões 7–9, mas entram muito depois do limite Dev1 e não constituem, por si sós, a primeira camada remota da tomada Casa Voss. A correcção não é aproximar a vila ou deslocar Orion; é criar a **transição física real** que ocupa os primeiros 60–80 metros da Região 7 entre a margem R6 e a cidade principal.

## Implementação pedida ao Dev2

Adicionar um construtor próprio e reversível de handoff em `HighlandRegion.gd`, sem modificar módulos Dev1, com três grupos descontínuos e exploráveis:

| Grupo | Intervalo indicativo | Papel no quadro Casa Voss | Limite |
|---|---:|---|---|
| Terraços de passagem R7 | `z=288–306`, `x=36–72` | Primeira massa de pedra escalonada após as Ruínas Submersas | Sem edifícios completos, sem luzes |
| Borda baixa da vila | `z=315–334`, `x=86–118` | Sugerir a Vila Elevada sem a trazer para a margem do lago | Muros quebrados, pilares e 2–3 coberturas máximas |
| Contraforte de subida | `z=334–354`, `x=120–152` | Conduzir o olhar e a rota até à Vila principal em `z≈352` | Rocha real com copa isolada; não criar parede contínua |

Os agrupamentos são complementos tridimensionais de travessia futura, não LODs planos, fundos, painéis, partículas ou luzes. Devem consultar `TerrainPatch.height_at`, manter vazios entre massas e ficar fora da largura navegável da rota `R6→R7`.

## Validação e continuidade

Use Godot 4.7.1 / OpenGL para headless, 30 segundos de percurso R6→R7 e uma captura 16:9 de handoff. Depois de publicar, CP-CINE-07 repetirá a tomada Casa Voss congelada; se a cadeia não for perceptível, o retorno continuará a pertencer ao Dev2 e será corrigido sem alterar a escala, o FOV ou as Regiões 1–6.
