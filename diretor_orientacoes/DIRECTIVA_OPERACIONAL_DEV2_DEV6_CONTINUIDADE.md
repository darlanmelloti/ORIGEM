# Directiva Operacional de Continuidade — Dev2 a Dev6

**Projecto:** ORIGEM — Godot 4.7.1  
**Escopo desta directiva:** Coordenação das Regiões 1–6 e das interfaces R6→R7, sem alterar a autoridade cartográfica nem ultrapassar a fronteira técnica das Regiões 7–12.  
**Estado:** Directiva activa para publicação em `diretor_orientacoes/`.

## 1. Decisão de equipa

A partir desta directiva, o **Dev1 — Gameplay Core fica em STANDBY** devido a indisponibilidade contratual. O standby significa que não lhe são atribuídas novas tarefas, não se espera a sua execução e nenhuma frente pode depender da sua disponibilidade. Quando a CEO confirmar que o Dev1 voltou a estar disponível, será criada uma tarefa específica e o estado da equipa será atualizado no Git antes de qualquer reentrada.

O **Dev2 assume a função de desenvolvedor vice e coordenador operacional** das frentes activas. Dev2 não substitui automaticamente a propriedade histórica dos módulos do Dev1; a sua função imediata é coordenar handoffs, preservar a autoridade cartográfica, executar trabalho autorizado nas suas áreas e manter a continuidade entre ciclos.

O **Dev3 permanece responsável pela direção cinematográfica**, o **Dev4 por QA e Master Production**, o **Dev5 pelo Mundo Cartesiano & 3D** e o **Dev6 pela Arte Técnica de Ambiente**. Os **Dev7 e Dev8 não estão disponíveis** e não devem ser tratados como frentes activas, responsáveis ou dependências.

| Frente | Estado | Responsabilidade operacional actual |
|---|---|---|
| Dev1 — Gameplay Core | **STANDBY** | Sem novas tarefas até confirmação contratual da CEO. |
| Dev2 — Desenvolvedor Vice | **ACTIVO** | Coordenação de continuidade, transições autorizadas, integração de contratos e execução nas áreas atribuídas. |
| Dev3 — Cinematográfico | **ACTIVO** | Enquadramento, raccord, profundidade, oclusão, direção de câmaras e leitura narrativa. |
| Dev4 — QA/Master Production | **ACTIVO** | Parser, linter, testes, telemetria, orçamento de luzes, empacotamento e auditoria. |
| Dev5 — Mundo Cartesiano & 3D | **ACTIVO** | Âncoras, grounding, objetos, arquitetura, LOD, fauna e entidades modulares. |
| Dev6 — Arte Técnica de Ambiente | **ACTIVO** | Água, céu, dia/noite, vegetação, materiais, atmosfera e suporte técnico a transporte. |
| Dev7 | **INDISPONÍVEL** | Não atribuir tarefas nem criar dependências. |
| Dev8 | **INDISPONÍVEL** | Não atribuir tarefas nem criar dependências. |

## 2. Autoridade espacial e limites técnicos

`mapaorigem.webp` continua a ser a **autoridade espacial única**. Nenhuma frente pode inventar um segundo conjunto de coordenadas para casas, ruínas, água, fauna, inimigos, aliados, drones ou cavalos. Cada ativo deve consumir `CartographicAnchors.gd` ou uma camada formal que o consuma directamente.

O grounding deve ser validado pelo sistema de aterramento cartográfico. Cada objeto precisa de escala, pivô, colisor ou marcação explícita de não bloqueante, LOD/proxy e regra de remoção. A geometria das Regiões 1–6 deve continuar separada da lógica profunda das Regiões 7–12. A interface R6→R7 pode ser validada como handoff, mas não autoriza a duplicação da geometria regional.

O teto de **16 luzes dinâmicas em R12** permanece inegociável. A frente R1–R6 deve preferir materiais, ambiente, animação, sondas e iluminação já existente. Nenhuma nova OmniLight deve entrar numa cena de produção sem inventário e validação de Dev4.

## 3. Contratos de entrega por frente

### Dev2 — Desenvolvedor Vice

