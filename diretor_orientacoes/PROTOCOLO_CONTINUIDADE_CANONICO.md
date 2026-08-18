# Protocolo Canónico de Continuidade — ORIGEM

**Estado:** obrigatório em todas as frentes. Este documento prevalece sobre relatórios, workspaces, branches ou protocolos históricos que lhe sejam contraditórios.

> Um commit, relatório, captura, linter ou auditoria é evidência de progresso. Nunca é um ponto de paragem.

## 1. Autoridade operacional

A autoridade espacial é o mapa cartográfico oficial. A autoridade narrativa é a sequência de Takes. A autoridade operacional é este protocolo, em conjunto com o marcador `CONTINUIDADE_<FRENTE>.md` da frente respectiva.

| Frente | Escopo exclusivo | Limite intransponível | Forma de continuidade |
| --- | --- | --- | --- |
| Dev1 | Regiões 1–6; Takes 1–11; Casa Voss, Estrada do Rio, Arco, Floresta Densa, Acampamento Majestic e Ruínas Submersas | Não altera módulos, geometria, câmaras ou activos das Regiões 7–12 | Actualiza `CONTINUIDADE_DEV1.md` e abre o CP seguinte no seu escopo |
| Dev2 | Regiões 7–12; Takes 12–22; Vila Elevada, Observatório, trilha, Garganta, Caverna Orion, Câmara do Cubo e Hub | Não altera Regiões 1–6 | Actualiza `CONTINUIDADE_DEV2.md` e abre o CP seguinte no seu escopo |
| Dev3 | Câmaras, takes, enquadramentos, evidências e direcção de composição | Não altera geometria regional ou módulos proprietários de Dev1/Dev2 | Trabalha na mesma prova que Dev4 e actualiza `CONTINUIDADE_DEV3.md` |
| Dev4 | Apoio técnico directo: validação Godot, orçamento GTX 1050 Ti, estabilidade, automação de prova e correcções transversais autorizadas | Não cria DIRs isolados nem usa auditoria como entrega final | Trabalha na mesma prova que Dev3 e actualiza `CONTINUIDADE_DEV4.md` |

## 2. Regra de ciclo sem paragem

No final de **cada** implementação, validação ou publicação, a frente executa obrigatoriamente, nesta ordem:

1. Lê os marcadores e orientações recentes dentro de `diretor_orientacoes/`.
2. Selecciona a primeira tarefa aberta dentro do seu escopo exclusivo.
3. Actualiza o seu único marcador canónico de continuidade.
4. Inicia a alteração seguinte de código, cena, QA ou investigação na mesma sessão, sem aguardar resposta humana.

Nenhuma frente pode declarar bloqueio por caminho local inexistente se existir um checkout válido no ramo atribuído. Nessa situação, deve registar o caminho ou ramo verificado, recuperar o checkout e avançar para a primeira tarefa física disponível. Um bloqueio só é válido se houver uma dependência material concreta, identificada, reproduzível e registada no marcador; ainda assim, a frente deve executar a próxima tarefa independente do seu escopo.

## 3. Marcador obrigatório

Cada frente mantém **um único ficheiro canónico** chamado `CONTINUIDADE_DEV1.md`, `CONTINUIDADE_DEV2.md`, `CONTINUIDADE_DEV3.md` ou `CONTINUIDADE_DEV4.md`. Relatórios históricos permanecem como evidência, mas não podem redefinir a próxima tarefa.

```markdown
# Continuidade — <FRENTE>

- **Último checkpoint publicado:** `<commit/estado>`
- **Validação concluída:** `headless / Novo Jogo / 30 segundos / captura`
- **Próxima tarefa iniciada:** `<identificador e nome>`
- **Ficheiros dentro do escopo:** `<lista>`
- **Critério de aceitação:** `<resultado observável>`
- **Próxima leitura de orientações:** `<hora UTC>`
- **Estado:** `EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`
```

## 4. Regra específica Dev3–Dev4

Dev3 e Dev4 funcionam como uma dupla de entrega, não como frentes que se bloqueiam mutuamente:

| Etapa | Dev3 | Dev4 | Entrega única |
| --- | --- | --- | --- |
| Prova | Formula a pergunta de composição e o critério visual | Prepara cenário, telemetria e captura de 30 segundos | Evidência comparável |
| Decisão | Selecciona uma única hipótese dentro do escopo visual | Confirma custo, estabilidade e não regressão | Uma alteração reversível |
| Fecho | Avalia o enquadramento resultante | Valida Godot, gameplay e orçamento | Commit com próximo CINE-PAIR já iniciado |

Dev4 não pode abrir `DIR-###` como tarefa autónoma, nem encerrar uma resposta com “aguardar instruções”. Se a sua auditoria localizar uma lacuna, deve ligá-la imediatamente à tarefa activa Dev3 e executar a prova seguinte. Dev3 não pode declarar bloqueio por workspace se o checkout cinematográfico e `project.godot` estiverem presentes.

## 5. Estado de recuperação e próximas tarefas

| Frente | Checkout ou ramo de referência | Próxima tarefa obrigatória já iniciada |
| --- | --- | --- |
| Dev1 | `feature/director-cinematic-polish` / workspace Dev1 | Próximo CP aberto exclusivamente nas Regiões 1–6 |
| Dev2 | Branch atribuída às Regiões 7–12; confirmar checkout antes de editar | `CP-D2-001` — sincronizar a cadeia física Vila Elevada → Observatório → Garganta Orion com o mapa cartográfico |
| Dev3–Dev4 | `feature/cine07-final` / checkout cinematográfico validado | `CINE-PAIR-14` — auditar luzes locais e leitura da Garganta sob a câmara de retorno preservada |

## 6. Verificação mínima obrigatória

Toda mudança permanente exige validação técnica Godot e uma sessão real de pelo menos 30 segundos ou captura equivalente da cena. Se o resultado não atingir o critério definido, a frente reverte ou corrige e inicia a próxima hipótese dentro do mesmo ciclo. O orçamento máximo é de 16 luzes dinâmicas visíveis simultaneamente no exterior e permanece inferior a esse limite no interior Orion.

## 7. Resolução de divergências

Em caso de conflito entre documento histórico e este protocolo, aplicar esta ordem:

1. Fronteira espacial Dev1/Dev2;
2. Marcador canónico da frente;
3. Próxima tarefa material já iniciada;
4. Evidência Godot e gameplay;
5. Relatórios históricos apenas como referência.

Nenhuma divergência documental autoriza uma paragem.
