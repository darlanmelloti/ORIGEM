# Status Checkpoint 261 — Auditoria Integrada Casa Voss → Portão da Vila

## Resultado da auditoria

A auditoria confirmou que os marcos Dev1 continuam organizados pela cadeia cartográfica Casa Voss, Estrada do Rio, Arco das Ruínas, Floresta Densa, Acampamento Majestic, Ruínas Submersas e vista de handoff da Vila Elevada. Os incrementos CP256–CP260 mantêm soleira, ponte de revelação, bifurcação Majestic, limiar da Bacia e vestígios da vista de subida como geometria tridimensional separada dos módulos Dev2.

O harness legado referenciado pela auditoria dependia de scripts externos que deixaram de existir após a reposição do ambiente. Essa ausência foi tratada como falha de harness, não como bloqueio da produção. Foi criada uma prova de recuperação com arranque rápido, que inicia o movimento cedo para evitar o limite conhecido do llvmpipe e produz evidências aos 0, 15 e 30 segundos.

## Validação recuperada

| Verificação | Resultado | Evidência |
|---|---|---|
| Validação técnica anterior CP260 | Aprovada | `qa_evidence_voss_vista/cp260_handoff_headless.log` |
| Novo Jogo e movimento contínuo | Aprovado por 30 segundos | `qa_evidence_voss_vista/cp261_faststart_30s/resultado.txt` |
| Captura inicial | Gerada | `inicio_movimento.png` |
| Captura intermédia | Gerada aos 15 segundos | `metade_movimento.png` |
| Captura final | Gerada aos 30 segundos | `fim_30s_movimento.png` |

## Encaminhamento cinematográfico

A grelha Dev3 Passe 0B permanece uma lacuna activa; não é um encerramento. A ordem `ORDEM_DEV3_TAKES_1A3_E_RECAPTURA_0C.md` obriga a execução dos Takes 1–3 e da recaptura 0C com a lente-mestre inalterada. Os marcos 1–6 continuam sob Dev1; as silhuetas 7–12, sob Dev2.

## Próxima tarefa iniciada

**CP 262 — Reforço do primeiro quadro Casa Voss → Estrada → Arco:** concentrar o próximo passe Dev1 nos três marcos iniciais que o Take 0B classificou como ausentes, sem criar painéis, fundos falsos ou alterar Regiões 7–12.