Dev2 mantém a fila de continuidade operacional. Deve consultar `diretor_orientacoes/` antes de cada ciclo, confirmar o estado remoto, executar a tarefa actual e publicar o próximo marcador `NEXT_ACTION_IMMEDIATE`. Nas Regiões 1–6, Dev2 trabalha apenas em tarefas explicitamente delegadas, integrações de contrato, ferramentas QA ou handoffs que não substituam a propriedade regional de módulos indisponíveis.

A sua entrega mínima inclui: objetivo concreto, ficheiros autorizados, âncoras consumidas, dependências recebidas, handoffs enviados, estado QA, evidências e próxima tarefa já iniciada. Um relatório sem alteração verificável ou sem início físico da próxima tarefa não fecha o ciclo.

### Dev3 — Direção Cinematográfica

Dev3 deve converter cada marco cartográfico numa leitura cinematográfica: sujeito, escala, eixo de aproximação, linha de visão, oclusão, profundidade e raccord com o trecho seguinte. Dev3 trabalha em cenas de validação ou módulos cinematográficos reversíveis e envia ao Dev4 referências exactas de câmara, duração, posição e critérios de comparação.

O handoff para Dev4 deve indicar se a captura mostra o marco principal, se a transição é legível sem sobreposição de viewport e se a câmera preserva a orientação de Elias. Qualquer rejeição visual deve abrir imediatamente um novo passe de correção, não uma pausa.

### Dev4 — QA e Master Production

Dev4 é o guardião da execução reproduzível. Deve validar parser Godot 4.7.1, linter, cenas TSCN, telemetria, contagem de nós, colisores, LOD, inventário de luzes e integridade dos pacotes. Deve também verificar se os ativos de fauna, NPCs e transporte têm fallback seguro e não interrompem a travessia.

Dev4 não é um aprovador que encerra o processo; é um motor de feedback. Cada resultado deve conter `PASSED` ou `REJECTED_VISUAL/TECHNICAL`, motivo objetivo e `NEXT_ACTION_IMMEDIATE` com início comprovável.

### Dev5 — Mundo Cartesiano & 3D

Dev5 é responsável pelos candidatos de objetos, casas, arquitetura, ruínas, fauna e entidades vivas modulares. Deve trabalhar com grounding automático, LOD e proxies de baixo custo, primeiro em cenas QA isoladas. A entrega deve privilegiar silhuetas reconhecíveis e escala cartográfica, evitando caixas cinzentas, marcos flutuantes ou decoração sem função espacial.

Fauna e entidades devem começar como comportamentos ambientais controlados: pivô correto, animação curta, volume de interação e modo de desligamento para QA. Inimigos e aliados só devem ser integrados depois de o corredor físico e os marcos estarem estáveis.

### Dev6 — Arte Técnica de Ambiente

Dev6 é responsável por água, céu, ciclo dia/noite, vegetação, materiais, nevoeiro e atmosfera, além dos contratos técnicos para futuros drones e cavalos. A implementação deve ser reversível, compatível com GL Compatibility/Forward+ conforme o alvo de teste e sem depender de aumento do orçamento de luzes.

Transportes devem começar por contratos: pontos de spawn, volumes de navegação, escala, colisor, câmera e fallback pedestre. Drones e cavalos não devem bloquear a validação do percurso principal enquanto os sistemas de montada e patrulha ainda estiverem em preparação.

## 4. Handoffs obrigatórios

| Origem | Destino | Conteúdo obrigatório |
|---|---|---|
| Dev5 | Dev6 | Âncoras, bounding boxes, grounding, materiais esperados e custo de renderização. |
| Dev6 | Dev3 | Estado visual da atmosfera, variação temporal, condições de iluminação e elementos animados. |
| Dev3 | Dev4 | Câmara, duração, sujeito, enquadramento, linha de visão e critério visual de aprovação. |
| Dev4 | Dev2 | Resultado QA, inventário técnico, falhas, artefatos, hash e próxima tarefa concreta. |
| Dev2 | Todos | Estado remoto, tarefa activa, dependências, ficheiros autorizados e próximo ciclo. |
| Dev2/Dev6 | Interface R6→R7 | Apenas contrato de continuidade, escala, direção e navegação; sem duplicar geometria regional. |

