# ORIGEM — Checkpoint 166: Fluxo Normal da Porta da Casa Voss

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit de prova:** `0b085bf` — `test(voss): add robust prologue and door flow proof`.

## Resultado validado

Foi adicionada uma prova de gameplay reproduzível que respeita o carregamento mais lento do renderizador de compatibilidade. O roteiro mantém a tecla **E** durante a janela de ativação tardia do prólogo, confirma a devolução de controlo e aciona novamente **E** no limiar físico para abrir os dois painéis da Casa Voss. A captura final exibe a porta aberta, o percurso de lajes e a mensagem de confirmação de que o exterior está livre.

| Verificação | Evidência | Resultado |
|---|---|---|
| Salto do prólogo | `qa_scripts/test_checkpoint166_voss_threshold.sh` | Aprovado: o aviso de salto deixa de estar ativo antes da captura. |
| Porta [E] | Captura 1280×720 | Aprovado: os painéis estão abertos e a mensagem confirma o caminho livre. |
| Fundação do jogo | Prólogo, porta e exterior | Gameplay automatizado de 30 segundos aprovado. |
| Travessia regional | Acampamento Majestic → Ruínas Submersas | Gameplay automatizado de 30 segundos aprovado. |
| Fronteira operacional | Script de QA adicionado | Mantida: nenhuma alteração em Regiões 7–12. |

## Preservação

O pacote de recuperação reproduzível foi gerado em:

`/home/ubuntu/ORIGEM_V2_RegionalWorld_Phase166_VossDoorFlow_Validated.zip`

SHA-256:

`10a59af258bff4d557e57b3116017d48544468d3cb54e65212035c2e90ef8528`

## Artefactos

| Ficheiro | Finalidade |
|---|---|
| `qa_scripts/test_checkpoint166_voss_threshold.sh` | Roteiro robusto de salto de prólogo e porta [E]. |
| `/home/ubuntu/origem_v2_phase166_voss_threshold.png` | Captura do limiar aberto e da confirmação de saída. |
| `/home/ubuntu/origem_v2_phase126_majestic_to_lake_30s.png` | Evidência de continuidade física até ao lago. |

> O checkpoint é uma evidência, não uma pausa. O desenvolvimento contínuo mantém-se exclusivo às Regiões 1–6.
