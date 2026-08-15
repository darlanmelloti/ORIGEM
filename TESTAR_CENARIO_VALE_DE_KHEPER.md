# ORIGEM — Teste do cenário Vale de Kheper

## O que foi alterado

Esta versão substitui o gerador instável de terreno por um cenário leve de malhas visuais. O jogador mantém um chão físico permanente definido em `scenes/main.tscn`; por isso, não deve entrar em queda livre ao iniciar.

| Elemento | Localização aproximada | Função atual |
| --- | --- | --- |
| Praça do Despertar | Posição inicial do jogador | Área segura e iluminada onde a exploração começa |
| Estrada dos Antigos | À frente, na direção norte (`-Z`) | Guia visual até às ruínas e às futuras zonas exploráveis |
| Portão Partido | Após a estrada inicial | Primeiro marco narrativo do vale |
| Templo do Sol | Esquerda do horizonte | Destino futuro de exploração |
| Templo da Lua | Direita do horizonte | Destino futuro de exploração |
| Pirâmides | Centro do horizonte | Referência visual central do mundo |
| Cordilheira | Fundo do vale | Limite visual do primeiro mapa aberto |

## Como testar

Abra o projeto no Godot e execute com **F6** ou **F5**. No menu principal, selecione **Novo Jogo**.

O jogador deve começar numa praça de pedra, sobre um chão sólido. Olhe para a frente e caminhe com **W**. A estrada de pedra conduz até ao portão em ruínas; além dele deve ser possível ver as pirâmides e as montanhas. Olhe para a esquerda para ver o Templo do Sol e para a direita para localizar o Templo da Lua.

## Se algo não aparecer

1. Confirme que `scenes/main.tscn` tem o nó `TempleLevel` com o script `res://levels/TempleLevel.gd`.
2. Confirme que `FloorCollider` e `FloorShape` existem na cena principal.
3. Confirme que o nó `LevelEnvironment` possui os filhos `Sun` e `WorldEnvironment`.
4. Consulte o painel **Depurador** e envie a primeira mensagem a vermelho, caso exista alguma.

> Esta é uma fase de *blockout* visual: os templos e as pirâmides são marcos de exploração. Numa próxima fase, cada marco poderá receber colisões, portas, NPCs, missões e interiores próprios.
