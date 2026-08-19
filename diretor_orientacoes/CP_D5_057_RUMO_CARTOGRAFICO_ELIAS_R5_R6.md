# CP-D5-057 — Rumo cartográfico de Elias: R5 → R6

**Escopo:** harness QA isolado em `levels/dev5/`. Não modifica `CartographicMapUI.gd`, `TempleLevel.gd`, `Player.gd` ou módulos de produção R1–R12.

## Objectivo

Comprovar que a telemetria de orientação usa as âncoras X/Z canónicas para conduzir Elias do corredor posterior ao Majestic para as Ruínas Submersas, e que a chegada R6 só então libera a indicação cartográfica para a Vila Elevada.

| Fase | Posição / regra | Resultado |
|---|---|---|
| Início QA | Elias em `(-80,190)` | `RUMO ÀS RUÍNAS`, âncora 6 |
| Âncora R5 | Majestic `(-88,178)` | Mantida como desvio ocidental real |
| Âncora R6 | Ruínas `(60,252)` | Chegada física confirmada |
| Após R6 | `next_dev1_destination()` | `PASSAGEM: VILA ELEVADA`, âncora 7 |
| Câmara | Apresentação de Elias | Câmara interna inactiva; câmara QA externa activa |

## Validação

O parser Godot 4.7.1 passou. A sessão de 36 segundos completou a trajectória até R6, registou `arrival_r6=true next_anchor=7` e gravou captura interna. A revisão visual mostra simultaneamente Elias e as balizas cartográficas R5/R6 no mesmo volume técnico QA.

> Esta cena prova a coerência espacial e de rumo; não é um substituto para a composição cinematográfica ou a integração final no mundo Dev1.

## Próxima tarefa automática

**CP-D5-058 — Auditoria de orientação R1–R6.** Exercitar `next_dev1_destination()` em pontos representativos dos seis marcos e validar que não há salto de destino, especialmente no desvio lateral Majestic e na chegada às Ruínas.
