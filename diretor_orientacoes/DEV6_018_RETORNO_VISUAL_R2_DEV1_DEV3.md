# DEV6-018 — Retorno Visual R2 para Dev1 e Dev3

## Estado do candidato R2

A integração R2 já passou os contratos que pertencem à arte técnica: parser Godot, rota de 36 segundos, isolamento R1–R6, 9/9 grounding, X/Z preservado, LOD limitado, zero luzes incrementais, materiais e evidências com hash. A decisão visual permanece `REJECTED_VISUAL` por duas condições que pertencem à leitura de gameplay/cinemática.

| Critério pendente | Proprietário | Condição exacta de retorno |
|---|---|---|
| Perspectiva de terceira pessoa | Dev1 | Elias deve estar visível durante a rota `road_to_arch`, sem a arma dominar o quadro |
| Composição cartográfica | Dev3 | Estrada, Arco em z≈92 e planos laterais devem ser legíveis num mesmo enquadramento |

## Prova de retorno obrigatória

Após integrar a câmara, publicar uma sessão `road_to_arch` de 36 segundos com PNG 1920×1080 e log. Dev6 aplicará de imediato os controlos técnicos da baseline DEV6-017 e a matriz DEV6-014. Não é necessário alterar os activos, o terreno, a rota, o jogador ou as Regiões 7–12 para devolver esta prova.

> A inexistência temporária dessa câmara não bloqueia Dev6. O próximo ciclo técnico permanece activo e continuará por auditorias reversíveis até a nova evidência chegar.
