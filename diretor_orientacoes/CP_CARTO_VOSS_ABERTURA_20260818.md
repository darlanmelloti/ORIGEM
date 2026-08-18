# CP-CARTO — Abertura da Casa Voss e Leitura do Vale

## Objectivo

Reduzir a obstrução visual artificial na primeira leitura do vale, preservando a saída física da Casa Voss, a escala cartográfica real e a cadeia espacial **Casa Voss → Estrada do Rio → Arco das Ruínas**.

## Alteração aprovada

O `TerracoDeRevelacaoDaCasaVoss` e os degraus associados eram exclusivamente visuais, não suportavam a deslocação de Elias e introduziam uma massa rectangular cinzenta na soleira. A chamada de construção do miradouro foi removida. A porta, o terreno exterior e o corredor de saída não foram alterados.

A captura sem o miradouro mostrou uma soleira mais aberta: as lajes do percurso, a margem e a silhueta distante do Arco permanecem visíveis sem a plataforma rectangular a competir com a Casa Voss.

## Validação

| Verificação | Resultado |
| --- | --- |
| Godot 4.7.1, validação headless | Aprovada |
| Novo Jogo e sessão de 30 segundos | Aprovados sem erros de runtime |
| Porta `E` e rota exterior | Mantidas pela correcção física anterior |
| Luzes dinâmicas | Sem novas luzes |
| Fronteira regional | Alteração limitada à Casa Voss / Região 1 |

Evidência: `qa_evidence_voss_vista/cp_cartographic_voss_open_30s.png`.

## Candidatos rejeitados

A calibração de altura, escurecimento e variante sem iluminação directa do material de água não melhorou a leitura do curso; a última variante introduziu um brilho ciano artificial. Todas foram revertidas. O próximo ciclo deve tratar um marco físico de profundidade, não repetir os ajustes do shader hídrico.

## Próxima tarefa já iniciada

**CP-CARTO-02 — Arco das Ruínas:** medir a silhueta arqueológica no horizonte da saída Casa Voss e reforçar apenas a sua massa tridimensional apoiada, sem aproximar o marco nem invadir as Regiões 4–12.
