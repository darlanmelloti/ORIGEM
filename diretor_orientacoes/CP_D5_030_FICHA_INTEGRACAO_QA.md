# CP-D5-030 — Ficha consolidada de integração QA Dev5

## Objectivo

Esta ficha consolida o estado dos candidatos Dev5 sem autorizar integração automática. Ela serve como contrato de passagem entre QA e revisão Dev1, mantendo os candidatos isolados até existir evidência visual válida e aprovação explícita.

| Candidato | Marco | Estado técnico | Estado visual | Integração |
|---|---:|---|---|---|
| Casa Voss aterrada | 1 | Aprovado: placement, raycast Y, contacto e X/Z | QA interno aprovado | Não integrada; revisão Dev1 necessária |
| Ponte Marco 2 aterrada | 2 | Aprovado: placement, raycast Y, contacto e X/Z | QA interno aprovado | Não integrada; revisão Dev1 necessária |
| Portal Floresta Densa | 4 | Aprovado em runtime e escopo | Pendente: viewport gráfico válido | Não promover |
| Vegetação média | 4/5 | Aprovado: limites LOD e composição irregular | QA técnico | Não integrada; revisão Dev1 necessária |
| Pavilhão Majestic | 5 | Aprovado em QA técnico | QA interno | Não integrada; revisão Dev1 necessária |
| Ruínas Submersas | 6 | Aprovado em runtime, água não emissiva e zero luzes do objecto | Pendente: viewport gráfico válido | Não promover |

## Contratos obrigatórios

Todo candidato deve manter a âncora cartográfica canónica, deslocamento local dentro de 36 m, X/Z preservado e Y resolvido apenas por aterramento quando houver terreno físico. Colisores devem ser próprios e limitados à travessia ou aos elementos laterais. Os objectos não podem criar luzes dinâmicas novas nem instanciar `ForestLakeRegion.gd`, `TempleLevel.gd` ou `Player.gd`.

A captura visual deve ocorrer num viewport gráfico Godot 4.7.1 Compatibility. O modo headless continua válido para parser e sessões de 36 segundos, mas não pode servir como prova visual quando `Image`/viewport for nula. A ausência de captura não é uma aprovação nem uma rejeição.

## Critério de promoção

A promoção exige simultaneamente evidência técnica, captura visual legível, ausência de regressão de escopo e revisão Dev1. Até lá, os activos permanecem candidatos QA em `levels/dev5/` e a fila pode continuar com auditorias não concorrentes ou melhorias de fundação.

## Próxima acção

Após publicar esta ficha, abrir o CP-D5-031 para a próxima auditoria/ficha QA permitida, mantendo R4/R6 pendentes de viewport gráfico válido.
