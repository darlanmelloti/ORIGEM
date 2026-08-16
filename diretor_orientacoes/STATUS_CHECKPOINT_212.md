# ORIGEM — Checkpoint 212: Variação Horizontal das Coníferas

**Branch:** `feature/dev1-gameplay-core`  
**Módulo:** `levels/ForestLakeRegion.gd`  
**Âmbito:** Região 4 — Floresta Densa, sem alterações nas Regiões 7–12.

## Incremento Aplicado

As coníferas económicas da Floresta Densa passaram a receber variação horizontal XZ determinística. O intervalo varia de `0.85` a `1.15` da escala-base, equivalente a aproximadamente **±15%**, enquanto a variação de altura já existente é preservada separadamente. Árvores focais orgânicas — carvalhos, árvores escuras e árvores de ilha — não receberam este ajuste, preservando a composição cuidadosamente construída no primeiro plano.

A alteração mantém as bases das árvores no mesmo ponto, não adiciona luzes, não altera colisores e não aproxima vegetação do trilho principal. Assim, melhora a diversidade da silhueta sem afectar a navegação ou o orçamento da GTX 1050 Ti.

## Verificação Obrigatória

| Verificação | Resultado |
|---|---|
| Arranque técnico headless Godot 4.7.1 | ✅ Aprovado |
| Gameplay integrado — prólogo 30 s | ✅ Aprovado |
| Gameplay integrado — Acampamento Majestic → lago 30 s | ✅ Aprovado |
| Trilho principal da Floresta Densa | ✅ Mantido livre |
| Fronteira Regiões 7–12 | ✅ Mantida |

## Próximo Passo

**CP 213 — Luz de luar fria no Acampamento Majestic.** Adicionar uma `SpotLight3D` descendente, de baixa energia e tom azul frio, posicionada para recortar o acampamento sem competir com a fogueira e sem exceder o orçamento de luzes simultâneas.
