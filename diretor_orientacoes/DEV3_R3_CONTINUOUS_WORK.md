# Dev3 — Contrato de Trabalho Contínuo do Arco das Ruínas

> **Regra operacional:** uma prova R3 aprovada não encerra o Dev3. Cada entrega deve publicar, validar e substituir a tarefa ativa por outra, sem deixar a Região 3 sem sequência de trabalho rastreável.

## Estado legível por automação

```text
status: ACTIVE
task_id: DEV3-R3-ARCH-MARGIN-CALM-056
owner: Dev3
branch: dev3/r3-arch-ruins
```

## Entrega recuperada e aprovada — DEV3-R3-ARCH-AWAKENING-RECOVERY-001

A entrega declarada do Dev3 não estava presente no repositório remoto no commit indicado pelo relatório. Foi recuperada de forma compatível com o mundo atual: o Arco físico existente continua em Z aproximado 92, com dois pilares colidíveis laterais e vão central livre. A camada `R3ArchAwakening` acrescenta inscrições, efeito moderado sem novas luzes, despertar único por `EventBus.world_event_triggered` e persistência através do grupo `Persist`.

A prova `[ORIGEM_R3_ARCH_OK]` valida a projeção física, os dois colisores laterais, exatamente duas `OmniLight3D` locais e o despertar idempotente. O preenchimento Omni adicional foi removido para manter o orçamento contratual R3.

## Entrega aprovada — DEV3-R3-FOREST-HANDOFF-002

`R3HandoffParaFloresta` foi instalado no corredor real depois do Arco com quatro pedras de orientação baixas e oito fetos dispersos. A sequência permanece fora da faixa central, não cria colisores, luzes, painéis ou parede vegetal. A prova `[ORIGEM_R3_ARCH_OK]` confirma os quatro marcos abertos, zero `OmniLight3D` nova e a preservação do Arco, do despertar e das rotas R3.

## Entrega aprovada — DEV3-R3-INSCRIPTION-LORE-003

`R3LeituraArqueologica` instala duas placas de pedra quebrada, baixas e laterais, no Arco físico já integrado. As leituras “O RIO GUARDA / O QUE A PEDRA CALA” e “A LUZ NÃO SABE / O CAMINHO DE VOLTA” dialogam com as inscrições existentes sem revelar Orion. As placas ficam fora da faixa central, não criam `CollisionShape3D`, `StaticBody3D`, UI ou `Light3D`, e recebem apenas uma alteração cromática discreta quando o despertar único ocorre. A prova `[ORIGEM_R3_INSCRIPTION_LORE_OK]`, o parser, o portão regional e as rotas `road_to_arch`/`arch_to_forest` foram aprovados; a captura técnica confirma a leitura lateral sem interface.

## Entrega aprovada — DEV3-R3-ARCH-SOUNDLESS-VFX-004

A cadência silenciosa foi aplicada a `EfeitosDoDespertar`, reutilizando os dois `SphereMesh` existentes. O primeiro despertar reinicia uma sequência de três pulsos durante `1,35 s`, com amplitude máxima de escala `0,12`, e regressa a uma oscilação residual menor. Não foram adicionados `Light3D`, emissores, partículas densas, áudio, UI ou bloqueio físico. A prova `[ORIGEM_R3_SILENT_VFX_OK]`, parser, porta regional e rotas R3 aprovaram o comportamento; a captura técnica confirma que o efeito continua subordinado aos pilares do Arco.

## Entrega aprovada — DEV3-R3-PASSAGE-ARCHAEOLOGY-005

`R3HandoffParaFloresta` recebeu três vestígios arqueológicos baixos nos intervalos Z 96,8–105,8. Cada fragmento declara um offset lateral mínimo de 4,20 m, mantém-se fora do corredor, não cria `CollisionShape3D`, `StaticBody3D`, UI ou luz. A prova `[ORIGEM_R3_PASSAGE_ARCHAEOLOGY_OK]`, parser, porta R3, rotas e captura técnica aprovaram a leitura de passagem e a continuidade para R4.

