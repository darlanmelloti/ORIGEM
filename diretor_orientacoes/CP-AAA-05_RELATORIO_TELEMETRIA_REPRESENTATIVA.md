# CP-AAA-05 — Telemetria Representativa e Decisão de Renderer

## Resultado executivo

A telemetria foi repetida na cena representativa `R1LivingVossExteriorPreview.tscn`. A sessão durou aproximadamente 36 segundos e produziu 37 samples, dos quais 36 foram medidos após excluir explicitamente o primeiro frame de arranque. O percentil inferior de FPS foi `144 FPS`, o percentil superior de frame time foi `6,944 ms` e o máximo de luzes dinâmicas visíveis foi `1`.

O resultado é positivo para esta cena representativa em headless Compatibility/OpenGL3, mas não constitui medição final da GTX 1050 Ti. O aviso FSR1 continua presente porque FSR1 requer Forward+, enquanto o ensaio foi executado em Compatibility. A configuração deve ser resolvida antes da aprovação AAA definitiva.

| Métrica | Resultado | Classificação |
|---|---:|---|
| Cena | `R1LivingVossExteriorPreview.tscn` | Representativa R1/Casa Voss |
| Samples totais | `37` | Passou |
| Samples medidos | `36` | Primeiro frame excluído |
| P05 FPS | `144,00` | Sinal positivo no headless |
| P95 frame time | `6,944 ms` | Sinal positivo no headless |
| Máximo de luzes dinâmicas | `1` | Dentro do limite 16 |
| Parser errors | `0` | Passou |
| Aviso FSR1 | Presente | Pendente |
| Medição em GTX 1050 Ti | Não realizada | Pendente |
| Produção alterada | `false` | Preservada |

## Decisão de renderer

A execução Compatibility/OpenGL3 não pode usar FSR1 sem aviso. Não foi alterado `project.godot` nem qualquer módulo de produção para silenciar o aviso. A decisão permanece condicionada: ou se desactiva a escala FSR1 no perfil Compatibility, ou se executa uma matriz Forward+ específica com FSR1 e validação comparável. A escolha deve ser aprovada pelos responsáveis técnicos antes de promover a configuração.

## Estado

O pacote está em **AAA_CONDITIONAL / REPRESENTATIVE_TELEMETRY_PASS / LIGHT_BUDGET_PASS / RENDERER_DECISION_PENDING**. O resultado melhora substancialmente a evidência, mas não autoriza integração automática ou aprovação AAA formal no hardware-alvo.

**STATUS_CODE: CP-AAA-05 / P05_FPS_144 / P95_FRAME_TIME_6.944MS / MAX_LIGHTS_1 / FSR_WARNING_PENDING / PRODUCTION_BOUNDARY_PRESERVED.**

## Referências

[1]: `diretor_orientacoes/CP-AAA-05_REPRESENTATIVE_TELEMETRY_CORRECTED.log` — telemetria representativa corrigida.

[2]: `tools_dev5_aaa_telemetry.gd` — ferramenta isolada com exclusão do primeiro frame e percentis.

[3]: `levels/dev5/R1LivingVossExteriorPreview.tscn` — cena representativa auditada.
