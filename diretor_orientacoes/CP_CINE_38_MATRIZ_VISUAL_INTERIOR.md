# CP-CINE-38 — Matriz Visual de Interior Orion

A referência analisada confirma quatro princípios transferíveis para Orion: a passagem apresenta uma abertura irregular, o piso tem gradiente de luz distinguível, a massa rochosa lateral funciona como silhueta e o fundo escuro sugere continuidade sem revelar o destino. Interface, personagem e elementos específicos da referência não serão usados.

| Dimensão | Aplicação Orion | Limite técnico |
|---|---|---|
| Luz | Uma única fonte âmbar lateral baixa, apontada para o piso inicial | Uma `OmniLight3D`, sem sombras, para respeitar o orçamento GTX 1050 Ti |
| Material | Pedra PBR escura com variação de roughness e normal | Reutilizar material de rocha existente; não criar luz Chronos |
| Silhueta | Paredes convergem para uma curva lateral, nunca um arco simétrico liso | Malha contínua com fundo selado |
| Profundidade | Piso mais quente no primeiro plano e fundo menos iluminado | Sem neblina densa, sem céu e sem painel distante |
| Enquadramento | Câmara baixa a 1,55 m, dirigida ao desvio lateral após 6–9 m | Não alterar a câmara normal nem a abertura Casa Voss |

O CP-CINE-39 aplicará apenas estes parâmetros à próxima amostra de malha contínua. A amostra continuará sem Cube, altar, efeitos Chronos ou conteúdo de história.
