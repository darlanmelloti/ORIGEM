# Continuidade — Dev1

O **CP 281 — Miradouro de Revelação da Casa Voss** foi validado com Godot headless, captura da abertura e gameplay segmentado de 30 segundos. A soleira elevada possui colisores, degraus acessíveis, enquadramento de ruína e leitura transversal para o rio; nenhum módulo das Regiões 7–12 foi alterado.

O **CP 282 — Profundidade física do horizonte Casa Voss** está em execução. A tarefa imediata é construir e posicionar, dentro da frente Dev1, silhuetas de relevo e ruínas distantes que interpretem a Vila Elevada e a Montanha Orion como marcos longínquos. Estes elementos devem ser geometria real, manter a escala macro do mapa, não usar fundos planos, não alterar `HighlandRegion.gd` ou `OrionDestinationRegion.gd` e não introduzir luzes dinâmicas adicionais.

| Critério obrigatório | Evidência exigida |
|---|---|
| Leitura da profundidade | Captura 16:9 da saída da Casa com pelo menos três planos: Casa/soleira, Estrada–Arco e horizonte |
| Integridade física | Validação Godot headless sem erros |
| Jogabilidade | Prova segmentada de 30 segundos sem bloqueio no percurso Casa → Estrada |
| Âmbito | Diferença de Git limitada às Regiões 1–6 e documentos de orientação Dev1 |

> A captura e o commit são evidências do ciclo, não pontos de paragem. Após o CP 282, o próximo passe deve abrir automaticamente o reforço da leitura de água e margens entre Estrada, Floresta Densa e Acampamento Majestic.

**Estado:** `CP 282 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.
