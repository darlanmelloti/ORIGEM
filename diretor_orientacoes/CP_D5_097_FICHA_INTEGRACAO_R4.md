# CP-D5-097 — Ficha de Integração R4: Floresta Densa Viva

## Implantação proposta

O candidato `R4LivingForestPreview` deve ser integrado em `ForestLakeRegion.gd` apenas num commit isolado do Dev1. A rota principal permanece no eixo cartográfico da Floresta; todos os activos laterais usam grounding por raycast e X/Z fixos.

| Grupo | Conteúdo | Regra de segurança |
|---|---|---|
| Corredor | Eixo mínimo de 5 m para Elias | Sem árvores, ruínas ou fauna dentro da faixa |
| Fauna | 2 cervos CC0 fora do caminho | Distância ≥5 m, sem colisor bloqueante |
| Vegetação | 1 pinheiro PBR, 3 árvores detalhadas, 2 leves, 2 fetos | Respeitar LOD CP-D5-018 e no máximo 1 feto por lado |
| Abrigo | 2 pedras laterais isoladas | Nunca formar portal/lintel sobre a rota |

## Sequência Dev1

1. Inserir primeiro a vegetação lateral e correr `arch_to_forest` durante 36 segundos.
2. Confirmar que a leitura do Arco físico em z≈92 permanece distante e que o corredor não se fecha.
3. Inserir as duas pedras do abrigo somente na lateral oeste; validar novamente a rota.
4. Adicionar fauna por último e confirmar distância mínima de 5 m ao jogador.
5. Capturar internamente, contar luzes dinâmicas e rever a composição antes de manter o commit.

## Reversão e exclusões

Reverter o commit completo se houver bloqueio, parede vegetal, portal estrutural, perda de legibilidade do Arco ou regressão da transição R3→R4. Dev5 não altera `ForestLakeRegion.gd`; a referência QA permanece em `R4LivingForestPreview.tscn` com a captura `qa_evidence_dev5_r4_living/r4_living.png`.

## Próximo ciclo

**CP-D5-098 — Ficha integração R5.** Preparar a implantação do Acampamento Majestic vivo, incluindo desvio lateral, pavilhão, fauna e ligação R5→R6.
