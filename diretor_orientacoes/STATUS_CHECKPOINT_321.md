# STATUS CHECKPOINT 321 — Prioridade de câmara e limpeza de prólogo

**Frente:** Dev1 — Regiões 1–6 / Takes 1–11.

O checkpoint garantiu que a câmara de prólogo chama `make_current()` e desactiva explicitamente a câmara de Elias durante a abertura. O handoff existente volta a activar a câmara de Elias quando o prólogo termina. A alteração foi testada em runtime, por validação Godot 4.7.1 e por uma execução de 30 segundos sem erros GDScript.

A limpeza dos emissores técnicos foi reforçada durante os 35 segundos do prólogo. Os pontos residuais ainda vistos na captura de compatibilidade não responderam aos filtros de nome, material, luz ou partículas e foram encaminhados ao CP 322 como auditoria de composição/activos, em vez de ocultar indiscriminadamente geometria real.

O **CP 322** está em execução para distinguir referências técnicas de pequenos elementos reais de bacia e corrigir apenas fontes comprovadas, mantendo a tomada CP 317 como base macro parcial.
