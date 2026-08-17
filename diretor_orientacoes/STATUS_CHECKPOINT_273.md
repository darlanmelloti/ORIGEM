# CP 273 — Integração hídrica Estrada → Bacia

**Estado:** validado; o ciclo segue directamente para o CP 274.

## Implementação

O afluente cartográfico que desemboca na Bacia recebeu margens escalonadas de rochas e fetos. As novas peças acompanham a progressão do curso de água desde a floresta até ao lago, utilizam o material de margem existente e não criam luzes, colisores ou bloqueios adicionais.

## Validação

| Prova | Resultado |
|---|---|
| Godot 4.7.1 headless | Aprovado; sem erros de parser ou recursos |
| Sonda regional | Aprovada; Estrada, Arco e Floresta presentes no mundo |
| Gameplay real | Aprovado em três segmentos de 10 segundos, totalizando 30 segundos no llvmpipe |

## Continuidade

O **CP 274 — Linhas de visão do vale Dev1** está iniciado. Deve melhorar apenas a leitura de camadas entre rio, Arco, floresta, Acampamento e Bacia, sem reduzir as distâncias macro e sem tocar nas Regiões 7–12.
