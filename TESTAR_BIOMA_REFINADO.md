# ORIGEM — Teste do Bioma Refinado

Esta versão corrige os problemas observados no vídeo anterior: relva em blocos, árvores arredondadas, objetos flutuantes, sombras fracas, relevo plano e montanhas com aspeto de recorte.

## O que validar

| Elemento | Resultado esperado |
| --- | --- |
| **Solo** | Terreno verde texturado, com elevações laterais e caminho central navegável. Não deve haver um plano plano a atravessar o vale. |
| **Relva** | Cobertura densa de tufos formados por várias lâminas; a base de cada tufo deve tocar o relevo. Não devem existir retângulos verdes suspensos. |
| **Árvores** | Tronco irregular, ramos inclinados e copa formada por grupos de folhas. As copas e arbustos oscilam de forma leve ao vento. |
| **Sombras** | Colunas, árvores, rochas e Kharu devem projetar sombras diretas no terreno; sombras excessivamente fracas indicam que o sol não foi carregado. |
| **Lago** | Água em malha 3D, com ondulação discreta e margens escavadas no próprio terreno. |
| **Montanhas** | Cristas volumétricas e irregulares no horizonte. Ao deslocar a câmara lateralmente, devem ter paralaxe e profundidade; não devem parecer um painel. |
| **Atmosfera** | Céu azul, nevoeiro muito leve e redução natural de contraste no horizonte. |

## Teste recomendado

1. Extraia o projeto em uma pasta nova e abra `project.godot` com Godot 4.7.
2. Execute com `F5` e escolha **Novo Jogo**.
3. Pare na praça inicial e rode a câmara: confirme as sombras das colunas e árvores no chão.
4. Caminhe até ao Arco das Marés. Observe os tufos de relva próximos; depois compare com a vegetação distante.
5. Desvie para a margem do lago e caminhe junto às árvores. Veja se as copas têm profundidade e se balançam suavemente.
6. Olhe para a cascata e cristas distantes enquanto se desloca lateralmente. A mudança de perspetiva deve confirmar que o horizonte é geométrico.

## Se algo continuar errado

Envie uma captura ou vídeo de 10–20 segundos que mostre o problema e inclua a aba **Depurador** do Godot caso exista uma mensagem vermelha. Não adicione manualmente um plano de chão ou um painel de imagem: `TerrainPatch.gd` cria a malha e a colisão necessárias.