## Entrega aprovada — DEV3-R3-RIVER-MEMORY-006

`R3LeituraArqueologica` recebeu três seixos de ardósia húmida, baixos e laterais, assentados pela função de altura real do terreno da Estrada do Rio. A memória material permanece sem texto adicional, UI, colisão, luz, áudio ou emissão. A prova `[ORIGEM_R3_RIVER_MEMORY_OK]`, parser, porta R3, rotas e captura técnica aprovaram a integração no limiar físico do Arco.

## Entrega aprovada — DEV3-R3-ARCH-PATINA-007

`R3PatinaArqueologica` aplica material mate a cinco fragmentos de coroa e base já existentes, mantendo as malhas, a silhueta, o vão, as duas luzes e a ausência de VFX/áudio/colisão. A prova `[ORIGEM_R3_ARCH_PATINA_OK]`, parser, porta R3, rotas e captura técnica aprovaram a intervenção localizada.

## Entrega aprovada — DEV3-R3-ARCH-SILHOUETTE-008

`R3SilhuetaCartografica` ajusta três fragmentos de coroa laterais já existentes para reforçar a leitura vertical do marco, sem criar malhas, lintéis, paredes, luzes, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_SILHOUETTE_OK]`, parser, porta R3, rotas e captura de aproximação aprovaram a abertura física e a continuidade do eixo.

## Entrega aprovada — DEV3-R3-ARCH-ARRIVAL-CUE-009

`R3LeituraDeChegada` reposiciona três grupos de base laterais existentes para clarificar a aproximação R2→R3, sem criar nós visuais, UI, texto, emissão, luz, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_ARRIVAL_CUE_OK]`, parser, porta R3, rotas e captura de aproximação aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-GROUND-RHYTHM-010

`R3RitmoArqueologicoDoSolo` ajusta três grupos baixos laterais existentes para dar cadência material ao solo, sem lajes centrais, nós novos, UI, luz, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_GROUND_RHYTHM_OK]`, parser, porta R3, rotas e captura lateral aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-EXIT-ECHO-011

`R3EcoArqueologicoDeSaida` ajusta dois vestígios pós-Arco existentes antes do limite R4, sem criar geometria, UI, texto, luz, emissor, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_EXIT_ECHO_OK]`, parser, porta R3, rotas e captura de saída aprovaram a continuidade aberta para a floresta.

## Entrega aprovada — DEV3-R3-ARCH-MATERIAL-CONSISTENCY-012

`R3CoerenciaMaterial` harmoniza os materiais já existentes de placas, fraturas, seixos e pátina, sem criar geometria, UI, texto novo, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MATERIAL_CONSISTENCY_OK]`, parser, porta R3, rotas e captura técnica aprovaram a intervenção.

## Entrega aprovada — DEV3-R3-ARCH-NARRATIVE-QUIET-013

`R3NarrativaSilenciosa` estabelece uma relação espacial mínima entre a placa ocidental, memória material do rio e dois vestígios de saída já existentes. Não cria texto, UI, placas, objetos, geometria, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_NARRATIVE_QUIET_OK]`, parser, porta R3, rotas e captura aprovaram a composição.

## Entrega aprovada — DEV3-R3-ARCH-ARRIVAL-EXIT-BALANCE-014

