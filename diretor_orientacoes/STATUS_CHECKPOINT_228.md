# CP 228 — Marcador Dinâmico de Elias no Mapa

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** interface de mapa e Regiões 1–6; nenhuma alteração em módulos Dev2.

## Alteração

O mapa consultável pela tecla `M` passou a mostrar a posição actual de Elias. O marcador azul com contorno dourado e legenda **ELIAS** é convertido das coordenadas 3D do jogador para a janela útil da cartografia, permitindo comparar a localização real com Casa Voss, Estrada do Rio, Arco, Floresta, Acampamento, Bacia Central e Vila Elevada.

| Componente | Função |
|---|---|
| `CartographicMapUI.gd` | Converte as coordenadas mundiais em posição no mapa e desenha o marcador. |
| `main.gd` | Actualiza a posição do marcador durante o gameplay. |
| Textura de mapa | Mantém a proporção 4:3 e a legibilidade integral a 1920×1080. |

O marcador é filho da própria textura do mapa, garantindo que não se desloca quando a interface escala para resoluções diferentes.

## Validação

| Prova | Resultado |
|---|---|
| Mapa aberto após Novo Jogo | Aprovado |
| Marcador Elias visível sobre a cartografia | Aprovado |
| Arranque headless Godot 4.7.1 | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Coordenação Dev2

A ordem `ORDEM_CARTOGRAFICA_DEV2_CP-D2-003.md` foi publicada na branch Dev2 em `0b805fb`. Dev2 deve agora ancorar Vila Elevada, Observatório e Trilha da Montanha ao mesmo registo de cartografia, sem alterar módulos Dev1.

## Próximo incremento autónomo

**CP 229 — Legibilidade do destino activo.** O próximo ciclo acrescenta uma orientação discreta no mapa para o próximo marco da rota inicial, sem transformar a exploração em HUD intrusivo.
