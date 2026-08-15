# ORIGEM — Fronteira Operativa de Takes

**Aplicação imediata:** 15 de agosto de 2026
**Finalidade:** impedir sobreposição entre frentes de desenvolvimento e preservar a coerência do mundo regional.

## Divisão exclusiva de responsabilidades

| Equipa / branch | Âmbito permitido | Âmbito explicitamente vedado |
|---|---|---|
| Desenvolvimento Principal — `feature/dev1-gameplay-core` | Takes 1–5: Casa Voss, trilho do rio, ponte 3D, Floresta Densa, Lago das Ruínas Submersas, margens, Vila Elevada, Observatório e elementos periféricos do vale. | Takes 6–7, desfiladeiro da montanha, fendas tectónicas, caverna profunda, arena do Sentinela Kharu, praça ciclópica e Cubo de Orion. |
| Novo Desenvolvedor — `feature/dev2-mountain-canyon` | Takes 6–7: desfiladeiro íngreme, canyon, fendas tectónicas, caverna profunda, vestígios históricos, arena do Sentinela Kharu, praça ciclópica e Cubo de Orion. | Takes 1–5, Casa Voss, corredor ribeirinho, Lago das Ruínas Submersas, Vila Elevada, Observatório e a base de entrada da montanha. |

## Estado de consolidação da frente principal

A branch `feature/dev1-gameplay-core` está consolidada até ao commit `13e2b86`. O Checkpoint 114 cobre o lago, as ruínas e a estabilidade de porta/exterior. O Checkpoint 115 consolida a Vila Elevada e o Observatório como o fecho visual do Take 5. A partir deste registo, o Take 5 fica **encerrado para expansão de escopo**; qualquer ação futura nesta zona limita-se a correções de regressão confirmadas por QA.

## Protocolo de evidência

Cada alteração dentro do respetivo âmbito deve incluir validação Godot, captura durante a câmara de take ativa, gameplay ou captura estável de 30 segundos e registo de fecho na pasta `diretor_orientacoes/`. Nenhuma branch deve editar módulos, coordenadas, tomadas de câmara ou ativos pertencentes ao bloco da outra frente.

> A escala do mapa de doze marcos continua a ser a autoridade espacial. Os takes são instrumentos de composição, não fronteiras geográficas que possam ser alteradas sem coordenação.
