# CP-D5-291 — Regressão do corredor do Arco R3

## Resultado

A cena `levels/dev5/EliasArchCorridorPreview.tscn` carregou o script Dev5 corretamente e passou parser. A execução headless foi mantida durante a sessão QA de 36 segundos; o timeout controlado (`QA_EXIT=124`) encerrou o processo persistente, sem erro de script ou parse.

A verificação do contrato em `_ready()` registou:

```text
[DEV5_R3_CORRIDOR] r3_xz=(-16.741,48.00) physical_arch_z=92.00 next=RUMO À FLORESTA id=4 elias_camera_current=false structural_arch=false route_open=true grounded=true production_modules_changed=false
```

| Critério | Resultado |
|---|---|
| Elias em apresentação terceira pessoa | `true`; câmara de seguimento não activa |
| Câmara QA única | `true`; câmara de viewport distinta da câmara de Elias |
| Arco físico R3 | `z=92.00` |
| Próximo destino | `RUMO À FLORESTA`, anchor `id=4` |
| Rota | aberta |
| Aterramento | confirmado no plano QA |
| Arco estrutural | não recriado |
| Módulos de produção | não modificados |
| Parser | `PARSER_EXIT=0` |
| QA | 36 s, timeout controlado `QA_EXIT=124` |

Os avisos `FSR1 is only available when using the Forward+ renderer` são específicos do renderer OpenGL Compatibility headless e não representam falha do contrato Dev5. Evidência completa: `CP-D5-291_ARCH_CORRIDOR_RUNTIME.log`.
