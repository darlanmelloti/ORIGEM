# ORIGEM — Ponto de Situação Técnico

**Branch:** `feature/dev1-gameplay-core`
**Marco atual:** Checkpoint 118 — Continuidade Majestic → Ruínas Submersas
**Âmbito confirmado:** Regiões 1–6 e Takes 1–11 corrigidos
**Estado:** validado localmente; pronto para sincronização.

## Incremento entregue

O corredor entre a Floresta Densa, o Acampamento Majestic e as Ruínas Submersas recebeu uma passagem de continuidade física e visual. Quatro caixas de campo, lanternas de baixa intensidade e afloramentos rochosos aterrados acompanham a chegada ao lago sem ocupar a faixa de lajes. A abertura ocidental da margem permanece livre, e as rochas de margem foram reposicionadas mais perto do solo para eliminar a impressão de elementos suspensos.

A leitura da bacia foi recalibrada para o renderizador de compatibilidade através de emissão fria mínima no material da água e dois preenchimentos OmniLight3D em coordenadas mundiais. Estes preservam a água escura e o contraste litúrgico, mas recuperam a separação de superfície e pilares no Take 11. A câmara de QA do Take 11 passa a observar a rota final e a bacia a partir de `(15.0, 11.5, 216.0)`, com alvo em `(60.0, 1.0, 252.0)`.

| Requisito da direção | Resultado |
|---|---|
| Percurso físico Casa Voss → estrada → arco → floresta → acampamento → lago | Confirmado por trilhos contínuos, abertura de margem e captura do Take 11. |
| Porta `[E]`, salto e stamina | Confirmados por auditoria de scripts e gameplay de 30 segundos. |
| Colisões e aterramento | Terreno possui `CollisionShape3D`; rochas da margem usam `height_at()` com ajuste de contacto reduzido. |
| Água e Ruínas Submersas | Superfície, pilares, iluminação de bacia e margens presentes na captura de alta resolução. |
| Montanha distante | Mantida como silhueta de fundo; nenhuma geometria de Regiões 7–12 foi alterada. |
| Validação Godot 4.7.1 | Aprovada sem erro de GDScript. |
| Gameplay de 30 segundos | Aprovado sem `Parse Error` ou falha de carregamento. |

## Evidências

| Artefacto | Finalidade |
|---|---|
| `origem_v2_phase118_take11_majestic_lake_transition.png` | Take 11 em 1600×900; chegada ao lago e composição Majestic–Ruínas. |
| `origem_v2_phase113_twilight_stable_30s.png` | Estabilidade de gameplay pós-incremento. |
| `ORIGEM_V2_RegionalWorld_Phase118_MajesticLakeContinuity_Validated.zip` | Checkpoint recuperável. |
| `ORIGEM_V2_RegionalWorld_Phase118_MajesticLakeContinuity_Validated.sha256` | SHA-256 `dd7442ac39bb50e41a65f4d94444c7445d079b5b591bce259fcc619bf5c0262d`. |

## Registo de auditoria do diretor

> A execução continua automaticamente na fundação Casa Voss → Estrada do Rio → Arco → Floresta Densa → Acampamento Majestic → Ruínas Submersas. A direção deverá analisar a evidência publicada e emitir apenas ajustes; a falta de resposta não bloqueia o desenvolvimento dentro das Regiões 1–6.

Nenhum módulo das Regiões 7–12 foi editado neste ciclo.
