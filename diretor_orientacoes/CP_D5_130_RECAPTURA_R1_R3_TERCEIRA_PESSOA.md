# CP-D5-130 — Recaptura cartográfica R1→R3 em terceira pessoa

## Objectivo

A pré-visualização `R1R3ThirdPersonCartographicPreview` foi criada para avaliar a leitura Casa Voss/Estrada/Arco com **Elias visível em terceira pessoa**, sem alterar o controlador de primeira pessoa de produção, a rota canónica ou qualquer módulo das Regiões 7–12.

## Validação

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | PASS |
| Sessão de gameplay | 36 segundos |
| Elias | PASS — silhueta de terceira pessoa, ancorada pela função `TerrainPatch.height_at()` no preview isolado |
| Câmara | PASS — Elias no terço inferior; Arco em `z=92` no eixo central |
| Escala | PASS — distância lógica Estrada→Arco superior a 60 m |
| Luzes introduzidas | 1 direccional local ao preview; não promove nem altera o orçamento de produção |
| Regiões 7–12 | Não alteradas |

## Decisão visual

> **REJECTED_VISUAL — não promover.** A tomada resolve a ocultação causada pela arma de primeira pessoa e comprova a necessidade da perspectiva exterior, mas a cena de QA ainda mostra terreno granular, marcadores técnicos e ruínas de baixa complexidade. Não representa o padrão visual de produção nem satisfaz o limiar de 85%.

## Bloqueios concretos para integração

1. **Dev1:** a captura de produção deve ocultar os marcadores técnicos e reutilizar a câmara de terceira pessoa sem substituir o jogador de produção.
2. **Dev6:** a próxima integração ambiental deve concentrar-se na transição de materiais e na leitura dos planos de terreno, sem criar geometria de marcador.
3. **Dev7:** a substituição futura da silhueta provisória de Elias por activo humano final continua necessária; não usar o proxy como referência de aprovação.

## Estado

A pré-visualização é uma ferramenta de recaptura e permanece isolada em `levels/dev5/`. A tarefa seguinte legítima é integrar a câmara externa como **camada QA reversível** no ambiente de produção, após coordenação com Dev1.
