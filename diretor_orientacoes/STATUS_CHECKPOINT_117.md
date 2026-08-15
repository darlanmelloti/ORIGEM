# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`
**Marco atual:** Checkpoint 117 — Arco das Ruínas e Vale Inicial
**Fronteira vigente:** Capítulos / Takes 1–10
**Estado:** validado localmente e pronto para sincronização.

## Implementação do ciclo

O vale inicial recebeu um passe de legibilidade no **Arco das Ruínas**, marco da Estrada do Rio e passagem narrativa entre a memória da Casa Voss e a Travessia do Vale. Duas brasas litúrgicas de baixo alcance foram integradas nos pilares, criando um ponto de orientação quente e localizado. A estrada, as lajes, o rio e a vegetação permanecem como elementos físicos exploráveis.

O Take 2 foi reenquadrado para a posição `(-22.0, 4.0, 22.0)`, apontando para `(-16.5, 3.8, 50.0)` com FOV de `48°`. A câmara passa a apresentar o arco de frente, enquadrado por coníferas, com o percurso de lajes a atravessar o vão e os sinais de orientação visíveis além dele.

## Validações

| Verificação | Resultado | Evidência |
|---|---|---|
| Godot 4.7.1 headless | Aprovado | O editor carregou sem erro de GDScript. |
| Take 2 físico | Aprovado | `origem_v2_phase117_take2_road_arch.png`. |
| Gameplay de 30 segundos | Aprovado | `origem_v2_phase113_twilight_stable_30s.png`; execução limpa, sem erro de carregamento ou `Parse Error`. |
| Limite operacional | Aprovado | A mudança restringe-se ao vale inicial dos capítulos 1–10. Nenhum módulo de Takes 11–22 foi editado. |

## Preservação

| Artefacto | Valor |
|---|---|
| Checkpoint | `ORIGEM_V2_RegionalWorld_Phase117_InitialValleyArch_Validated.zip` |
| Integridade | SHA-256 `0fd060144a13b2d722c55e05ca963605997a0d97d817def927cc8118e158df3a` |
| Fronteira | `FRONTEIRA_OPERATIVA_TAKES_ORIGEM.md` define dev1 nos Takes 1–10 e dev2 nos Takes 11–22. |

> A frente principal deve continuar apenas no Ato I, Ato II e início do Ato III. A exploração vertical, Vila Elevada, observatório, montanha, caverna e Orion Cube pertencem à frente `feature/dev2-mountain-canyon`.
