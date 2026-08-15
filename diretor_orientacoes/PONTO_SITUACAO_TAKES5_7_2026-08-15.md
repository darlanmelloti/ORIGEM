# ORIGEM — Ponto de Situação para Direção

**Data:** 15 de agosto de 2026  
**Branch local:** `feature/dev2-mountain-canyon`  
**Motor:** Godot 4.7.1 stable, projeto configurado para Forward+  
**Escopo:** Takes 5–7, a partir do sopé da montanha até à câmara do Cubo de Orion.

## Estado técnico

A base `ORIGEM_Base` foi reconstruída localmente a partir do pacote fornecido e está organizada como um working tree Git independente na branch `feature/dev2-mountain-canyon`. O projeto abre no Godot 4.7.1 e o editor headless conclui sem erros de parser. A configuração existente mantém Forward+ e SDFGI; para capturas no sandbox foi usado temporariamente `gl_compatibility`, porque o Xvfb sem GPU apresenta frames Forward+ pretos. Esta alteração é apenas de execução da captura e não altera a configuração alvo do projeto.

Foi adicionado `levels/Takes5to7Director.gd`, anexado à cena principal. O director usa `OrganicRuinKit.gd` para gerar rochas, colunas e estruturas orgânicas com deslocamento de vértices, materiais PBR, fissuras de ressonância azul, braseiros, câmara aberta do Cubo de Orion e presença táctica da Sentinela Kharu. Não foram introduzidas caixas cinzentas como solução final no novo bloco.

Foi acrescentado um modo de validação opt-in através de `ORIGEM_TAKE57=1`, além de uma tentativa de argumento `--take57`, para permitir iniciar o ciclo perto do Take 5 sem modificar o fluxo normal do prólogo. A intenção é acelerar o ciclo de auditoria de um minuto, mantendo o lançamento normal intacto.

## Testes executados

| Ciclo | Resultado | Evidência |
| --- | --- | --- |
| Editor headless Godot 4.7.1 | Passou sem `Parse Error` ou erro de script | `/tmp/origem-takes57-parse.log` |
| F5 headless de 60 segundos | Terminou com status 0 | `/tmp/origem-takes57-f5.log` |
| F5 gráfico Forward+ no Xvfb | Frame preto no sandbox; limitação de apresentação Vulkan sem GPU | `validation/take57-1600x900-2.jpg` |
| F5 gráfico `gl_compatibility` | Renderizou vale alpino, montanha, rio, árvores e ruínas | `validation/take57-camera-1600x900.jpg` |
| F5 com validação Take 5–7 | A câmara dedicada ainda falha ao entrar no interior da caverna e devolve frame preto | `validation/take57-cave-1600x900.jpg` |

## Avaliação visual atual

A captura bem-sucedida confirma que o mundo base tem leitura alpina: céu, serra distante, água, floresta e ruínas são visíveis, com HUD de Elias e stamina legíveis. Contudo, a aceitação dos Takes 5–7 ainda não deve ser marcada como concluída. A composição exterior é funcional, mas a câmara colocada no interior do corredor de caverna fica provavelmente dentro ou atrás de geometria gerada, devolvendo um frame preto. O ciclo seguinte deve resolver a posição/frustum da câmara e obter um print real do Take 5; só depois deve avançar para capturas específicas do desfiladeiro e da câmara de Orion.

## Bloqueios e pedido de orientação

A leitura pública do remoto confirmou apenas as branches `main` e `main-1`; a branch `feature/dev2-mountain-canyon` não apareceu no endpoint público durante esta sessão. A pasta `diretor_orientacoes/` também não estava visível no `main` no momento da auditoria. Por essa razão, este relatório foi preparado localmente no caminho solicitado, mas o push remoto ainda precisa de autenticação GitHub efetiva ou de confirmação de que o convite/conector foi aplicado à sessão.

A orientação solicitada à direção é: confirmar a branch remota correta e indicar se o Take 5 deve usar uma câmara exterior enquadrando a boca da caverna ou uma câmara já no corredor interno. A equipa manterá o ciclo de implementação, F5, print, comparação e refinamento antes de declarar o bloco aprovado.
