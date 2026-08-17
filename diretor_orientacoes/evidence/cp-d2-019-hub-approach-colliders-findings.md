# CP-D2-019 — Avaliação visual pass1

Os colliders invisíveis foram adicionados sob os três degraus centrais, alinhados com `z=171.12`, `170.38` e `169.40`, sem introduzir geometria de greybox nem alterar o enquadramento. O QA passou em Godot 4.7.1, com gameplay de 30 segundos e print 1600×900.

A captura mantém a leitura da soleira, da base e da Cúpula. A continuidade física está agora representada no harness; o próximo ciclo pode validar a travessia integrada com o Cube e a saída para o Hub.

**Estado:** `PASSED_TECHNICAL / PASSED_VISUAL_CONTINUITY_COLLIDERS_READY`.

Hashes: gameplay `37b088ad403f7efb72e27d92782998600d8fb0be423e8d44f2546601c981cd5e`; print `2826a0656799146ea3cb98e6a26ada2cde6e5a76431e64bdef2bf555537a2655`.

**Próxima acção imediata:** empacotar CP-D2-019, sincronizar o incremento e iniciar a validação integrada Cube → soleira → Hub.
