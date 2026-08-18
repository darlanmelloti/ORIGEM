# Consolidação de Evidências — CP-CARTO-49 a CP-CARTO-53

A continuidade das Regiões 1–6 mantém duas regras: nenhum passe visual é promovido sem validação Godot e gameplay real de 30 segundos; e nenhuma tentativa rejeitada é repetida sem uma hipótese causal nova.

| Checkpoint | Área | Decisão | Razão baseada em evidência |
| --- | --- | --- | --- |
| CP-CARTO-49 | Margem R6 | Aceite | As rochas sem material explícito eram a fonte predominante dos pequenos props claros; `ruin_material` eliminou-os. |
| CP-CARTO-50 | Fetos ribeirinhos R6 | Aceite | O corte alfa aplicado exclusivamente aos `FetoRibeirinho_*` eliminou a folha clara remanescente. |
| CP-CARTO-51 | Estrada→Arco | Evidência insuficiente | A rota avançada ultrapassou o marco; a tomada estacionária continuou com o Arco ocluído. |
| CP-CARTO-52 | Núcleo ribeirinho pós-Arco | Rejeitado e revertido | Recuar uma árvore não produziu ganho perceptível de leitura do Arco. |
| CP-CARTO-53 | Saída QA Casa Voss | Evidência insuficiente | A saída real preservou a Estrada, mas não isolou o Arco da massa vegetal. |

## Estado técnico consolidado

As capturas referidas foram obtidas no Godot 4.7.1 com `gl_compatibility`, cada prova aprovada cumpriu 30 segundos de gameplay real, e os fluxos Menu→Novo Jogo e limitador de luzes permanecem validados. As mudanças aceites estão publicadas em `afe49b8` e `6351b5b`; a rejeição CP-CARTO-52 está publicada em `65a00cb`.

## Próxima lacuna

A macro-legibilidade do Arco a partir da Estrada continua aberta, mas não autoriza redução cega de árvores. A próxima tentativa deve usar um enquadramento de QA que mantenha Casa Voss, eixo da Estrada e a silhueta do Arco simultaneamente em campo, ou demonstrar por uma sonda de projecção qual instância de geometria é oclusora.
