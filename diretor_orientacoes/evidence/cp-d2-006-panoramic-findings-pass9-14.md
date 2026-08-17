# CP-D2-006 — Findings Visuais Passes 9–14

## Estado

`STATUS_CODE: REJECTED_VISUAL`. O QA técnico continua verde, mas os prints não cumprem o critério cinematográfico de revelar Vila Elevada, Observatório e início da Trilha da Montanha como volumes reconhecíveis.

## Observações

| Passe | Observação principal |
|---|---|
| pass9 | A câmara mostra o contraforte e massas rochosas, mas a plataforma escura domina a metade inferior e os marcos parecem separados. |
| pass10 | O encadeamento de rochas aumenta o volume de primeiro plano, mas a cena continua sem leitura arquitectónica. |
| pass11 | O activo de ponte é visível como uma massa horizontal demasiado plana; não resolve a hierarquia dos marcos. |
| pass12-real | HighlandRegion real aparece, mas a câmara está alta/distante e os elementos 7–9 ficam reduzidos a pequenos pontos sobre o terreno. |
| pass13-real | A câmara baixa revela mais terreno, mas ainda não enquadra a vila; a escala dos marcos permanece insuficiente. |
| pass14-real | O enquadramento aprovado da entrada ainda fica ocluído pelo relevo; há folhagem/malha em primeiro plano e nenhum volume de vila/observatório legível. |

## Próxima acção imediata

Não empacotar como `PASSED`. O próximo passe deve usar um ponto de câmara acima do relevo, mas muito mais próximo do nó `VilaElevada`, e validar a posição real dos filhos após `_ready()`. A prioridade é obter primeiro uma composição aceitável da Região 7 com o observatório no fundo; só depois estender a trajectória até à Região 9.
