# ORIGEM — Fronteira Operativa Definitiva de 22 Capítulos

**Aplicação imediata:** 15 de agosto de 2026
**Autoridade:** Direção Executiva e Direção de Desenvolvimento
**Finalidade:** eliminar duplicação de esforço e garantir uma transição física contínua desde a Casa Voss até ao Orion Cube.

## Divisão exclusiva de responsabilidades

| Equipa / branch | Âmbito exclusivo | Conteúdo permitido | Âmbito vedado |
|---|---|---|---|
| Desenvolvimento Principal — `feature/dev1-gameplay-core` | **Capítulos / Takes 1–10** | Ato I — Memória da Casa Voss; Ato II — Chamamento; Ato III inicial — estrada junto à casa, arco monumental, vale inicial, bifurcação e preparação da travessia. Inclui fundação interativa do prólogo, porta exterior `[E]`, espada, trilhos, floresta inicial e desempenho na GTX 1050. | Capítulos / Takes 11–22: ponte, subida, Vila Elevada, observatório, trilho da montanha, canyon, caverna, galeria das eras, praça ciclópica e Orion Cube. |
| Novo Desenvolvedor — `feature/dev2-mountain-canyon` | **Capítulos / Takes 11–22** | Bifurcação avançada, sinais no bosque, ponte, subida, Vila Elevada, observatório, trilho da montanha, desfiladeiro, fendas tectónicas, caverna profunda, vestígios históricos, arena do Sentinela Kharu, praça ciclópica e Orion Cube. | Capítulos / Takes 1–10: Casa Voss, prólogo, estrada junto à casa, arco monumental, vale inicial e fundação da travessia. |

## Regra crítica de transição

O conteúdo experimental do antigo bloco isolado do Take 5 não define a nova divisão. A frente `feature/dev2-mountain-canyon` começa a partir da **base estável consolidada** entregue pela frente principal; qualquer transição espacial deve respeitar a escala do mapa e a continuidade física do mundo.

## Cadência obrigatória de coordenação

| Frequência | Procedimento obrigatório |
|---|---|
| A cada 10 minutos | Ler `diretor_orientacoes/` no GitHub antes de continuar a codificação. |
| A cada 30 minutos ou no fecho de uma tarefa | Executar validação Godot 4.7.1, captura de alta resolução, gameplay de cerca de 30 segundos, registo de fecho e push imediato na branch própria. |
| A cada 20 minutos após novos commits | A direção audita o código, a jogabilidade e a fidelidade narrativa, emitindo o próximo alinhamento. |

> Os takes são instrumentos de narrativa e composição. A autoridade espacial permanece o mapa regional e a continuidade explorável do mundo, nunca um corte cinematográfico isolado.
