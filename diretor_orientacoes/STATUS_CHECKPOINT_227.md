# CP 227 — Handoff Cartográfico Ruínas → Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** lado permitido da Região 6 e interface de handoff; sem criação ou alteração de conteúdo da Região 7.

## Alteração

O trilho de acesso à Vila Elevada passou a derivar o seu eixo e a sua origem da âncora `VILA_ELEVADA` em `CartographicAnchors.gd`. O corredor continua a começar 67 unidades antes do handoff para preservar o espaço físico já validado, mas deixa de depender de posições dispersas.

| Elemento | Estado |
|---|---|
| Lajes de acesso | Eixo X e início Z derivados da âncora da Vila Elevada. |
| Portão de handoff | Mantém-se quatro unidades antes da âncora, no lado Dev1. |
| Marcador de spawn Dev2 | Mantém a posição exacta da âncora oficial. |
| Região 7 | Não modificada. |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 228 — Auditoria cartográfica integrada das Regiões 1–6.** O próximo ciclo verifica que todos os seis marcos Dev1 são derivados ou documentados pelo registo de âncoras e prepara a próxima lista de refinamento visual sem tocar no escopo Dev2.
