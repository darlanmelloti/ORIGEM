# CP-D5-102 — Ficha de Integração R1: Casa Voss Viva

## Finalidade

Esta ficha permite ao Dev1 integrar, por commit isolado, o candidato `R1LivingVossExteriorPreview.tscn` no proprietário da Região 1. A composição dá vida ao exterior da Casa Voss com horta, pedras domésticas e fauna, mantendo a porta, o interior e a lógica de produção fora do escopo Dev5.

## Dados de implantação

| Elemento | Posição ou regra | Grupo/colisor | Limite |
|---|---|---|---|
| Âncora Voss | `(-22, 8)` em X/Z | Contrato cartográfico | Preservar exactamente |
| Corredor exterior | `x=-21.4`, z `-3→20` | Actor/cápsula própria na QA | Não bloquear a saída para R2 |
| Anexo Casa Voss | Aterrado em torno de `(-28,7)` | Colisores próprios do landmark | Exterior apenas; não substituir `VossHouse.gd` |
| Horta | 1 carvalho, 2 fetos e 2 pedras domésticas | LOD lateral, não bloqueante | Manter fora da soleira e da rota |
| Fauna | 2 cervos CC0 em pomar e estrada | `decorative_fauna`; sem colisor bloqueante | Distância mínima de 5 m de Elias |
| Porta/interior | Sem alteração | Produção existente | `door_touched=false`; não editar `Player.gd` |
| Luz | Sol direccional da composição | Uma luz dinâmica candidata | Máximo de 1 luz candidata |

## Sequência obrigatória de integração

1. Criar um commit isolado no proprietário R1 com o exterior aterrado e a horta lateral, sem tocar a porta, a casa de produção ou o interior.
2. Executar o percurso `R1→R2` durante pelo menos 36 segundos, confirmando a coordenada lateral `x=-21.4`, saída livre e orientação para a Estrada do Rio.
3. Verificar colisores do anexo e da horta para garantir que Elias não fica bloqueado na soleira ou na saída.
4. Adicionar os dois cervos por último, confirmando distância mínima de 5 m e ausência de colisores bloqueantes.
5. Capturar internamente, validar a câmara third-person, contar luzes e rever a transição R1→R2 antes de manter o commit.

## Critérios de aceitação

A integração só é aceite se a âncora `(-22,8)` e o corredor `x=-21.4` permanecerem estáveis, a Casa Voss continuar exterior e aterrada, a porta e o interior não sofrerem alterações, a saída R1→R2 permanecer livre, os cervos ficarem a pelo menos 5 m, a horta respeitar LOD e a iluminação permanecer dentro do orçamento GTX 1050 Ti.

## Reversão

Reverter exclusivamente o commit R1 se houver bloqueio da soleira/saída, alteração da porta ou interior, fauna a menos de 5 m, vegetação a formar barreira, perda da âncora ou excesso de luzes. A cena QA e a ficha permanecem como evidência de integração reversível.

## Referências QA

- Cena: `levels/dev5/R1LivingVossExteriorPreview.tscn`.
- Script: `levels/dev5/R1LivingVossExteriorPreview.gd`.
- Evidência base: `CP_D5_093_CASA_VOSS_VIVA.md`.
- Contratos: `CartographicPlacementSystem.gd`, `CartographicGroundingSystem.gd` e `EliasThirdPersonPresentation.gd`.

## Próximo ciclo

**CP-D5-103 — abrir imediatamente após a publicação desta ficha**, sem espera passiva.
