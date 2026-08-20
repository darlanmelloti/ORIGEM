# Directiva Operacional de Continuidade — Dev2 a Dev6

**Projecto:** ORIGEM — Godot 4.7.1  
**Escopo desta directiva:** coordenação das Regiões 1–6 e das interfaces R6→R7, sem alterar a autoridade cartográfica nem ultrapassar a fronteira técnica das Regiões 7–12.  
**Estado:** directiva activa.

## 1. Decisão de equipa

O **Dev1 — Gameplay Core fica em STANDBY** devido a indisponibilidade contratual. Não lhe são atribuídas novas tarefas, não se espera a sua execução e nenhuma frente pode depender da sua disponibilidade. Quando a CEO confirmar a sua disponibilidade, será criada uma tarefa específica e o estado da equipa será atualizado no Git antes da sua reentrada.

O **Dev2 assume a função de desenvolvedor vice e coordenador operacional** das frentes activas. Dev2 não substitui automaticamente a propriedade histórica dos módulos do Dev1; coordena handoffs, preserva a autoridade cartográfica, executa trabalho autorizado e mantém a continuidade entre ciclos.

O **Dev3 permanece responsável pela direção cinematográfica**, o **Dev4 por QA e Master Production**, o **Dev5 pelo Mundo Cartesiano & 3D** e o **Dev6 pela Arte Técnica de Ambiente**. Os **Dev7 e Dev8 não estão disponíveis** e não devem ser tratados como frentes activas, responsáveis ou dependências.

| Frente | Estado | Responsabilidade actual |
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

O grounding deve ser validado pelo sistema de aterramento cartográfico. Cada objeto precisa de escala, pivô, colisor ou marcação explícita de não bloqueante, LOD/proxy e regra de remoção. A geometria das Regiões 1–6 deve continuar separada da lógica profunda das Regiões 7–12. A interface R6→R7 pode ser validada como handoff, mas não autoriza duplicação da geometria regional.

O teto de **16 luzes dinâmicas em R12** permanece inegociável. A frente R1–R6 deve preferir materiais, ambiente, animação, sondas e iluminação já existente. Nenhuma nova OmniLight entra numa cena de produção sem inventário e validação de Dev4.

## 3. Contratos por frente

### Dev2 — Desenvolvedor Vice

Dev2 mantém a fila de continuidade operacional. Deve consultar `diretor_orientacoes/` antes de cada ciclo, confirmar o estado remoto, executar a tarefa actual e publicar `NEXT_ACTION_IMMEDIATE`. Nas Regiões 1–6, trabalha apenas em tarefas explicitamente delegadas, integrações de contrato, ferramentas QA ou handoffs que não substituam a propriedade regional de módulos indisponíveis.

A entrega mínima inclui objetivo, ficheiros autorizados, âncoras consumidas, dependências, handoffs enviados, estado QA, evidências e próxima tarefa já iniciada. Um relatório sem alteração verificável ou sem início físico da próxima tarefa não fecha o ciclo.

### Dev3 — Direção Cinematográfica

Dev3 converte cada marco cartográfico numa leitura cinematográfica: sujeito, escala, eixo de aproximação, linha de visão, oclusão, profundidade e raccord. Trabalha em cenas de validação ou módulos cinematográficos reversíveis e envia ao Dev4 referências exactas de câmara, duração, posição e critérios de comparação.

### Dev4 — QA e Master Production

Dev4 valida parser Godot 4.7.1, linter, cenas TSCN, telemetria, contagem de nós, colisores, LOD, inventário de luzes e integridade dos pacotes. Deve verificar também se fauna, NPCs e transporte têm fallback seguro e não interrompem a travessia.

Dev4 não encerra o processo com uma aprovação: cada resultado deve conter `PASSED` ou `REJECTED_VISUAL/TECHNICAL`, motivo objectivo e `NEXT_ACTION_IMMEDIATE` com início comprovável.

### Dev5 — Mundo Cartesiano & 3D

Dev5 produz candidatos de objetos, casas, arquitectura, ruínas, fauna e entidades vivas modulares. Trabalha primeiro em cenas QA isoladas com grounding automático, LOD e proxies de baixo custo. A entrega deve privilegiar silhuetas reconhecíveis e escala cartográfica, evitando caixas cinzentas, marcos flutuantes ou decoração sem função espacial.

