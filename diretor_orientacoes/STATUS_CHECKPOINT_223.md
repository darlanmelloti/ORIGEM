# CP 223 — Mapa Cartográfico Jogável

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Interface de jogo e Regiões 1–6; nenhuma alteração em módulos das Regiões 7–12.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Alteração

O mapa cartográfico oficial passou a existir no jogo como interface consultável. Foram integrados:

| Componente | Função |
|---|---|
| `assets/ui/mapa_cartografico_origem.png` | Activo local convertido do mapa aprovado pela Direcção; inclui os 12 marcos oficiais. |
| `ui/menus/CartographicMapUI.gd` | Sobreposição 4:3 centrada, com fundo de contraste, título e instrução de fecho. |
| `scripts/main.gd` | Instancia o mapa durante o gameplay e alterna a sua consulta pela tecla `M`. |
| `levels/CartographicAnchors.gd` | Continua a fornecer as coordenadas que ligam o mapa à geografia procedural. |

A cartografia deixa de estar apenas nos documentos: o jogador pode confrontar directamente o mapa com as relações físicas do vale — Casa, Estrada, Arco, Floresta, Acampamento, Lago, Vila e Montanha Orion.

## Validação

| Prova | Resultado |
|---|---|
| Importação do PNG cartográfico pelo Godot | Aprovada |
| Mapa aberto após Novo Jogo | Aprovado |
| Composição a 1920×1080 | Aprovada; mapa completo centrado e legível |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser, script ou importação | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 224 — Orientação cartográfica inicial.** O próximo ciclo reforça a saída física da Casa Voss para que a primeira vista de Elias exponha a ordem geográfica Casa → Estrada do Rio → Arco das Ruínas, usando apenas os módulos Dev1 e mantendo o mapa como referência de composição.
