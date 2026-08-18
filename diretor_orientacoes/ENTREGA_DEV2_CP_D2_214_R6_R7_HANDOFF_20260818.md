# Entrega Dev2 — CP-D2-214: Handoff R6→R7

## Situação observada

A margem ocidental das **Ruínas Submersas** foi estabilizada no bloco Dev1: soleira natural, rota única Floresta→Margem→Ruínas, estela de chegada lateral e prova bidireccional aprovada. A primeira subida para a **Região 7 — Vila Elevada** continua sem geometria Dev2 publicada na branch remota; a ponta disponível permanece anterior a CP-D2-214.

## Proprietário e fronteira

| Proprietário | Entrega permitida |
| --- | --- |
| Dev1 | Preserva a margem R6, âncora R6 e harness de continuidade; não altera R7. |
| Dev2 | Constrói a subida R7, a primeira leitura da Vila Elevada e o próximo marco sem alterar R1–R6. |
| Dev4 | Faz QA integrado, orçamento GTX 1050 Ti, captura e devolução de lacunas; não cria auditoria autónoma. |

## Implementação CP-D2-214

A Região 7 deve começar no prolongamento físico natural da margem R6, com uma subida oblíqua apoiada no relevo. A composição obrigatória deve conservar três planos: a trilha de subida no primeiro plano, a entrada real da Vila Elevada no plano médio e o próximo marco no plano posterior. Não usar placa, portal vazio, parede de vegetação, marcador de QA ou encurtamento artificial da distância cartográfica.

O Observatório não pode dominar o enquadramento da primeira chegada. A boca da Caverna Orion também não deve competir neste momento; pertence ao percurso posterior R9→R10.

## Evidência obrigatória

1. Parser Godot 4.7.1 sem erros.
2. Scope guard confirmando alteração exclusiva R7–R12.
3. Gameplay integrado de 30 segundos a partir da margem R6.
4. Captura 1600×900 sem UI QA e sem splash.
5. Inventário de luzes e colisores; manter no máximo 16 luzes dinâmicas visíveis.
6. Commit local preservado por referência de segurança antes de qualquer integração remota.

## Aceitação visual

A entrega é aceite apenas quando o jogador identifica a subida R7 como continuação natural das Ruínas, vê a Vila Elevada como destino próximo e mantém a bacia R6 como ponto de origem ao olhar para trás.

## Próxima fila automática

Depois de publicar CP-D2-214, Dev4 executa a `CHECKLIST_R6_R7_DEV4_CP_D2_214.md`. Se a transição falhar, a primeira lacuna observável é devolvida imediatamente ao Dev2; se passar, abre-se a validação R7→R8.