### Dev6 — Arte Técnica de Ambiente

Dev6 produz água, céu, ciclo dia/noite, vegetação, materiais, nevoeiro e atmosfera, além dos contratos técnicos para futuros drones e cavalos. A implementação deve ser reversível, compatível com o alvo de teste e sem depender de aumento do orçamento de luzes.

Transportes começam por contratos: pontos de spawn, volumes de navegação, escala, colisor, câmera e fallback pedestre. Drones e cavalos não bloqueiam a validação do percurso principal enquanto montada e patrulha estiverem em preparação.

## 4. Handoffs obrigatórios

| Origem | Destino | Conteúdo obrigatório |
|---|---|---|
| Dev5 | Dev6 | Âncoras, bounding boxes, grounding, materiais e custo de renderização. |
| Dev6 | Dev3 | Estado visual da atmosfera, variação temporal e elementos animados. |
| Dev3 | Dev4 | Câmara, duração, sujeito, enquadramento, linha de visão e critério visual. |
| Dev4 | Dev2 | Resultado QA, inventário técnico, falhas, artefactos, hash e próxima tarefa. |
| Dev2 | Todos | Estado remoto, tarefa activa, dependências, ficheiros autorizados e próximo ciclo. |
| Dev2/Dev6 | Interface R6→R7 | Contrato de continuidade, escala, direção e navegação; sem duplicar geometria. |

## 5. Ciclo contínuo obrigatório

Toda execução, refinamento, análise, acto, captura, validação, commit ou acção de um desenvolvedor é um **incremento intermédio**, nunca o fim da produção. A sequência é:

1. Ler as orientações activas no Git e confirmar o estado remoto.
2. Identificar tarefa, região, ficheiros permitidos e dependências.
3. Implementar o incremento mínimo verificável.
4. Executar parser/headless e validação técnica.
5. Capturar gameplay real e print 1600×900 quando auditável.
6. Comparar com o mapa, referência cinematográfica e contrato.
7. Corrigir imediatamente falhas visuais, físicas ou técnicas.
8. Empacotar evidências e gerar SHA-256.
9. Commitar e sincronizar sem reescrever histórico.
10. Voltar ao Git, reler as orientações e iniciar a próxima tarefa sem aguardar confirmação intermédia.

Marcador obrigatório:

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

Se o resultado for rejeitado, a rejeição é um gatilho de correcção imediata. Se for aprovado, o ciclo seguinte começa na mesma sessão operacional. Nenhuma frente permanece parada à espera de aprovação verbal intermédia.

## 6. Próxima sequência coordenada

Iniciar o **Passe de Fidelidade Cartográfica R1–R6**. Dev5 prepara marcos, arquitectura modular e grounding de Casa Voss, Estrada do Rio e Arco. Dev6 prepara água, céu, vegetação e materiais. Dev3 prepara a câmera de leitura. Dev4 cria o harness de validação. Dev2 coordena a ordem, consolida handoffs e verifica o Git após cada execução.

O segundo bloco cobre Arco → Floresta Densa. O terceiro cobre Floresta → Acampamento Majestic → Lago. O quarto faz a travessia integrada R1–R6, com gameplay de 30 segundos, print, escopo, parser, colisores, LOD e pacote auditável.

A implementação completa de drones, cavalos, inimigos e aliados não precede a estabilidade do corredor pedestre. Os contratos de spawn, navegação e fallback podem ser criados já, mas a integração final é escalonada.

## 7. Regra final

O trabalho só pode ser considerado operacionalmente encerrado quando o resultado estiver sincronizado, a evidência estiver disponível, o estado actual estiver registado e a próxima tarefa estiver efectivamente iniciada. Um commit é um marco de auditoria; não é autorização para parar. Uma validação é uma medição; não é o fim da produção. Uma rejeição é uma instrução de correcção; não é um bloqueio.

**Dev1 permanece em standby até nova ordem da CEO. Dev7 e Dev8 permanecem fora da distribuição. Dev2, Dev3, Dev4, Dev5 e Dev6 trabalham em sincronismo através do Git, dos handoffs e do estado único activo.**
