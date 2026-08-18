# Regra de Execução Contínua — Dev4

## Estado da auditoria

O relatório recebido para CINE-PAIR-14/15 **não está publicado** na branch canónica `feature/cine07-final`. A última revisão remota verificável é `5c5f7e8`; não existem evidências, scripts `CinePair14GorgeReadingAudit.gd`, commits ou marcadores publicados para a alegada conclusão. Portanto, o relatório não pode encerrar ciclo nem abrir CINE-PAIR-15 como facto operacional.

> Um relatório sem commit verificável, ficheiro de evidência e resultado de validação é uma proposta de trabalho; não é uma entrega nem autorização para parar.

## Contrato obrigatório do Dev4

Dev4 trabalha continuamente como apoio técnico de Dev3, mas nunca fica ocioso à espera de uma alteração visual. Ao terminar uma prova conjunta, deve escolher e iniciar imediatamente a primeira subtarefa independente disponível na fila abaixo.

| Prioridade | Identificador | Trabalho independente Dev4 | Evidência mínima |
| --- | --- | --- | --- |
| 1 | `QA-PACKAGE-01` | Construir ZIP da branch, extrair para directório limpo, abrir pelo menu, activar Novo Jogo e executar 30 segundos | SHA-256, log, captura e commit |
| 2 | `QA-INPUT-01` | Verificar E, pausa, cursor, porta e retorno Orion numa sessão de 30 segundos | Log de input, captura e commit |
| 3 | `QA-BUDGET-01` | Medir luzes visíveis, câmaras activas e alertas de runtime nas cenas principal e Orion | Tabela de contagens, log e commit |
| 4 | `QA-STATE-01` | Confirmar preservação de posição, rotação, saúde e stamina em transições de cena | Telemetria, captura e commit |
| 5 | `QA-ASSET-01` | Verificar importação limpa de recursos referenciados em cenas e autoloads | Relatório de referências e commit |

A fila roda em ordem. Quando houver uma alteração activa de Dev3, Dev4 ajuda nessa mesma prova; quando não houver, executa a primeira tarefa independente pendente. A frase “aguardo o colega”, “CINE-PAIR iniciado” ou equivalente só é válida se o marcador indicar a dependência exacta, a revisão que a contém e a tarefa paralela Dev4 já em execução.

## Registo de inactividade obrigatório

Se Dev4 não puder editar ou validar por uma dependência real, deve publicar no próprio marcador esta estrutura antes de continuar pela fila paralela:

```markdown
- **Motivo objectivo de inactividade:** `<ficheiro, commit, erro ou recurso em falta>`
- **Dependência proprietária:** `<Dev1 / Dev2 / Dev3 e revisão esperada>`
- **Verificação executada:** `<comando, log ou evidência>`
- **Tarefa paralela Dev4 em execução:** `<QA-...>`
- **Hora de nova leitura:** `<UTC>`
```

Não são motivos válidos: espera genérica, fim de auditoria, falta de resposta humana, caminho histórico inexistente quando há checkout actual, ou alegação de conclusão sem publicação no Git.

## Aplicação imediata

A primeira tarefa material de Dev4 é **`QA-PACKAGE-01`**. O seu objectivo é transformar a validação recente de arranque em uma porta de regressão reutilizável do projecto: um script versionado que cria pacote limpo, extrai, executa Menu → Novo Jogo por 30 segundos e falha se surgir `game_paused` nulo, erro de script, recurso ausente ou erro de runtime. Esta tarefa não depende de Dev3 e deve iniciar antes de qualquer novo relatório.
