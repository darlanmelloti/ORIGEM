# CP 323 — Controlo de ambiente da abertura

A abertura diurna era vulnerável à reposição pelo sistema Chronos, pois `apply_voss_daylight()` libertava imediatamente o bloqueio de perfil. Foi introduzido `apply_voss_opening_daylight()`, que mantém a variante diurna activa durante o prólogo e devolve o controlo ao fluxo normal por `restore_timeline_environment()`.

A captura de compatibilidade confirma que o perfil permanece estável, mas **não revela ganho luminoso suficiente** para justificar aceitar a calibração atmosférica anterior; essa calibração foi revertida. O próximo passe deve concentrar-se na materialidade do solo/vegetação e na exposição da câmara efectiva, não em mais nevoeiro ou luzes.

> A base diurna bloqueada é uma correcção de controlo válida. Não é, por si só, uma aprovação da composição de 12 marcos.
