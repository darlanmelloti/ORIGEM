# CP-CINE-50 — Reversão do Focal de Rota

## Resultado

A reentrância integrada na parede exterior e a reorientação da segunda luz permaneceram tecnicamente estáveis durante 30 segundos, mas não produziram um ponto focal perceptível na captura. A curva continuou a finalizar numa área negra e a modificação não atingiu o limiar de ganho visual necessário.

O código de `OrionInterior.gd` será restaurado à composição CP-CINE-48, que mantém a transição física já validada, o corredor contínuo, o retorno por **E**, o Cube oculto e duas luzes locais sem sombras.

## Conclusão operacional

A orientação do corredor não deve depender de uma reentrância subtil numa parede de baixa iluminação. O próximo ciclo terá de validar uma alteração de **composição de câmara e deslocação física do jogador**, usando a rota existente, antes de acrescentar qualquer geometria. Desta forma, a decisão evitará um novo passe de malha com ganho incerto.

## Próximo ciclo activo

**CP-CINE-51 — Leitura em movimento.** O ciclo utilizará a cena interior já publicada para verificar o que Elias vê em três posições reais da rota, sem alterar a geometria ou a iluminação até à análise estar concluída.
