# STATUS CHECKPOINT 358 — Dev5 R5: auditoria visual da leitura de vento

**Data:** 2026-08-26
**Região:** R5 — Acampamento Majestic
**Tarefa concluída:** `DEV5-R5-CAMP-WIND-READING-003`

## Evidência visual e técnica

A auditoria foi executada localmente em janela 16:9 de 1280×720, usando um spawn QA exclusivamente técnico junto ao Acampamento Majestic. O helper só responde a `ORIGEM_QA_R5_CAMP_VISUAL`; não altera o fluxo de jogo, rotas, luzes, colisões, navegação ou a câmara normal.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | Aprovado |
| Captura 16:9 | Sessão carregada sem erro; acampamento, tendas, lonas, mastros e suporte de expedição visíveis |
| Variação temporal | 5.469 píxeis alterados entre os frames 01–02 e 18.906 entre os frames 02–03; alteração discreta e mensurável |
| Enquadramento | Estável nos três frames; sem deslocação de câmara ou geometria global |
| Gate R5 | Aprovado com artefacto, leitura de vento, orçamento e rotas `forest_to_majestic` e `majestic_to_lake` |
| Navegação | Corredor de chegada permaneceu visível e livre nas capturas de aproximação e do acampamento |

As imagens e notas de captura permanecem em `reports/r5/captures/` como evidência local do teste. O analisador `tools/qa/analyze_r5_wind_frames.py` permite repetir a medição de diferenças entre frames sem qualquer dependência externa.

## Sucessão

O contrato Dev5 deve avançar para `DEV5-R5-CAMP-ARRIVAL-READING-004`, limitado a uma leitura ambiental estática da chegada ao acampamento. A próxima entrega não pode criar luz, geometria, física, partículas, shader, interface, câmera ou alteração de rota; deve reutilizar detalhes R5 existentes e preservar o conector R4→R5 e a passagem R5→R6.
