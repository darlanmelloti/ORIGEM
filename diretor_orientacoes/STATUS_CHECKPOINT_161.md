# ORIGEM — Checkpoint 161: Auditoria de Orçamento Técnico das Regiões 1–6

**Branch:** `feature/dev1-gameplay-core`

**Escopo auditado:** Regiões 1–6 e Takes 1–11 exclusivamente.

## Resultado da auditoria

Foi executada uma auditoria estática dos módulos regionais após o Checkpoint 160. A análise confirmou que a legibilidade visual atual é obtida sem sombras de OmniLight3D, deixando apenas a luz direcional global com sombras. As luzes locais de percurso, Acampamento Majestic, margem e Ruínas Submersas usam sombras desativadas, uma salvaguarda importante para a GTX 1050 Ti. Não foi aplicada redução adicional: as luzes de grande alcance suportam a leitura do lago e do acampamento no modo de compatibilidade, e a eliminação delas prejudicaria o objetivo visual validado.

| Indicador | Resultado | Decisão |
|---|---:|---|
| Construções procedurais de `OmniLight3D` nas Regiões 1–6 | 31 | Mantidas; todas usadas como preenchimento ou orientação regional. |
| OmniLights com sombra ativa | 0 | Preservado como salvaguarda de desempenho. |
| Sombras ativas em módulo regional | Apenas a DirectionalLight3D do ambiente | Mantida para definir relevo e silhueta. |
| Construções procedurais de `StaticBody3D` | 31 | Mantidas apenas em lajes, tendas, pilares, pedras e troncos físicos. |
| Colisores criados proceduralmente | 32 | Mantidos para garantir travessia e interação física. |
| Loops de maior densidade | Árvores, fetos, margem rochosa e lajes | Mantidos por já possuírem distribuição determinística e sem sombras Omni. |

## Validação obrigatória

| Verificação | Resultado |
|---|---|
| Editor Godot 4.7.1 headless | Aprovado sem `Parse Error`. |
| Prólogo, porta [E] e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Alterações nas Regiões 7–12 / Takes 12–22 | Nenhuma. |

> Não houve alteração de código neste checkpoint: a auditoria confirmou que a configuração atual mantém as sombras de OmniLight desativadas e preserva o equilíbrio entre leitura visual e orçamento técnico da GTX 1050 Ti.
