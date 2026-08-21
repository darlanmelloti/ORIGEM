# CP-AAA-04 — Telemetria Isolada de Performance

## Resultado executivo

Foi criada e executada uma ferramenta isolada de telemetria sobre `CartographicGroundingPreview.tscn`, sem alterar `Player.gd`, `VossHouse.gd` ou outros módulos de produção. A sessão completou aproximadamente 36 segundos e terminou normalmente com `TELEMETRY_EXIT=0`. Foram recolhidas 37 amostras, com contagem máxima de uma luz dinâmica na cena isolada.

Após o primeiro sample de arranque, o runtime headless registou FPS entre aproximadamente 126 e 145 e frame time entre aproximadamente 7,94 ms e 6,90 ms. O primeiro sample apresentou `1 FPS` e `1000 ms`, valor atribuído ao arranque/primeiro frame e não usado como mediana. A telemetria é útil para a cena isolada, mas não substitui uma medição no hardware GTX 1050 Ti nem uma captura do mundo completo.

## Evidência

| Métrica | Resultado | Interpretação |
|---|---:|---|
| Duração da amostragem | 36 s | Passou temporalmente |
| Amostras | 37 | Cobertura suficiente da cena isolada |
| FPS após arranque | 126–145 | Sinal positivo no headless |
| Frame time após arranque | 6,90–7,94 ms | Sinal positivo no headless |
| Primeiro frame | 1 FPS / 1000 ms | Pico de arranque, não representativo |
| Luzes dinâmicas | Máximo 1 | Dentro do limite de 16 |
| Erros de parser | Nenhum observado | Passou |
| Aviso FSR1 | Presente | Configuração pendente |
| Hardware real GTX 1050 Ti | Não medido | Pendente |
| Produção alterada | `false` | Preservada |

## Decisão técnica

O CP-AAA-04 melhora a evidência de performance e confirma que a cena isolada não excede o orçamento de luzes. No entanto, o resultado permanece **AAA_CONDITIONAL**: o headless não representa integralmente o comportamento no hardware-alvo, a cena não é o mundo completo R1–R6 e o aviso FSR1 persiste no renderer Compatibility. A medição não autoriza integração automática nem aprovação AAA formal.

A próxima ação é repetir a telemetria numa cena de gameplay mais representativa, excluir explicitamente o primeiro frame da estatística, registar percentis de frame time e documentar a escolha entre Compatibility sem FSR1 ou Forward+ com FSR1. A fronteira de produção permanece bloqueada até aprovação explícita.

**STATUS_CODE: CP-AAA-04 / ISOLATED_TELEMETRY_PASS / LIGHT_BUDGET_PASS / TARGET_HARDWARE_PENDING / FSR_WARNING_PENDING.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-04_TELEMETRY.log` — amostras e resumo da telemetria isolada.

[2]: `tools_dev5_aaa_telemetry.gd` — ferramenta isolada de recolha de FPS, frame time e luzes.

[3]: `levels/dev5/CartographicGroundingPreview.tscn` — cena isolada utilizada no ensaio.
