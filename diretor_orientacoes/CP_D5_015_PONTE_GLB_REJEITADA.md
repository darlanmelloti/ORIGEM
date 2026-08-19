# CP-D5-015 — Ponte GLB leve: rejeitada em QA

**Marco:** 2 — Estrada do Rio.  
**Posição QA calculada:** `(-21,4; 28)` — deslocamento local `(0; +16)` a partir da âncora R2.  
**Métrica verificada:** 252 triângulos, 2 slots de material, 0 colisores importados.  
**Validação:** parser Godot 4.7.1 e sessão QA de 36 segundos; colisão contínua de tabuleiro adicionada pela cena QA.

A ponte GLB leve cumpriu o orçamento técnico, mas a captura mostrou um tabuleiro branco de escala reduzida e guarda-corpos excessivamente rectilíneos, sem massa de pedra, erosão ou leitura arqueológica suficiente. Ela não supera a ponte procedural QA nem a ponte de produção; por isso foi **rejeitada** e não deve avançar para revisão Dev1.

O resultado é útil para o catálogo: activos muito leves não são automaticamente adequados como marcos cartográficos. Futuras pontes só podem ser candidatas se combinarem eficiência com silhueta monumental e material coerente.

## Continuidade automática

CP-D5-016 torna-se activo: Dev5 deve capturar visualmente o candidato remoto `DenseForestPortalPreview.tscn`, decidir se ele evita a parede florestal e publicar a decisão. A rejeição desta ponte não permite espera.