## 5. Ciclo contínuo obrigatório

Toda e qualquer execução, refinamento, análise, acto, captura, validação, commit ou ação de um desenvolvedor é um **incremento intermédio**, nunca o fim da produção. O ciclo deve seguir esta ordem:

1. Ler as orientações activas no Git e confirmar o estado remoto.
2. Identificar a tarefa actual, a região, os ficheiros permitidos e as dependências.
3. Implementar o incremento mínimo verificável.
4. Executar parser/headless e a validação técnica correspondente.
5. Capturar gameplay real e print 1600×900 quando o ciclo for auditável.
6. Comparar com o mapa, a referência cinematográfica e o contrato de aceitação.
7. Corrigir imediatamente qualquer falha visual, física ou técnica.
8. Empacotar evidências e gerar SHA-256.
9. Commitar e sincronizar sem reescrever histórico.
10. Voltar ao Git, reler as orientações e iniciar a próxima tarefa sem aguardar confirmação intermédia.

O marcador final de cada ciclo deve usar este formato:

```markdown
### ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **REGIAO_ACTUAL**: [região ou interface]
- **RESPONSAVEL**: [Dev2, Dev3, Dev4, Dev5 ou Dev6]
- **STATUS_CODE**: [PASSED / REJECTED_VISUAL / REJECTED_TECHNICAL]
- **TAREFA_EM_EXECUCAO_AGORA**: [alteração concreta já iniciada]
- **DEPENDENCIAS_RECEBIDAS**: [handoffs e commits]
- **EVIDENCIA**: [QA, gameplay, print, ZIP, SHA-256]
- **NEXT_ACTION_IMMEDIATE**: [próxima alteração concreta]
- **DEADLINE_PROXIMO_PUSH**: [timestamp ou janela de execução]
- **WAIT_ALLOWED**: false
```

Se o resultado for `REJECTED_VISUAL` ou `REJECTED_TECHNICAL`, a rejeição é um gatilho de correção imediata. Se o resultado for `PASSED`, o ciclo seguinte começa na mesma sessão operacional. Nenhuma frente deve permanecer parada à espera de uma aprovação verbal que não seja exigida pelo contrato técnico.

## 6. Próxima sequência coordenada

A primeira sequência após a publicação desta directiva é o **Passe de Fidelidade Cartográfica R1–R6**, organizado em quatro blocos encadeados. Dev5 deve preparar marcos, arquitetura modular e grounding de Casa Voss, Estrada do Rio e Arco. Dev6 deve preparar água, céu, vegetação e materiais compatíveis. Dev3 deve preparar a câmera de leitura do trecho. Dev4 deve criar o harness de validação. Dev2 deve coordenar a ordem, consolidar os handoffs e verificar o Git após cada execução.

O segundo bloco cobre Arco → Floresta Densa, com árvores, raízes, rochas, fauna ambiental e navegação. O terceiro cobre Floresta → Acampamento Majestic → Lago, com área de pausa, objetos de interação, aterramento de margens e transição de água. O quarto faz a travessia integrada de R1–R6, com gameplay de 30 segundos, print, escopo, parser, colisores, LOD e pacote auditável.

A implementação completa de drones, cavalos, inimigos e aliados não deve preceder a estabilidade do corredor pedestre. Os contratos de spawn, navegação e fallback podem ser criados desde já, mas a integração final deve ser escalonada para não mascarar problemas de escala, orientação ou colisão.

## 7. Regra final de continuidade

O trabalho só pode ser considerado operacionalmente encerrado quando o resultado estiver sincronizado, a evidência estiver disponível, o estado actual estiver registado e a próxima tarefa estiver efectivamente iniciada. Um commit é um marco de auditoria; não é uma autorização para parar. Uma validação é uma medição; não é o fim da produção. Uma rejeição é uma instrução de correção; não é um bloqueio.

**Dev1 permanece em standby até nova ordem da CEO. Dev7 e Dev8 permanecem fora da distribuição. Dev2, Dev3, Dev4, Dev5 e Dev6 devem trabalhar em sincronismo através do Git, dos handoffs e do estado único activo.**
