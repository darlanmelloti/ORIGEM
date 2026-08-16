# ORIGEM — Checkpoint 211: Refinamento Atmosférico da Neblina

**Branch:** `feature/dev1-gameplay-core`  
**Módulo:** `levels/LevelEnvironment.gd`  
**Âmbito:** Regiões 1–6 — ambiente partilhado, sem intervenção nos módulos das Regiões 7–12.

## Incremento Aplicado

O ambiente base recebeu um ajuste controlado de neblina para reforçar a leitura de profundidade do Vale de Kheper e manter a montanha legível como destino distante. A cor foi deslocada para um azul atmosférico, a densidade foi reduzida e a influência do céu foi aumentada, sem activar neblina volumétrica nem criar carga adicional incompatível com o orçamento da GTX 1050 Ti.

| Parâmetro | Valor anterior | Valor CP 211 | Efeito esperado |
|---|---:|---:|---|
| `fog_light_color` | `(0.70, 0.81, 0.88)` | `(0.62, 0.76, 0.92)` | Separação mais fria entre planos do vale |
| `fog_density` | `0.0018` | `0.0015` | Maior profundidade de campo e leitura da montanha |
| `fog_sky_affect` | `0.68` | `0.72` | Integração mais coerente entre neblina e céu |

## Verificação Obrigatória

| Verificação | Resultado |
|---|---|
| Arranque técnico headless Godot 4.7.1 | ✅ Aprovado |
| Gameplay integrado — prólogo 30 s | ✅ Aprovado |
| Gameplay integrado — Acampamento Majestic → lago 30 s | ✅ Aprovado |
| Fronteira Regiões 7–12 | ✅ Mantida; nenhum módulo regional do Dev2 foi alterado |

> Os avisos de áudio ALSA no ambiente de teste correspondem à ausência de dispositivo sonoro no contêiner e ao fallback para áudio simulado. Não afectaram o arranque, a execução do gameplay nem a validação do checkpoint.

## Directiva de Continuidade

O CP 211 é evidência de trabalho concluído, não uma pausa. Dev1 inicia imediatamente o **CP 212 — variação de escala XZ das coníferas da Floresta Densa**. Dev2 continua o CP-D2-001 na Região 7 e Dev03 inicia CINE-001 no Take 1, cada qual dentro da respectiva fronteira operacional. A equipa deve consultar `diretor_orientacoes/` em paralelo e publicar cada checkpoint validado sem aguardar confirmação intermédia.

## Próximo Passo

**CP 212 — Variação de escala horizontal das coníferas.** Aplicar uma variação XZ de aproximadamente ±15% às coníferas da Floresta Densa, preservando o trilho físico e validando a travessia de 30 segundos.
