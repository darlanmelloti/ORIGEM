# CP-CINE-49 — Reversão da Ante-câmara Orion

## Decisão

A extensão contínua do corredor foi validada tecnicamente durante 30 segundos, mas a captura de comparação não mostrou uma mudança espacial suficientemente legível. A luz de percurso não alcançou o alargamento com contraste útil e a curva continuou a terminar num vazio escuro. A geometria não deve ser mantida como se representasse uma ante-câmara aprovada.

A alteração de `OrionInterior.gd` será revertida para a base CP-CINE-48. Mantêm-se o handoff físico, a cena independente, o corredor sem Cube e o retorno seguro por **E**.

## Aprendizagem preservada

A próxima composição não deve começar por prolongar o túnel actual. Antes de criar uma ante-câmara é necessário validar um **ponto focal físico iluminado** no fim da curva, ainda sem artefacto narrativo, para provar profundidade e orientar a rota. Esse objecto precisa de fazer parte da mesma malha/colisão ou ter uma base geometricamente aferida; rochas importadas sem aferição de pivô continuam excluídas.

## Próximo ciclo activo

**CP-CINE-50 — Focal de rota sem Cube.** O ciclo cria e valida uma terminação rochosa de baixo contraste e uma orientação luminosa substitutiva, mantendo o máximo de duas luzes locais e a rota central livre.
