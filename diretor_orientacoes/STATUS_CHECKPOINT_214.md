# ORIGEM — Checkpoint 214: Pedras Emergentes da Ponte de Pedra do Vale

**Branch:** `feature/dev1-gameplay-core`  
**Módulo:** `levels/DaylightValley.gd`  
**Âmbito:** Vale de Kheper / Regiões 1–6, sem intervenção nos módulos das Regiões 7–12.

## Incremento Aplicado

Foram adicionadas três pedras de leito emergentes em torno da `PonteDePedraDoVale`. Cada pedra usa uma malha rochosa real, material húmido dedicado e uma altura calculada a partir da lâmina de água local, ficando claramente visível acima da superfície sem produzir o efeito de objecto suspenso. As pedras são visuais e não recebem colisores: a travessia oficial continua a ser a ponte com o colisor físico já validado.

| Elemento | Quantidade | Decisão técnica |
|---|---:|---|
| Pedras emergentes | 3 | Escala, rotação e posição distintas |
| Colisores novos | 0 | Evita bloqueio acidental da travessia |
| Luzes novas | 0 | Não altera o orçamento da GTX 1050 Ti |
| Altura | Dinâmica | Calculada sobre o nível de água do rio |

## Verificação Obrigatória

| Verificação | Resultado |
|---|---|
| Arranque técnico headless Godot 4.7.1 | ✅ Aprovado |
| Gameplay integrado — prólogo 30 s | ✅ Aprovado |
| Gameplay integrado — Acampamento Majestic → lago 30 s | ✅ Aprovado |
| Percurso específico da Ponte de Pedra 30 s | ✅ Aprovado |
| Travessia física principal | ✅ Preservada; as pedras não têm colisores |
| Fronteira Regiões 7–12 | ✅ Mantida |

## Próximo Passo

**CP 215 — Auditoria de colisores do percurso principal.** Verificar o caminho da Casa Voss até às Ruínas Submersas, confirmar que nenhum colisor novo ocupa a rota e registar correcções exclusivamente onde forem necessárias.
