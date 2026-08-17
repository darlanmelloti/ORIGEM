# CP-CINE-23B — Correcção da Boca Orion

A captura de aproximação sul revelou duas falhas que não eram visíveis no enquadramento anterior: um recesso esférico preto de escala artificial e contrafortes que, por usarem uma elevação fixa e um activo incompatível, pareciam suportes suspensos. Ambos violavam a regra do projecto contra fundos, painéis e geometria que não se integra no terreno.

A correcção removeu completamente o recesso esférico. Os contrafortes passaram a usar `stone_largeA.glb`, já aplicado no Vale de Kheper, e recebem uma coordenada vertical calculada com `height_at` no ponto mundial de cada instância. Não existe mais uma altura fixa de 2,4 m.

| Critério | Antes | Depois |
|---|---|---|
| Fundo da boca | Esfera preta artificial | Removida |
| Contrafortes | Activo incompatível e elevado por constante | Rochas do vale aterradas ao terreno |
| Cubo Chronos | Mantido oculto no exterior | Mantido oculto no exterior |
| Escala cartográfica | Sem alteração | Preservada |

A captura actual confirma que a esfera e os suportes desapareceram. A boca passa a requerer uma solução de silhueta baseada no próprio relevo, não mais activos de rocha de baixo impacto. **CP-CINE-24 já está iniciado** para medir a crista e o recorte do terreno antes de qualquer nova adição.
