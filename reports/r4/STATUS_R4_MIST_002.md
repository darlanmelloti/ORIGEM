# ORIGEM — STATUS R4_MIST_002: Camada Local de Neblina

**Frente:** Dev4 — Ecologia
**Tarefa:** `DEV4-R4-MIST-LAYER-002`
**Escopo:** Floresta Densa entre o Arco das Ruínas e o Acampamento Majestic
**Estado:** pronta para a porta canónica R4.

## Implementação

A atmosfera de R4 é agora aplicada por `levels/regions/r4/ForestMistLayer.gd`. O módulo não gera geometria, volumes de neblina, planos, partículas, colisores, pós-processamento ou luzes. Em vez disso, cria uma cópia de baixa intensidade dos materiais StandardMaterial3D das massas florestais já existentes, reduzindo subtilmente a saturação e aumentando a rugosidade fora da clareira.

A faixa cartográfica da clareira de Orion, entre `Z=126` e `Z=151`, recebe peso zero. Assim, a abertura aprovada, o trilho e a leitura distante mantêm-se sem cortina atmosférica. As massas laterais recebem um peso máximo de 0,14 e a atenuação aproxima-se de zero no início e no fim da transição.

| Critério | Implementação | Resultado |
|---|---|---|
| Efeito local | Override de materiais apenas nos grupos R4 selecionados | Sem alteração de ambiente global |
| Clareira Orion | Exclusão explícita entre Z=126 e Z=151 | Leitura da abertura preservada |
| Luz dinâmica nova | Nenhuma | A baliza única aprovada permanece o único emissor local R4 |
| FogVolume, planos ou partículas | Nenhum nó criado | Sem parede de neblina ou custo adicional de efeitos |
| Profundidade | Material menos saturado e mais rugoso na faixa intermédia | Separação subtil entre massas laterais |

## Evidência

A prova `qa/regions/verify_r4_mist_layer.gd` instanciou a região isoladamente e devolveu:

> `[ORIGEM_R4_MIST] materiais=128 clareira_protegida=42 luzes=0`
>
> `[ORIGEM_R4_MIST_OK] camada local subtil, sem luzes e com clareira Orion preservada.`

A execução normal da rota `arch_to_forest` confirmou a instalação da camada sem `SCRIPT ERROR`, `ERROR:` ou falha de recursos no intervalo observado. A próxima validação obrigatória é a porta canónica `tools/qa/run_regional_gate.sh R4` sobre o commit desta entrega.
