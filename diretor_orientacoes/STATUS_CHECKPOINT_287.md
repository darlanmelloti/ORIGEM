# Estado do Checkpoint 287 — Reenquadramento do Miradouro Leste

O **CP 287** desloca a tomada de abertura para o bordo leste físico do miradouro da Casa Voss. A alteração diminui o desvio angular entre a lente e a ponte transversal, reforçando simultaneamente a leitura do rio, das margens, das lajes da Estrada e do Arco no plano médio.

| Verificação | Resultado |
|---|---|
| Godot headless | Aprovado, sem erros de parser, scripts ou recursos |
| Captura 16:9 | Actualizada em `qa_evidence_voss_vista/cp274_opening_macro/revelacao_casa_estrada_arco.png` |
| Gameplay real | Prova segmentada de 30 segundos aprovada |
| Navegação | Nenhuma alteração nos colisores, lajes ou rota de Elias |
| Escopo | Apenas `VossHouse.gd`, dentro das Regiões 1–3 Dev1 |

O enquadramento melhora a presença de rio, ponte e Arco, mas ainda não cumpre a composição integral de 12 marcos exigida pela matriz. O próximo passe não está bloqueado nem encerra a tarefa: deve tratar a moldura da Casa e a cadeia de planos do vale sem reduzir a escala ou recorrer a fundos artificiais.

> **CP 288 em execução:** integração da moldura física da Casa Voss no bordo da tomada e continuidade visual Casa → rio/ponte → Estrada → Arco.

**Estado:** `VALIDADO TECNICAMENTE; CP 288 EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.
