# CP-D5-035 — Baliza monolítica aterrada na margem R6

**Escopo:** cena QA em `levels/dev5/`; não foram alterados `ForestLakeRegion.gd`, UI, rotas ou módulos das Regiões 1–6.

## Decisão de composição

A baliza utiliza uma só pedra alta irregular, duas rochas de base e terreno físico inclinado. Esta escolha é deliberadamente distinta do cais R6 rejeitado: não utiliza sequência de lajes cúbicas, colunas repetidas, plataforma navegável ou água artificial. Os afloramentos laterais inicialmente testados foram removidos da prova por não demonstrarem contacto visual inequívoco com o terreno QA.

| Critério | Resultado |
|---|---|
| Âncora | R6, com offset cartográfico `(-8, 8)` a partir de `(60, 252)` |
| Coordenadas efectivas | `(52, 260)` |
| Altura inicial / impacto | `18,00 m → -0,00 m` |
| Colisor de solo | `MargemR6ColisorQA` |
| X/Z preservado | Sim |
| Luzes dinâmicas criadas | 0 |
| Lajes de cais / colunas uniformes | 0 / 0 |
| Produção regional alterada | 0 |

O material de ruína foi ajustado para separar visualmente o monólito do solo, mantendo uma leitura pétrea mate. A câmara foi fechada sobre o candidato para confirmar silhueta e apoio das rochas de base.

## Validação

O parser Godot 4.7.1 passou. A cena completou 36 segundos de QA com captura interna válida, sem `SCRIPT ERROR`, `Parse Error` ou asserção. A telemetria registou `grounded=true`, `xz_preserved=true`, `pier_slabs=0` e `uniform_columns=0`.

**Estado:** aprovado como **candidato técnico QA**, não promovido a produção. Dev1 decide a promoção apenas após validar a leitura da margem no percurso real Majestic→Ruínas e executar 30 segundos de gameplay regional.

## Próxima tarefa automática

**CP-D5-036 — Contrato de segurança de passagem R6.** Criar uma ficha de risco para a eventual integração da baliza: distância mínima ao corredor, tipo de colisor permitido, teste de navegação e critérios de reversão. A tarefa permanece documental e não altera módulos de produção.
