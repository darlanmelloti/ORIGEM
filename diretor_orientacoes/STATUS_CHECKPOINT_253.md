# CP 253 — Continuidade Floresta Densa → Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Regiões 1–6, sem alterações nas Regiões 7–12.

## Auditoria da transição cartográfica

A passagem da Floresta Densa para o Acampamento Majestic já cumpre os três sinais físicos exigidos pela direcção e preserva o caminho de Elias:

| Sinal físico | Implementação confirmada | Impacto na rota |
|---|---|---|
| Percurso | 29 lajes de ligação com colisões rasas | Travessia física contínua |
| Margem orgânica | Rochas, fetos e quatro árvores em aglomerados descontínuos | Corredor sem efeito de parede vegetal |
| Orientação luminosa | Três luzes de expedição sem sombras | Leitura nocturna local |
| Destino | Fogueira, tendas, luar e estela `RuneP0_01` | Acampamento legível como ponto cartográfico 5 |

A auditoria confirma que não é necessário introduzir mais luzes ou colisores neste ponto: isso aumentaria o orçamento sem elevar materialmente a leitura da rota.

## Correcção de robustez

A sonda técnica que instancia `main.tscn` sem definir `current_scene` revelou dois acessos nulos no prólogo da Casa Voss. O código passou a verificar a existência da cena actual antes de anexar o prompt de salto, consultar a UI, ocultar nós legados ou aplicar a tempestade. A execução normal do prólogo não foi alterada.

## Validação

| Verificação | Resultado |
|---|---|
| Sonda Majestic / estela `RuneP0_01` | Aprovada |
| Raycast de interacção | `true` |
| Mensagem narrativa no HUD | `true` |
| Erros de script na sonda headless | Nenhum após correcção |
| Novo Jogo + exploração | 30 segundos aprovados |
| Erros de parser ou script no gameplay | Nenhum |

Evidências: `qa_evidence_new_game/majestic_probe_cp253.log` e `qa_evidence_new_game/walk_30s/depois_30s_movimento.png`.

## Próximo ciclo

Com os CPs 211–253 consolidados, o CP 254 prepara um ZIP integral e testado a partir de uma extracção limpa, antes de qualquer distribuição ao CEO.
