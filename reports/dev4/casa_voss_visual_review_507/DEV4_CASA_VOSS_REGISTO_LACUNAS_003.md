# ORIGEM — Dev4 #507: Registo de Lacunas Casa Voss

**Etapa:** 003 — `BASELINE_EM_PREPARAÇÃO`
**Rota:** `voss_to_road` e `voss_lateral`
**Viewport:** 1600×900 em todas as quatro vistas
**Produção:** sem mutação em R1, R4 ou R6

## Capturas realizadas

| Vista | Ficheiro | Observado | Diferença frente ao vídeo de referência | Restrição para Dev1 | Critério de aceite |
|---|---|---|---|---|---|
| Soleira/fachada | `01_soleira_fachada.png` | Enquadramento lateral do terreno e da abertura de saída; a fachada Casa Voss não fica claramente visível nesta posição QA. | O vídeo mostra a fachada rústica em pedra/madeira como âncora forte no lado esquerdo. | Não inferir defeito da fachada; qualquer hipótese deve explicar primeiro a posição de câmara e o ponto de spawn. Não alterar fachada, asset ou câmara. | A fachada é reconhecível como âncora lateral numa captura aprovada, sem bloquear a descida. |
| Primeira descida | `02_primeira_descida.png` | Descida de lajes claramente legível no centro, com prado aberto e marcador distante; a casa já está fora do enquadramento principal. | No vídeo, a transição inicia mais próxima do patamar da casa e a escadaria integrada tem maior verticalidade. | Preservar o eixo físico e não inserir elementos no corredor; registar a diferença como lacuna de composição/câmara, não como licença de geometria. | Primeiro segmento de descida identificável, contínuo e livre de oclusão concorrente. |
| Vale/ponte/arco | `03_vale_ponte_arco.png` | Vale aberto, lajes centrais, árvore focal e arco/estrutura no plano distante; o vale lê-se como espaço amplo. | O vídeo apresenta mais densidade de ruínas, pontes, rio e vegetação em camadas. | Não criar ou mover ruínas, ponte, arco, vegetação ou água; manter os elementos laterais fora do eixo. | Vale e marco arquitectónico distantes legíveis sem formar parede visual ou rota falsa. |
| Horizonte Orion | `04_horizonte_orion.png` | Horizonte de relevo baixo, céu dominante e marcador arquitectónico distante; a montanha focal e luz azul de Orion não são comprovadas nesta vista. | O vídeo fecha a progressão num pico montanhoso destacado com foco luminoso azul. | Não alterar luz, horizonte, água, material, pós-processamento ou câmara; marcar ausência como não conclusiva. | Horizonte contínuo e destino distante legível; qualquer validação de Orion requer evidência específica. |

## Resultado de cobertura

As quatro imagens são válidas como **baseline técnico 16:9**, com resolução confirmada de 1600×900 e rota/spawn registados pelo capturador canónico. A cobertura é suficiente para avaliar eixo, oclusão e relação entre primeiro plano, vale e horizonte. Não é suficiente para declarar correspondência visual completa com o vídeo: a soleira/fachada não está claramente enquadrada, a descida não reproduz a verticalidade do vídeo, a densidade do vale é menor e Orion não surge como foco montanhoso azul comprovado.

## Aceite/rejeição

| Item | Estado |
|---|---|
| Quatro PNG em 16:9 | **ACEITE técnico de baseline** |
| Soleira/fachada visível de forma conclusiva | **REJEITADO / lacuna de evidência** |
| Primeira descida legível | **ACEITE parcial** |
| Vale e marco distante legíveis | **ACEITE parcial** |
| Ponte/arco comparáveis ao vídeo | **INCONCLUSIVO** |
| Horizonte Orion comparável ao vídeo | **INCONCLUSIVO** |
| Autorização para alterar produção | **REJEITADO** |

O próximo passo da sequência é o Dev1 produzir uma hipótese espacial. Quando essa hipótese/captura existir, o Dev4 aplicará esta matriz e classificará cada vista como aceite, rejeição ou inconclusiva. Esta etapa não autoriza nova produção, variante cosmética, alteração de rota, câmara, material, luz, água, física ou assets.
