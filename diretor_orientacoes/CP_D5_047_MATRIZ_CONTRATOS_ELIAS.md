# CP-D5-047 — Matriz de contratos da apresentação de Elias

## Finalidade

Esta ficha consolida os contratos técnicos que qualquer harness Dev5 deve respeitar ao apresentar Elias em terceira pessoa. O documento é uma base de revisão para Dev1; não promove a apresentação ao jogador principal e não autoriza alterações em `Player.gd`.

| Domínio | Contrato obrigatório | Evidência actual | Critério de aceitação |
|---|---|---|---|
| Câmara | A câmara de Elias permanece inactiva quando existe câmara QA externa | `EliasCameraContractPreview`, R6 e R5 | Uma única câmara de viewport activa; `follow_camera.current=false` |
| Apresentação | Usar `EliasThirdPersonPresentation` através de referência tipada | Auditoria CP-D5-046 | A instância não depende de procura por nome mutável |
| Colisão QA | Actor e marcos usam colisores próprios, sem alterar colisores de produção | Previews R5/R6 | Sem bloqueio indevido e sem referência a módulos regionais |
| Trajecto | O actor percorre o corredor QA central e reinicia após o fim | R6 e R5 | Pelo menos dois ciclos completos com `clear=true` |
| Grounding | A baliza conserva X/Z canónico e resolve apenas Y por raycast | R6 monólito e preview de folga | `grounded=true`, X/Z preservados e colisor QA identificado |
| Folga | O trajecto respeita a distância mínima entre Elias e a baliza | R6 | `6,05 m` observados contra `4,00 m` mínimos |
| Performance | Harness usa no máximo a luz direccional própria e não cria luzes do actor | Auditoria CP-D5-040 | Zero luzes dinâmicas adicionadas pela apresentação |
| Isolamento | Não carregar ou modificar `Player.gd`, regiões R1–R6 ou câmaras de produção | Auditoria CP-D5-044 | Zero referências operacionais e zero alterações fora da fronteira Dev5 |

## Aceitação e reversão

O contrato é aceite quando o parser Compatibility passa, cada harness relevante mantém uma sessão de 36 segundos sem erros, a câmara QA permanece proprietária da viewport e os invariantes de grounding, colisão e trajecto são registados. Uma falha em qualquer critério mantém Elias como proxy QA e impede a integração.

A reversão consiste em remover apenas o preview ou a alteração em `entities/player/third_person/` que falhou, restaurando o último commit Dev5 aprovado. É proibida a correcção directa em `Player.gd` ou em módulos regionais como forma de contornar um teste vermelho.

> **Proprietário de produção:** Dev1 mantém a decisão sobre `Player.gd`, câmaras de produção e integração regional. Dev5 fornece apenas contratos e provas autónomas.

## Próxima tarefa

Ao publicar esta matriz, activar CP-D5-048 no mesmo ciclo para a próxima validação QA permitida.
