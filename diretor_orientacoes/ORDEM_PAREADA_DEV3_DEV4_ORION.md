# ORIGEM — Ordem Pareada Dev3 + Dev4: Interior Orion

**Estado:** `CICLO INTEGRADO EM EXECUÇÃO — NÃO ABRIR AUDITORIAS ISOLADAS`
**Ramo canónico:** `feature/cine07-final`
**Workspace de referência disponível:** checkout com `project.godot` e cena `scenes/orion_interior.tscn`.

## Correcção operacional

O modelo em que Dev4 conclui um único `DIR-###`, declara o DIR seguinte activo e encerra a entrega é inadequado. O documento sozinho não altera o jogo, não valida a composição e não reduz a lacuna do Dev3. A partir desta ordem, Dev4 deixa de abrir microauditorias isoladas enquanto existir uma lacuna cinematográfica executável.

A alegação de que Dev3 está bloqueado por repositório ou materiais ausentes é **obsoleta** neste ramo: há um checkout Godot válido, `project.godot` acessível e `feature/cine07-final` sincronizado. A recuperação documental já foi resolvida; o trabalho volta ao runtime.

## Objectivo conjunto único

**CINE-PAIR-01 — Tornar a soleira e o primeiro desvio do corredor Orion espacialmente legíveis durante 30 segundos de movimento, sem outdoors, sem primitivas decorativas e com no máximo 16 luzes dinâmicas.**

| Participante | Responsabilidade contínua | Artefacto material no mesmo ciclo | Não é permitido |
| --- | --- | --- | --- |
| Dev3 | Dono da direcção de câmara, composição, critérios de aceitação e escolha/rejeição visual. | Capturas comparáveis de soleira, primeiro desvio e profundidade; diagnóstico de composição com candidato seguinte já iniciado. | Declarar bloqueio por falta do ramo histórico ou fechar após uma captura. |
| Dev4 | Parceiro técnico do Dev3: reproduz a captura, mede o impacto no runtime, prepara apenas o apoio reutilizável necessário e valida colisão/orçamento. | Patch ou harness de evidência directamente usado pelo CINE-PAIR-01, mais prova Godot de 30 segundos. | Criar DIRs de linter, pacote, prontidão ou coordenação que não contribuam para a cena Orion. |
| Dev1 | Mantém Regiões 1–6; não altera Orion. | Handoff/âncora apenas quando for proprietário. | Absorver trabalho Dev3/Dev4. |
| Dev2 | Mantém Regiões 7–12 exteriores; não altera o corredor independente. | Contrato R7→R9 quando aplicável. | Usar o atraso de Dev3/Dev4 como autorização para parar. |

## Sequência de execução sem paragem

1. **Dev4 inicia agora** uma sonda de evidência de rota para o interior Orion: regista posição, vector de câmara, distância à parede/solo e orçamentação de luzes em três pontos físicos. A sonda é temporária e deve ser removida antes do commit permanente.
2. **Dev3 usa a sonda** para decidir uma única alteração cinematográfica estrutural que não repita os candidatos já rejeitados em `CP_CINE_56_DIAGNOSTICO_MOVIMENTO.md`.
3. **Dev4 implementa ou revê tecnicamente** apenas essa alteração, mantendo o suporte físico, o FOV 64 aprovado, o controlo de Elias e o orçamento de luzes.
4. **Dev3 e Dev4 validam juntos** o mesmo percurso por pelo menos 30 segundos: headless, runtime, captura da soleira e captura do ponto de decisão.
5. A entrega só pode ser marcada como checkpoint se contiver, no mesmo commit, a decisão visual, a evidência técnica e o próximo candidato **já iniciado**. Caso a alteração não atinja ganho perceptível, ambos revertem e começam a próxima hipótese no mesmo ciclo.

## Critérios de aceitação CINE-PAIR-01

| Critério | Condição de aprovação |
| --- | --- |
| Rota | O jogador identifica piso e direcção de avanço desde a soleira, sem depender de UI. |
| Geometria | O espaço parece uma formação rochosa contínua; não há painel, outdoor, massa primitiva isolada ou céu exposto. |
| Runtime | Sem erro de parse/runtime durante 30 segundos; Elias mantém suporte físico e retorno por `E`. |
| Desempenho | Máximo de 16 luzes dinâmicas simultâneas; preferir reaproveitamento de luzes e geometria existente. |
| Continuidade | O fim de qualquer subtarefa nomeia a subtarefa seguinte e não abre um DIR autónomo. |

> **Regra final:** Dev4 não está autorizado a declarar `DIR-126` como execução autónoma. O seu próximo trabalho é uma contribuição material para `CINE-PAIR-01`; Dev3 não está autorizado a declarar bloqueio enquanto este checkout estiver disponível.
