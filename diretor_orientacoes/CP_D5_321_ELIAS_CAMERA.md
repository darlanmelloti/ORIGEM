# CP-D5-321 — Regressão da câmara de Elias

A cena `EliasThirdPersonPreview.tscn` passou parser (`PARSER_EXIT=0`) e sessão QA headless de 36 segundos (`QA_EXIT=124`, timeout controlado). A telemetria confirmou `active_camera=/root/EliasThirdPersonPreview/CameraQA`, mantendo uma única câmara QA activa.

Não foram observados erros de parser ou script. A apresentação técnica permanece isolada e não altera `Player.gd` nem módulos de produção. Os avisos FSR1 são específicos do renderer OpenGL Compatibility headless. Evidência completa: `CP-D5-321_RUNTIME.log`.
