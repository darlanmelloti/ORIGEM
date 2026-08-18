# CP-CARTO-48 — Diagnóstico Alfa dos Fetos da Bacia

**Estado:** **REJEITADO E REVERTIDO**  
**Escopo testado:** fetos pontuais da entrada, aproximação e miradouros da Região 6.  
**Fronteira:** não foram alteradas rota física, lajes, água, estela, luzes, combate ou Regiões 7–12.

## Hipótese testada

Os pequenos elementos claros na tomada de chegada às Ruínas poderiam ser folhas com transparência alfa interpretada de forma incorrecta pelo renderizador OpenGL. As texturas PBR do activo `fern_02` existem e o teste aplicou apenas aos fetos R6: corte alfa, dupla face, tom vegetal, rugosidade alta e emissão desligada.

## Evidência

| Critério | Resultado |
| --- | --- |
| Texturas PBR do feto | **Presentes**: difusa, normal e ARM 1K |
| Godot 4.7.1 headless | **Aprovado** |
| Gameplay real | **30 segundos aprovados** |
| Captura 1600×900 | `/home/ubuntu/qa_evidence_voss_vista/cp_carto48_fern_alpha_1600x900.png` |
| Props claros | **Persistiram inalterados** |
| Decisão | **Reverter integralmente** |

## Conclusão operacional

Os props claros **não** provêm do material alfa dos fetos R6. A função de teste foi removida e não deixou alteração de runtime. O CP-CARTO-45 mantém-se aberto, mas fica proibido repetir tonalização ou corte alfa de fetos sem uma nova prova causal por nó e coordenada.
