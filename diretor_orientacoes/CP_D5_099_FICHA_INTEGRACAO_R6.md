# CP-D5-099 — Ficha de Integração R6: Margem Viva das Ruínas

## Finalidade

Esta ficha permite ao Dev1 integrar o candidato `R6LivingShorePreview.tscn` no proprietário de R6 através de um commit isolado. A proposta substitui a linguagem rejeitada de cais por uma margem viva com água, ruína de abrigo colapsada, vegetação baixa e fauna, sem alterar `TempleLevel.gd` nem qualquer módulo de produção Dev5.

## Dados de implantação

| Elemento | Posição ou regra | Grupo/colisor | Limite |
|---|---|---|---|
| Âncora R6 | `R6_ANCHOR=(60,252)` em X/Z | Contrato cartográfico | Preservar exactamente |
| Corredor de Elias | `x=60`, percurso z `242→282` | Actor/cápsula própria na QA | Manter livre até à passagem R6→R7 |
| Água | Plano centrado em `(60,0.055,284)`, dimensão 46×11 | Visual, sem bloquear a rota | Não cobrir a âncora nem a margem de travessia |
| Ruína viva | Pilar, base e capitel tombado em torno de `(47,269)`, `(45,271)` e `(51,271)` | Colisores próprios | Abrigo colapsado; não formar cais, ponte ou cairn |
| Vegetação | 2 carvalhos e 2 fetos laterais | LOD leve; colisores não bloqueantes | Fora do corredor e da superfície de água |
| Fauna | 2 cervos CC0 em `(69,260)` e `(73,266)` | `decorative_fauna`; sem colisor bloqueante | Distância mínima de 5 m de Elias e do eixo |
| Luz | Sol direccional da composição | Uma luz dinâmica candidata | Máximo de 1 luz adicional na integração |

## Sequência obrigatória de integração

1. Criar um commit isolado no proprietário de R6, inserindo primeiro o terreno/margem e a ruína viva aterrada na âncora `R6_ANCHOR`.
2. Executar o percurso `R6→R7` durante pelo menos 36 segundos, confirmando `x=60`, passagem livre e continuidade para a Vila Elevada.
3. Inserir a água somente depois de validar que ela não cobre o corredor, a âncora ou os colisores de margem.
4. Adicionar vegetação lateral sem repetir lajes/colunas uniformes do cais rejeitado e sem criar parede ou portal.
5. Adicionar os dois cervos por último, confirmando distância mínima de 5 m e ausência de colisores bloqueantes.
6. Capturar internamente, contar luzes e verificar o orçamento global antes de manter o commit.

## Critérios de aceitação

A integração só é aceite se a âncora `(60,252)` e o corredor `x=60` permanecerem estáveis, a ligação R6→R7 continuar livre, a água permanecer separada da rota, a ruína ler como abrigo colapsado e não como cais, os cervos ficarem a pelo menos 5 m do percurso, a vegetação respeitar LOD e o orçamento de iluminação ficar dentro do limite.

## Reversão

Reverter exclusivamente o commit R6 se houver bloqueio da passagem, água a cobrir o corredor, ruína a ler como cais/cairn, fauna a menos de 5 m, parede vegetal, perda da âncora ou excesso de luzes. A cena Dev5 permanece como evidência QA e não deve ser apagada.

## Referências QA

- Cena: `levels/dev5/R6LivingShorePreview.tscn`.
- Script: `levels/dev5/R6LivingShorePreview.gd`.
- Contratos: `CartographicPlacementSystem.gd`, `CartographicGroundingSystem.gd` e `EliasThirdPersonPresentation.gd`.
- Candidato anterior rejeitado: `CP_D5_017_CAIS_RUINAS_REJEITADO.md`.

## Próximo ciclo

**CP-D5-100 — abrir imediatamente após a publicação desta ficha**, sem espera passiva.
