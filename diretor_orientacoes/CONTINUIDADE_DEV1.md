# Continuidade — Dev1

Os **CP 281–287** foram validados com Godot headless, capturas e gameplay real de 30 segundos. A frente Dev1 concluiu soleira física, profundidade de relevo, água de rio, ponte positiva, transições Floresta–Majestic–Ruínas e reenquadramento do miradouro leste. Os commits encontram-se sincronizados em `feature/dev1-gameplay-core`.

O **CP 288 — Moldura Física da Casa Voss** está em execução. A tarefa imediata é reforçar a presença arquitectónica da Casa na margem esquerda da tomada, sem deslocar o jogador para dentro de geometria, sem criar painéis e sem reduzir a profundidade física já criada entre rio, ponte, Estrada e Arco.

| Critério obrigatório | Evidência exigida |
|---|---|
| Moldura da Casa | Parede, pilar, cobertura ou soleira reais entram no canto esquerdo sem ocultar o vale |
| Composição | Ponte, rio, Estrada e Arco continuam em planos legíveis |
| Integridade | Godot headless sem erros de parser, script ou recursos |
| Jogabilidade | Prova de 30 segundos Casa → Estrada → Arco sem bloqueios |
| Escopo | Apenas Regiões 1–6; Regiões 7–12 inalteradas |

> Ao validar o CP 288, abrir imediatamente o passe de consolidação de distribuição e evidências, mantendo o desenvolvimento em curso.

**Estado:** `CP 288 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.
