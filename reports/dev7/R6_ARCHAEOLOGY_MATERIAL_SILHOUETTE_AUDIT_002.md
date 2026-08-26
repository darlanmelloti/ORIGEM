# Auditoria Dev7 — Material e Silhueta Arqueológica R6 002

## Escopo executado

A auditoria foi executada exclusivamente em QA sobre a transição canónica `forest_to_ruins`. Foram localizados quatro marcos arqueológicos já existentes: a **Estela da Chegada**, um **Marco de Ruína Emergente**, um **Pilar Submerso** e um **Afloramento da Chegada às Ruínas**. Nenhum nó, luz, colisor, elemento de água, geometria, rota ou script de produção foi alterado.

| Verificação | Resultado |
|---|---|
| Meshes arqueológicos existentes localizados | 4/4 |
| Simulações locais de material em memória QA | 4/4 |
| Mutação de produção | 0 |
| Luzes R6 com nome canónico | 4/4 |
| Rota protegida | `forest_to_ruins`, sem alteração |

## Leitura e decisão

A baseline runtime confirma que a rota continua navegável, mas estes quatro elementos não se distinguem suficientemente do terreno na leitura à distância. A simulação QA de material demonstrou que há materiais StandardMaterial3D disponíveis para uma futura avaliação, mas não representa ainda evidência visual suficiente para autorizar qualquer override em produção.

> A próxima etapa é uma captura **QA temporária** comparando a leitura original com uma variante de contraste moderado aplicada apenas a uma cópia de cena de teste. Não se deve escrever override, shader ou material em `ForestLakeRegion.gd` nem em qualquer cena do jogo.

## Próxima tarefa proposta

`DEV7-R6-ARCHAEOLOGY-QA-OVERRIDE-CAPTURE-003`: produzir duas imagens 16:9 da mesma composição de `forest_to_ruins`, uma baseline e uma variante QA com contraste moderado em quatro elementos existentes; medir o orçamento de luz e confirmar ausência de alteração de rota/física antes de recomendar ou rejeitar uma alteração modular ao dono R6.