`R3EquilibrioChegadaSaida` ajusta somente orientação e profundidade de dois grupos laterais de chegada e dois vestígios laterais de saída já existentes. Não cria texto, UI, placas, objetos, geometria, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_ARRIVAL_EXIT_BALANCE_OK]`, parser, porta R3, rotas e captura aprovaram a composição.

## Entrega aprovada — DEV3-R3-ARCH-HUMID-THRESHOLD-015

`R3LimiarHumidoLateral` ajusta apenas materiais existentes de seixos e fraturas laterais, sem trilho, geometria, UI, luz, emissão, VFX, áudio ou colisores. A prova, captura e porta R3 aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-SILENCE-016

`R3SilencioDeMargem` reduz a competição visual apenas na pátina lateral já existente, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova específica e a porta R3 aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-THRESHOLD-REST-017

`R3RepousoDoLimiar` mantém o repouso material apenas sobre superfícies laterais já existentes, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova específica e a porta R3 aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-MATERIAL-REST-018

`R3RepousoMaterial` preserva o repouso de pátina lateral já existente sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova específica e a porta R3 aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-CALM-019

`R3CalmaLateral` preserva uma leitura material discreta apenas nas superfícies laterais já existentes, sem criar geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova específica e a porta R3 aprovaram a entrega.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-REST-020

`R3RepousoDaMargem` consolida apenas os materiais laterais já existentes, herdados de `r3_lateral_calm`, com rugosidade mate e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-STILLNESS-021

`R3ImobilidadeLateral` consolida apenas materiais laterais já existentes, herdados de `r3_margin_rest`, com rugosidade muito mate, metalicidade mínima e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_STILLNESS_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-MATTE-022

`R3AcabamentoMateDaMargem` consolida apenas materiais laterais já existentes, herdados de `r3_lateral_stillness`, com rugosidade mate extrema, metalicidade mínima e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_MATTE_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-VELVET-023

`R3LeituraAveludadaLateral` preserva apenas materiais laterais já existentes, herdados de `r3_margin_matte`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_VELVET_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-QUIET-024

`R3QuietudeDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_velvet`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_QUIET_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-SILENCE-025

`R3SilencioLateral` preserva apenas materiais laterais já existentes, herdados de `r3_margin_quiet`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_SILENCE_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-STILL-026

`R3ImobilidadeDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_silence`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_STILL_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-MATTE-027

`R3AcabamentoMateLateral` preserva apenas materiais laterais já existentes, herdados de `r3_margin_still`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_MATTE_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-CALM-028

`R3CalmaDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_matte`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_CALM_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-REST-029

`R3RepousoLateral` preserva apenas materiais laterais já existentes, herdados de `r3_margin_calm`, com rugosidade discreta, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-MATTE-030

`R3AcabamentoMateDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_MATTE_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-CALM-031

`R3CalmaLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_matte_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_CALM_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-SILENCE-032

`R3SilencioDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_calm_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_SILENCE_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-STILL-033

`R3ImobilidadeLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_silence_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_STILL_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-REST-034

`R3RepousoEstavelDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_still_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_REST_STILL_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-MATTE-035

`R3AcabamentoMateLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_rest_still`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_MATTE_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-CALM-036

`R3CalmaEstavelDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_matte_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_CALM_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-SILENCE-037

`R3SilencioLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_calm_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_SILENCE_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-STILL-038

