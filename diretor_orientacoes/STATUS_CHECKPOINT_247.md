# CP 247 — Auditoria Física do Handoff para Vila Elevada

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Região 6 e limite de integração com a Região 7.

## Verificação de abertura

O portão mantém dois colisores de pilar de `0,92 m` eixos, colocados a `X=136,8` e `X=143,2`. A abertura entre as faces é de **5,48 m**. Considerando o raio de colisão de Elias, de `0,35 m`, permanece uma largura útil de **4,78 m** no eixo central `X=140`, o que excede amplamente a passagem necessária.

O trilho Dev1 contém doze lajes baixas com colisores, a cada `5,00 m`, e conduz até `Z=348`, antes do handoff de Vila Elevada em `Z=352`.

## Evidência de runtime

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração normal | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Abertura geométrica do portão | 5,48 m |
| Largura útil para Elias | 4,78 m |

A prova gráfica de aproximação directa chegou a carregar o mundo, mas o binário Godot interrompeu a captura llvmpipe com `invalid opcode`, sem mensagens GDScript. Esta limitação do renderizador de validação não afecta a validação headless, o fluxo Novo Jogo nem o cálculo físico determinístico da passagem.

## Próximo incremento autónomo

**CP 248 — Passe de continuidade cartográfica final Dev1.** O próximo ciclo revisará os sinais visuais da rota Casa Voss → Estrada → Arco → Floresta → Acampamento → Ruínas → portão, sem alterar módulos das Regiões 7–12.
