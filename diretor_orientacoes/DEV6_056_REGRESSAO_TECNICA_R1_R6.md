# DEV6-056 — Regressão Técnica Integrada R1→R6

A regressão foi executada no projecto de produção com **Godot 4.7.1** e `gl_compatibility`. O parser passou antes das sessões. Cada corredor realizou uma sessão de gameplay real de 36 segundos e produziu log, captura intermédia e hash no manifesto externo `/home/ubuntu/qa_evidence_dev6_regression_r1_r6/session_manifest.txt`.

| Região | Rota | Duração | Grounding | Restrições preservadas | Resultado técnico |
|---|---|---:|---:|---|---|
| R1 | retorno Casa Voss | 36 s | 7/7 | Casa, porta, Elias e câmara sem alteração; 0 luzes Dev6 | `PASS` |
| R2 | Estrada do Rio → Arco | 36 s | 9/9 | X/Z preservado; ponte lateral; 0 luzes Dev6 | `PASS` |
| R3 | Arco → Floresta | 36 s | 8/8 | Sem arco estrutural; 0 luzes Dev6 | `PASS` |
| R4 | Floresta → Majestic | 36 s | 6/6 | Sem portal estrutural; 0 luzes Dev6 | `PASS` |
| R6 | Majestic → Ruínas | 36 s | 6/6 | Sem cais de lajes; 0 luzes Dev6 | `PASS` |

O manifesto desta execução contém logs, capturas e hashes por rota. A regressão confirma que as integrações reversíveis se mantêm tecnicamente estáveis depois dos passes de LOD e unificação material.

> A aceitação visual não é inferida a partir deste resultado. Sem uma recaptura de terceira pessoa que enquadre Elias, corredor, candidato Dev6 e marco seguinte, os cinco corredores permanecem `REJECTED_VISUAL` para promoção cinematográfica.
