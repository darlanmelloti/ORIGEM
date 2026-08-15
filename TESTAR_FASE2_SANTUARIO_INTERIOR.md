# ORIGEM — Teste da Fase 2: Sentinela Kharu e Interior do Santuário

## Objetivo do teste

Esta versão acrescenta o primeiro encontro de elite e o primeiro bloco de masmorra. A experiência pretendida é uma sequência curta, mas completa: o jogador aproxima-se do Santuário da Nascente, enfrenta o Sentinela Temporal, abre o selo, atravessa os perigos do interior e alcança a Câmara do Cubo.

## Rota de teste

| Etapa | Ação esperada |
| --- | --- |
| 1. Aproximação | Inicie o jogo e avance até ao pátio do Santuário da Nascente. O Capitão Kharu está entre a entrada e o pátio interior. |
| 2. Elite Kharu | Ao entrar no alcance, deve aparecer a vida `SENTINELA KHARU` e a linha de `POSTURA`. O inimigo alterna golpes, deslocamento lateral e estocada quando a stamina de Elias está baixa. |
| 3. Postura | Ataque de forma controlada. Quando a postura chegar a zero, o Sentinela fica vulnerável durante cerca de 1,5 segundos. |
| 4. Selo | Depois de derrotar o capitão, a mensagem confirma a quebra do selo e a porta da masmorra desloca-se para abrir a passagem. |
| 5. Sala dos Poços | Avance pelo corredor. Na sala inundada, atravesse as ilhas centrais; entrar nos poços roxos deve causar dano e mostrar uma mensagem. |
| 6. Ressonância | Mire no pedestal azul e prima `E`. As plataformas tornam-se visíveis e formam uma ponte para a câmara final. |
| 7. Câmara do Cubo | Cruze a ponte, explore a Câmara do Cubo e interaja com o núcleo para receber a mensagem sobre os três fragmentos. |

## Controlos de combate

| Ação | Controlo | Efeito |
| --- | --- | --- |
| Ataque | Botão esquerdo do rato | Consome stamina e cria uma janela de recuperação. |
| Bloqueio | Botão direito do rato | Reduz dano, mas drena stamina. |
| Corrida | Shift | Drena stamina enquanto premido. |
| Interação | E | Lê runas, abre atalhos, ativa mecanismos e recolhe fragmentos. |

## Critérios técnicos

A importação em Godot 4.7.1 foi validada sem erros. Se a cena ficar demasiado escura, confirme que o projeto está a usar o renderizador **Forward+**. Para a GTX 1050, mantenha a escala 3D a 75%, SSAO ativo e névoa volumétrica global desligada.
