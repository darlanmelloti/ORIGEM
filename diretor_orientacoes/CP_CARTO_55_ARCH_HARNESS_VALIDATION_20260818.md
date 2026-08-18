# CP-CARTO-55 — Validação do Harness Arco

## Diagnóstico causal

A tomada QA do estágio `arco` usava o alvo físico correcto em z=92, correspondente à âncora cartográfica z=48 depois da escala do corredor. A falha visual era distinta: a posição QA em `(-19, z=76)` intersectava uma copa próxima e preenchia o viewport com folhagem, invalidando a evidência.

## Correcção

Apenas o estágio QA `ORIGEM_QA_STORYBOARD_STAGE=arco` foi deslocado para `(-7.5, z=70)` e elevado ligeiramente. O FOV permanece em 60° e o alvo físico z=92 é preservado. O prólogo normal, a câmara de Elias, a geometria, a navegação, a escala cartográfica e as Regiões 7–12 não foram modificados.

## Validação

| Verificação | Resultado |
| --- | --- |
| Godot 4.7.1 headless | Aprovado |
| Tomada QA Arco | Aprovada — o arco aparece completo e sem intersecção de copa |
| Sessão real | 30 segundos sem erro de parser ou runtime |
| Captura | `qa_evidence_voss_vista/cp_carto55_arch_harness_1600x900.png` |
| Luzes e colisores | Sem alteração |

## Decisão

**Aceite para evidência QA.** Esta alteração melhora a qualidade e reprodutibilidade da auditoria sem modificar o mundo de produção. A lacuna macro Casa Voss→Estrada→Arco permanece uma questão de composição de produção a ser tratada somente quando uma nova evidência apontar um oclusor causal.
