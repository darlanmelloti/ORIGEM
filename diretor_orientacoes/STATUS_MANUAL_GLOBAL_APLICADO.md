# ORIGEM — Conformidade com o Manual Operativo Global

**Data de verificação:** 15 de agosto de 2026
**Branch verificada:** `feature/dev1-gameplay-core`
**Resultado:** Conforme, com fronteira atualizada para Regiões 1–6 e Takes 1–11.

## Decisão aplicada

O manual global definitivo substitui as divisões anteriores baseadas apenas em Takes 1–5 ou 1–10. A distribuição válida é a seguinte:

| Frente | Limite espacial | Limite cinematográfico | Estado |
|---|---|---|---|
| Desenvolvimento Principal | Regiões 1–6 | Takes 1–11 corrigidos | Ativo e validado. |
| Novo Desenvolvedor | Regiões 7–12 | Takes 12–22 | Reservado exclusivamente à `feature/dev2-mountain-canyon`. |

## Base técnica confirmada da frente principal

| Região | Módulo presente | Função consolidada |
|---:|---|---|
| 1 — Casa Voss | `VossHouse.gd` | Prólogo, porta interativa, saída física e ambiente doméstico. |
| 2 — Estrada do Rio | `RiverRoadJourney.gd` | Rio físico, estrada, lajes e vegetação ribeirinha. |
| 3 — Arco das Ruínas | `RiverRoadJourney.gd` | Fronteira monumental, sombra e brasas de orientação. |
| 4 — Floresta Densa | `ForestLakeRegion.gd` | Trilho, fetos, coníferas e balizas de leitura. |
| 5 — Acampamento Majestic | `ForestLakeRegion.gd` | Marco investigativo integrado na progressão do vale. |
| 6 — Ruínas Submersas | `ForestLakeRegion.gd` | Lago, pilares e indícios temporais iniciais. |

A validação Godot 4.7.1 passou sem erro de GDScript. O gameplay de 30 segundos completou sem `Parse Error` nem falha de carregamento. A captura exterior confirma a continuidade do percurso de lajes até ao Arco das Ruínas.

## Handover registado

Os módulos `HighlandRegion.gd` e `OrionDestinationRegion.gd` pertencem agora à revisão da `feature/dev2-mountain-canyon`. Permanecem presentes como parte da base integrada, mas não receberão novas alterações da frente principal sem uma diretiva explícita de integração.
