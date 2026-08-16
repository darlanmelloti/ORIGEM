# CP 241 — Auditoria da Sequência de Destinos Dev1

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Rota cartográfica Dev1 e interface de mapa.

## Auditoria determinística

Foi executada uma prova automática contra `CartographicAnchors.next_dev1_destination()` nos seis estados de progresso da rota Dev1.

| Estado do jogador | Destino esperado | Resultado |
|---|---|---|
| Casa Voss (`z=8`) | Estrada do Rio, marco 2 | Aprovado |
| Estrada do Rio (`z=25`) | Arco das Ruínas, marco 3 | Aprovado |
| Arco das Ruínas (`z=75`) | Floresta Densa, marco 4 | Aprovado |
| Floresta Densa (`z=145`) | Acampamento Majestic, marco 5 | Aprovado |
| Acampamento Majestic (`z=190`) | Ruínas Submersas, marco 6 | Aprovado |
| Ruínas Submersas (`z=245`) | Vila Elevada, marco 7 | Aprovado |

A sequência é centralizada e não há limiares residuais fora do registo cartográfico.

## Validação

| Prova | Resultado |
|---|---|
| Auditoria de rota | 6 de 6 estados aprovados |
| Novo Jogo com mapa aberto | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 242 — Auditoria de orientação Dev2.** A próxima acção verifica se a ordem cartográfica publicada para as Regiões 7–12 está consistente com os marcos 7–12 do mesmo registo, sem editar os módulos Dev2.
