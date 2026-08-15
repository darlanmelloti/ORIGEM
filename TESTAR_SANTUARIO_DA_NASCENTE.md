# ORIGEM — Vertical Slice: Santuário da Nascente

A vertical slice reúne um percurso curto com navegação, natureza, ruínas, combate e recompensa. O objetivo é validar uma área pequena antes de expandir o mundo aberto.

## Rota de teste

| Etapa | Ação esperada |
| --- | --- |
| 1. Praça inicial | Observe colunas com musgo, relva e o caminho de lajes que conduz ao vale. |
| 2. Arco das Marés | Siga o caminho principal até ao arco. Os Kharu da estrada são encontros territoriais; pode lutar ou afastar-se. |
| 3. Passagem da Nascente | Procure a rota de lajes que se desvia para oeste, em direção ao lago e às ruínas maiores. |
| 4. Santuário | Entre pela escadaria, observe as colunas modulares, paredes quebradas, raízes e hera. |
| 5. Capitão Kharu | Um Kharu mais resistente patrulha junto à entrada. Ele não deve perseguir Elias além do território do santuário. |
| 6. Fragmento | Após alcançar o pedestal azul, mire no fragmento e pressione **E**. Elias recupera 35 pontos de vida e recebe uma mensagem de Seraph. |

## Controlos

| Controlo | Ação |
| --- | --- |
| `WASD` | Mover Elias. |
| Rato | Olhar. |
| Botão esquerdo | Ataque de espada. |
| Botão direito | Defender. |
| `Shift` | Correr. |
| `E` | Interagir com o Fragmento da Nascente. |

## Critérios de aprovação

O santuário deve parecer uma zona distinta do vale: pedra mais fria, água próxima, ruínas quebradas, musgo, raízes, luz azul discreta e uma rota visual clara. O Fragmento deve flutuar sobre o pedestal e desaparecer após ser obtido.

Se o fragmento não responder a `E`, confirme que está a olhar diretamente para o pedestal. Se ocorrer uma mensagem vermelha no Godot, envie uma captura que mostre também a aba **Depurador**.