`R3ImobilidadeDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_silence_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_STILLNESS_REST_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-REST-039

`R3RepousoLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_stillness_rest`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_REST_STILLNESS_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-MATTE-040

`R3AcabamentoMateEstavelDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_rest_stillness`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_MATTE_STILLNESS_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-CALM-041

`R3CalmaLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_matte_stillness`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_CALM_STILLNESS_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-MARGIN-SILENCE-042

`R3SilencioEstavelDaMargem` preserva apenas materiais laterais já existentes, herdados de `r3_lateral_calm_stillness`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_SILENCE_STILLNESS_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada.

## Entrega aprovada — DEV3-R3-ARCH-LATERAL-STILL-043
`R3ImobilidadeLateralEstavel` preserva apenas materiais laterais já existentes, herdados de `r3_margin_silence_stillness`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_STILLNESS_CALM_OK]`, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois do rebase sobre a integração actualizada; a entrega foi publicada em `fd5ee26`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-REST-044
`R3RepousoCalmoDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_stillness_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_REST_CALM_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais depois da reconciliação `312a729`; a entrega foi publicada em `3ae8b1c`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-REST-045
`R3RepousoLateralCalmo` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_rest_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_REST_CALM_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `099a9d3`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-STILL-046
`R3ImobilidadeCalmaDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_rest_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_STILL_CALM_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `fcdccea`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-MATTE-047
`R3AcabamentoMateLateralCalmo` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_still_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_MATTE_CALM_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `287c083`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-CALM-048
`R3CalmaImovelDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_matte_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_CALM_STILL_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `a26b49b`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-SILENCE-049
`R3SilencioLateralCalmo` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_calm_still`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_SILENCE_CALM_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `c7f670e`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-REST-050
`R3RepousoSilenciosoDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_silence_calm`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_REST_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `00b6654`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-STILL-051
`R3ImobilidadeLateralSilenciosa` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_rest_silent`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_STILL_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `9e1849f`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-CALM-052
`R3CalmaSilenciosaDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_still_silent`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_CALM_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `fb05083`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-REST-053
`R3RepousoLateralSilencioso` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_calm_silent`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_REST_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `6d4ac27`.
## Entrega aprovada — DEV3-R3-ARCH-MARGIN-STILL-054
`R3ImobilidadeSilenciosaDaMargem` preserva apenas materiais R3 já existentes, herdados de `r3_lateral_rest_silent`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_MARGIN_STILL_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `fdb43cf`.
## Entrega aprovada — DEV3-R3-ARCH-LATERAL-MATTE-055
`R3AcabamentoMateLateralSilencioso` preserva apenas materiais laterais R3 já existentes, herdados de `r3_margin_still_silent`, com rugosidade máxima, metalicidade nula e emissão desligada. A camada não cria geometria, texto, UI, luz, emissão, VFX, áudio ou colisores. A prova `[ORIGEM_R3_ARCH_LATERAL_MATTE_SILENT_OK]`, a captura visual, o parser e a porta R3 aprovaram a preservação do vão, da transição e das duas luzes locais; a entrega foi publicada em `cdfb24c`.
## Tarefa ativa — DEV3-R3-ARCH-MARGIN-CALM-056
A margem do Arco deve manter uma **calma material sem reflexos**, limitada a materiais R3 já existentes e herdados de `r3_lateral_matte_silent`. A tarefa conserva apenas a ausência de reflexão na margem sem criar trilho, texto, UI, placas, objetos, geometria, luzes, emissão, VFX, áudio ou colisores; a rota R2→R4 deve permanecer aberta.
| Critério | Obrigatório |
|---|---|
| Escopo | Apenas `levels/regions/r3/`, QA R3 e documentação Dev3; não alterar Códice, `ForestLakeRegion.gd`, âncoras ou módulos R4–R6 |
| Cartografia | Preservar Arco em Z aproximado 92, vão físico livre e saída `arch_to_forest` |
| Material | Actuar somente em materiais existentes já marcados `r3_lateral_matte_silent`, sem criar trilho ou objectos novos |
| Luz | Não adicionar luz dinâmica; manter exactamente as duas luzes locais existentes no Arco |
| Jogabilidade | Colisores, despertar, placas, seixos e passagem mantêm a respetiva física e ausência de bloqueio |
| Verificação | Parser, `tools/qa/run_regional_gate.sh R3`, prova específica de calma da margem e rotas R3 antes de publicar |
## Fecho e avanço obrigatório

Dev3 só pode fechar a tarefa após commit publicado, porta R3 verde e substituição desta secção por outra **Tarefa ativa** com `task_id` novo. A esteira cria ou mantém uma única issue ativa de continuidade do Dev3 e encerra automaticamente as obsoletas.

## Próxima fila reservada
`DEV3-R3-ARCH-MARGIN-CALM-056` preserva a margem calma sem reflexos e sem alterar o corredor.
