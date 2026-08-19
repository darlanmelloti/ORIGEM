# DEV6-010 — Orçamento Técnico R2

A auditoria considera apenas a camada adicionada por Dev6 ao corredor da Estrada do Rio. A cena principal pode ter outros conteúdos regionais, mas o incremento R2 não adiciona luzes e mantém uma densidade de instâncias limitada.

| Categoria Dev6 R2 | Quantidade | Impacto esperado |
|---|---:|---|
| Ponte modular | 1 | Geometria estática lateral; sem luzes |
| Cervos CC0 | 2 | Visibilidade até 42 m |
| Vegetação adicional | 4 | 2 árvores até 58 m e 2 fetos até 34 m |
| Vestígios de abrigo | 2 | Rocha estática, sem colisores extra |
| Afloramentos de escala | 4 | Rocha estática fora da rota |
| Vestígios de escala | 3 | Silhueta de plano médio, sem colisores |
| Faixas de solo | 6 | Malhas rasas sem sombra e sem colisores |
| Materiais adicionais | 2 | Fauna rugosa e solo lateral; reutilização dos materiais PBR existentes nas rochas |
| Luzes dinâmicas incrementais | 0 | Dentro do orçamento GTX 1050 Ti |

O incremento permanece compatível com o limite de 16 luzes dinâmicas, pois não adiciona qualquer `Light3D`. As distâncias LOD limitam os activos de fauna e vegetação no plano médio. A próxima tarefa deve verificar apenas a contagem de materiais distintos e documentar a recaptura de terceira pessoa quando estiver disponível, sem repetir alterações visuais rejeitadas.
