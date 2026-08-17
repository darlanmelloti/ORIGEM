# STATUS CHECKPOINT 313 — Captura cinematográfica limpa

**Frente:** Dev1 — Regiões 1–6 / Takes 1–11.

O CP 313 introduziu a variável de QA `ORIGEM_QA_CINEMATIC_CAPTURE=1`. Ela impede exclusivamente a criação da interface «Mantenha [E] para saltar o prólogo» durante capturas automáticas; o prólogo normal, o gesto de salto e a experiência do jogador permanecem inalterados.

A tomada limpa em `cp313_clean_cinematic.png` confirma a Casa Voss na margem esquerda, água e vegetação em plano intermédio, e ruína/Arco no horizonte, sem sobreposição de interface. A validação headless do Godot 4.7.1 e a execução gráfica de 30 segundos em `opengl3` concluíram sem erros GDScript.

A composição continua parcial face à matriz de 12 marcos. O **CP 314** fica iniciado para transformar a captura limpa numa evidência comparável para o Dev3 e isolar o próximo ganho de geometria de escala macro, sem reabrir as candidatas já rejeitadas de ponte, relevo ou moldura arquitectónica.
