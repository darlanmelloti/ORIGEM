# CP-D5-098 — Ficha de Integração R5: Acampamento Majestic Vivo

## Finalidade

Esta ficha permite ao Dev1 integrar o candidato `R5LivingMajesticPreview.tscn` em `ForestLakeRegion.gd` por um commit isolado, sem que Dev5 altere o módulo de produção. A composição mantém o desvio lateral cartográfico do Majestic, preserva a ligação R5→R6 e usa o grounding apenas para resolver Y.

## Dados de implantação

| Elemento | Posição ou regra | Grupo/colisor | Limite |
|---|---|---|---|
| Centro Majestic | Âncora canónica X/Z `(-88.0, 178.0)` | Composição QA isolada | Preservar a coordenada lateral |
| Corredor de Elias | `x=-79.0`, percurso z `155.0→201.0` | Actor/cápsula própria na QA | Faixa livre; não deslocar para o eixo do pavilhão |
| Pavilhão | Centrado na âncora Majestic e aterrado por raycast | Colisores próprios do landmark | Uma instância; não cobrir o corredor |
| Abrigo desabado | Volumes laterais próximos de `(-99,188)`, `(-96,189)` e `(-101,189.5)` | Colisores baixos laterais | Não formar cairn, portal ou lintel sobre a rota |
| Vegetação | 1 pinheiro focal, 2 árvores detalhadas, 2 leves e 2 fetos | LOD CP-D5-018 | Fora da faixa de travessia; sem parede vegetal |
| Fauna | 2 cervos CC0, clareira e abrigo | `decorative_fauna`; sem colisor bloqueante | Distância mínima de 5 m de Elias e do corredor |
| Luz | Sol direccional existente da composição | Uma luz dinâmica candidata | Máximo de 1 luz adicional na integração |

## Sequência obrigatória de integração

1. Criar primeiro um commit isolado em `ForestLakeRegion.gd`, apenas com a clareira, o pavilhão e o grounding da âncora `(-88,178)`; Dev5 não executa essa alteração.
2. Executar o percurso `R5→R6` por pelo menos 36 segundos, confirmando que o desvio lateral Majestic permanece em `x=-79` e que a rota não converge indevidamente para o centro do pavilhão.
3. Validar os colisores do pavilhão e do abrigo sem bloquear Elias, a ligação para R6 ou a leitura do terreno.
4. Adicionar a vegetação respeitando o limite LOD e verificar que não se transforma numa parede ou num portal estrutural.
5. Adicionar os dois cervos por último, confirmando distância mínima de 5 m ao percurso e ausência de colisores bloqueantes.
6. Capturar a composição internamente, contar luzes dinâmicas e rever a transição R5→R6 antes de manter o commit.

## Critérios de aceitação

A integração só é aceite se a coordenada lateral Majestic permanecer estável, o corredor R5→R6 ficar livre, os dois cervos permanecerem a pelo menos 5 m da rota, o pavilhão e o abrigo continuarem aterrados, não houver portal/cairn artificial e o orçamento de iluminação permanecer dentro do limite definido.

## Reversão

Reverter exclusivamente o commit R5 se houver bloqueio do corredor, aproximação da fauna inferior a 5 m, perda da ligação R5→R6, parede vegetal, pavilhão a cobrir o caminho, alteração da coordenada lateral ou aumento de luzes além do limite. A cena Dev5 e esta ficha permanecem como evidência de QA e não devem ser apagadas.

## Referências QA

- Cena: `levels/dev5/R5LivingMajesticPreview.tscn`.
- Script: `levels/dev5/R5LivingMajesticPreview.gd`.
- Evidência base: `diretor_orientacoes/CP_D5_090_ACAMPAMENTO_MAJESTIC_VIVO.md`.
- Contratos: `CartographicPlacementSystem.gd`, `CartographicGroundingSystem.gd` e `EliasThirdPersonPresentation.gd`.

## Próximo ciclo

**CP-D5-099 — abrir imediatamente após a publicação desta ficha**, sem espera passiva, conforme a directiva contínua Dev5.
