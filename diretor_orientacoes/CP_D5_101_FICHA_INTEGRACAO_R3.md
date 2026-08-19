# CP-D5-101 — Ficha de Integração R3: Arco das Ruínas Vivo

## Finalidade

Esta ficha permite ao Dev1 integrar, por commit isolado, o candidato `R3LivingArchCorridorPreview.tscn` no proprietário da Região 3. A composição dá vida ao corredor com fauna, vegetação e ruínas laterais, mas **não integra nem reintroduz o arco estrutural rejeitado**.

## Dados de implantação

| Elemento | Posição ou regra | Grupo/colisor | Limite |
|---|---|---|---|
| Âncora R3 | `(-16.741, 48)` em X/Z | Contrato cartográfico | Preservar exactamente |
| Corredor Elias | `x=-16.741`, z `68→98` | Actor/cápsula própria na QA | Faixa central livre |
| Alvo físico do Arco | `z=92` | Referência de profundidade | Manter legível sem construir arco |
| Ruínas laterais | Duas pedras em margens opostas | Colisores próprios baixos | Nunca formar portal, lintel ou arco |
| Vegetação | 2 árvores e 2 fetos | LOD lateral, sem bloqueio | Não criar parede vegetal |
| Fauna | 2 cervos CC0 fora do eixo | `decorative_fauna`; sem colisor bloqueante | Distância mínima de 5 m de Elias |
| Luz | Sol direccional da composição | Uma luz dinâmica candidata | Zero Omni/Spot; máximo 1 luz candidata |

## Sequência obrigatória de integração

1. Criar um commit isolado no proprietário R3 com o terreno e as duas ruínas laterais, sem adicionar qualquer arco estrutural.
2. Executar o percurso `R3→R4` durante pelo menos 36 segundos, confirmando a âncora `(-16.741,48)`, o alvo `z=92` e a passagem aberta.
3. Adicionar a vegetação nas margens, validando que a composição não forma parede nem reduz a escala do vale.
4. Adicionar os dois cervos por último, verificando a distância mínima de 5 m e a ausência de colisores bloqueantes.
5. Capturar internamente, verificar a câmara third-person, contar luzes e rever a orientação para R4 antes de manter o commit.

## Critérios de aceitação

A integração só é aceite se a passagem R3→R4 permanecer livre por três ciclos, o próximo destino continuar a ser Floresta Densa, o alvo físico `z=92` permanecer legível, não existir arco/portal estrutural, a fauna ficar a pelo menos 5 m do corredor, a vegetação respeitar o limite LOD e a iluminação permanecer dentro do orçamento GTX 1050 Ti.

## Reversão

Reverter exclusivamente o commit R3 se surgir um arco estrutural, portal, lintel, parede vegetal, escala comprimida, bloqueio de Elias, fauna a menos de 5 m ou regressão da orientação para R4. A rejeição histórica do arco estrutural continua válida; a cena QA e a ficha devem permanecer como evidência.

## Referências QA

- Cena: `levels/dev5/R3LivingArchCorridorPreview.tscn`.
- Script: `levels/dev5/R3LivingArchCorridorPreview.gd`.
- Evidências anteriores: `CP_D5_075_CORREDOR_ARCO_R3.md`, `CP_D5_078_VALIDACAO_CORREDOR_ARCO_R3.md` e `CP_D5_094_ARCO_RUINAS_VIVO.md`.
- Contratos: `CartographicPlacementSystem.gd`, `CartographicGroundingSystem.gd` e `EliasThirdPersonPresentation.gd`.

## Próximo ciclo

**CP-D5-102 — abrir imediatamente após a publicação desta ficha**, sem espera passiva.
