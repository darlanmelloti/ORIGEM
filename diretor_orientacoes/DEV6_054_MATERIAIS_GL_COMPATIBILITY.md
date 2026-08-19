# DEV6-054 — Materiais em GL Compatibility

A auditoria distinguiu materiais globais do projecto dos recursos pertencentes às integrações Dev6. Os materiais de terreno, água, Casa Voss, Majestic e ruínas existentes ficaram fora do passe. A única duplicação segura encontrada estava nos materiais de fauna R2 e R3: ambos tinham a mesma função visual de baixa especularidade.

| Alteração | Efeito | Validação |
|---|---|---|
| Material de cervos R2/R3 unificado | Um recurso `StandardMaterial3D` partilhado, cor `0.24/0.16/0.095`, rugosidade `0.96`, metálico `0` | `road_to_arch` — 36 s, 9/9 grounding |
| Material de cervos R2/R3 unificado | Elimina duplicação de recurso sem mudar a geometria ou o aspecto pretendido | `arch_to_forest` — 36 s, 8/8 grounding |

Não foram encontradas unificações materiais adicionais que fossem simultaneamente locais à frente Dev6, de baixo risco e visualmente neutras. Não foram alterados terreno, rotas, câmaras, luzes ou colisores. O resultado visual dos corredores mantém o estado `REJECTED_VISUAL` até às recapturas de terceira pessoa.
