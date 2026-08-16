# ORIGEM — Manual de Alinhamento para Todos os Desenvolvedores

**Emitido por:** Desenvolvedor Principal (branch `feature/dev1-gameplay-core`)

**Destinatários:** Desenvolvedor 2 (`feature/dev2-mountain-canyon`), Diretor e qualquer futuro colaborador do projeto.

**Data:** 2026-08-16

**Autoridade:** Este documento foi aprovado pelo CEO do projeto e representa o padrão de trabalho obrigatório para toda a equipa.

---

## 1. O Problema Identificado

Após auditar a branch `feature/dev2-mountain-canyon`, a comparação com a branch `feature/dev1-gameplay-core` revela uma diferença estrutural significativa:

| Métrica | Dev1 (`feature/dev1-gameplay-core`) | Dev2 (`feature/dev2-mountain-canyon`) |
|---|---|---|
| Total de commits | 123 | 14 |
| Ficheiros `.gd` na branch | 15+ módulos regionais | 0 ficheiros de código |
| Checkpoints documentados | 182–193 (numerados e auditáveis) | 2 takes (6 e 7) sem numeração |
| Validação headless por ciclo | Obrigatória e registada | Não documentada sistematicamente |
| Gameplay de 30 s por ciclo | Obrigatório e registado | Executado mas sem registo padronizado |
| Pacote ZIP reproduzível | Gerado em cada checkpoint | Ausente |
| Fronteira operacional | Respeitada rigorosamente | Respeitada mas sem verificação explícita |

O Desenvolvedor 2 produziu trabalho real (Takes 6 e 7 com evidências visuais), mas o modelo de trabalho está desalinhado: faltam ficheiros de código na branch, os checkpoints não seguem numeração contínua, e não existe o ciclo sistemático de validação que garante que cada incremento é testável e reversível.

---

## 2. O Modelo de Trabalho Obrigatório (baseado no Dev1)

Todo o desenvolvedor deve seguir este ciclo sem exceção. Não existe autorização para pausar entre etapas.

### 2.1 O Ciclo de Checkpoint

Cada unidade de trabalho é um **Checkpoint** numerado sequencialmente (CP 1, CP 2, … CP 193, …). Um checkpoint não termina enquanto todas as etapas abaixo não estiverem concluídas:

```
1. IMPLEMENTAR  → editar o ficheiro .gd relevante
2. VALIDAR      → executar a validação headless (sem erros de parse)
3. CAPTURAR     → tirar print ou gravar 30 s de gameplay
4. AVALIAR      → comparar visualmente com o objetivo
5. ITERAR       → se < 85% do objetivo, voltar ao passo 1
6. PRESERVAR    → gerar o pacote ZIP com SHA-256
7. COMMITAR     → git add + git commit com mensagem padronizada
8. SINCRONIZAR  → git push para a branch correta
9. REGISTAR     → escrever STATUS_CHECKPOINT_NNN.md em diretor_orientacoes/
10. AVANÇAR     → iniciar o próximo checkpoint sem esperar confirmação
```

O commit é uma **evidência**, não um ponto de paragem. Após o push, o desenvolvedor avança imediatamente para o próximo incremento.

### 2.2 Comandos de Validação Obrigatórios

Estes comandos devem ser executados em cada ciclo, nesta ordem:

```bash
# 1. Validação headless (obrigatória — deve terminar sem Parse Error)
ROOT=$(cat /home/ubuntu/origem_v2_root.txt)
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
GODOT_SILENCE_ROOT_WARNING=1 timeout 90 "$GODOT" --headless --path "$ROOT" --editor --quit

# 2. Gameplay integrado de 30 segundos (obrigatório)
/home/ubuntu/test_checkpoint143_regions1to6_continuity.sh   # Dev1
# Dev2 deve criar o equivalente para as Regiões 7–12

# 3. Captura do take relevante (obrigatória)
ORIGEM_CAPTURE_TAKE=N xvfb-run ...   # onde N é o take do incremento atual
```

Se a validação headless falhar, o código não pode ser commitado. O desenvolvedor deve corrigir antes de avançar.

### 2.3 Formato Obrigatório do Commit

```
tipo(escopo): descrição concisa em minúsculas

Exemplos corretos:
  feat(forest): enlarge focal canopy trees for visual variety
  feat(lighting): add take-9 corridor fill light for panoramic legibility
  feat(arch): add base rocks at ruin arch pillars for archaeological read
  docs: record checkpoint 193 arch base rocks and session summary

Tipos permitidos:
  feat    → nova funcionalidade ou elemento visual
  fix     → correção de erro
  refactor → reorganização sem mudança de comportamento
  docs    → documentação, registo de checkpoint, orientações
  perf    → otimização de desempenho
```

### 2.4 Formato Obrigatório do STATUS_CHECKPOINT_NNN.md

Cada checkpoint deve ter um ficheiro de registo em `diretor_orientacoes/` com esta estrutura:

```markdown
# ORIGEM — Checkpoint NNN: [Título do Incremento]

**Branch:** `feature/dev?-nome-da-branch`
**Escopo preservado:** [Regiões e Takes da branch]
**Commit de implementação:** `hash` — `mensagem`

## Incremento aplicado
[Descrição em prosa do que foi feito e porquê]

## Verificações
| Verificação | Evidência | Resultado |
|---|---|---|
| Sintaxe Godot | Editor headless 4.7.1 | Aprovado / Reprovado |
| Take N | nome_do_ficheiro.png | Descrição visual |
| Gameplay 30 s | Roteiro integrado | Aprovado / Reprovado |
| Fronteira operacional | Ficheiros alterados | Mantida / VIOLADA |

## Preservação
Pacote: `/home/ubuntu/ORIGEM_V2_RegionalWorld_PhaseNNN_Titulo_Validated.zip`
SHA-256: `hash`

## Próximas prioridades
[Lista das 2–3 próximas melhorias por ordem de impacto]
```

---

## 3. Fronteira Operacional — Regra Intransponível

A divisão de responsabilidades entre branches é **absoluta e não negociável**:

| Branch | Escopo exclusivo | Ficheiros proibidos |
|---|---|---|
| `feature/dev1-gameplay-core` | Regiões 1–6, Takes 1–11 | `HighlandRegion.gd`, `OrionDestinationRegion.gd`, Takes 12–22 |
| `feature/dev2-mountain-canyon` | Regiões 7–12, Takes 12–22 | `ForestLakeRegion.gd`, `RiverRoadJourney.gd`, `DaylightValley.gd`, Takes 1–11 |

Em cada commit, o desenvolvedor deve verificar explicitamente que nenhum ficheiro fora do seu escopo foi modificado. Esta verificação deve constar no `STATUS_CHECKPOINT_NNN.md` na linha "Fronteira operacional".

---

## 4. Estrutura de Ficheiros Obrigatória na Branch

Cada branch deve conter, no mínimo, esta estrutura:

```
/levels/
  ├── [Módulos regionais da branch]   ← ficheiros .gd com o código do jogo
/diretor_orientacoes/
  ├── FRONTEIRA_OPERATIVA.md          ← define o escopo da branch
  ├── STATUS_CHECKPOINT_NNN.md        ← um ficheiro por checkpoint
  └── MANUAL_ALINHAMENTO_*.md         ← este documento e outros manuais
/docs/
  └── [Documentação técnica]
```

**Problema crítico identificado na branch dev2:** a pasta `levels/` não existe e não há ficheiros `.gd` na branch. Isto significa que o código dos Takes 6 e 7 existe apenas no ambiente local do Desenvolvedor 2 e não foi sincronizado com o repositório. **Esta situação deve ser corrigida imediatamente.**

---

## 5. Ação Imediata Exigida ao Desenvolvedor 2

O Desenvolvedor 2 deve executar os seguintes passos antes de continuar qualquer trabalho novo:

**Passo 1 — Sincronizar o código existente:**
```bash
cd /caminho/para/o/projeto
# Copiar os ficheiros de levels para o workspace
cp levels/HighlandRegion.gd /caminho/workspace/levels/
cp levels/OrionDestinationRegion.gd /caminho/workspace/levels/
# (e todos os outros ficheiros .gd das Regiões 7–12)

cd /caminho/workspace
git add levels/
git commit -m "feat(dev2): sync existing levels code for takes 6-7"
git push origin feature/dev2-mountain-canyon
```

**Passo 2 — Criar o roteiro de QA integrado para as Regiões 7–12:**
```bash
# Equivalente ao test_checkpoint143_regions1to6_continuity.sh do Dev1
# Deve validar: headless + gameplay 30s das Regiões 7–12
```

**Passo 3 — Renumerar os checkpoints:**
O Desenvolvedor 2 deve adoptar a numeração contínua a partir do próximo número disponível (actualmente CP 194 está reservado para o Dev1; o Dev2 pode usar uma série paralela como CP 2001, CP 2002, etc., para evitar colisões).

**Passo 4 — Adoptar o ciclo completo a partir do próximo incremento:**
Cada novo take (Take 8, Take 9, …) deve seguir o ciclo de 10 passos descrito na Secção 2.1.

---

## 6. Como Trabalhar em Paralelo Sem Conflitos

Para que os dois desenvolvedores trabalhem em simultâneo sem se bloquearem mutuamente:

**Regra de não-interferência:** Nenhum desenvolvedor toca nos ficheiros do outro. Se for necessário partilhar um utilitário (ex: `LevelEnvironment.gd`, `TempleLevel.gd`), a alteração deve ser proposta ao Diretor que coordena a integração na branch `main`.

**Cadência de sincronização:** Cada desenvolvedor faz push pelo menos uma vez por ciclo de 30 minutos. O Diretor audita os commits em segundo plano e deixa feedback em `diretor_orientacoes/` sem bloquear o desenvolvimento.

**Resolução de conflitos:** Se dois desenvolvedores modificarem o mesmo ficheiro partilhado, o Diretor resolve o merge na branch `main`. Os desenvolvedores nunca fazem merge entre as suas branches directamente.

---

## 7. Referência Rápida — O Que o Dev1 Faz em Cada Ciclo

Para que o Desenvolvedor 2 possa replicar o modelo, aqui está a sequência exacta que o Dev1 executa em cada checkpoint:

```
1. Ler diretor_orientacoes/ para verificar prioridades
2. Identificar o incremento de maior impacto visual dentro do escopo
3. Editar o ficheiro .gd relevante (ex: ForestLakeRegion.gd)
4. Executar: GODOT --headless --path ROOT --editor --quit
5. Se houver Parse Error → corrigir e repetir o passo 4
6. Executar o script de captura do take relevante (ex: test_checkpoint116_cinematic_take3.sh)
7. Visualizar o PNG gerado e avaliar: está ≥ 85% do objetivo?
8. Se não → iterar; se sim → avançar
9. Executar o roteiro integrado de 30 segundos
10. Gerar o ZIP: zip -rq OUT ROOT -x "*/.godot/*"
11. git add + git commit + git push
12. Escrever STATUS_CHECKPOINT_NNN.md
13. git add + git commit + git push (docs)
14. Avançar imediatamente para o próximo incremento
```

Este ciclo repete-se continuamente, sem pausas para autorização. O CEO deu autorização permanente para todos os desenvolvedores executarem este ciclo de forma autónoma.

---

## 8. Mensagem Directa ao Desenvolvedor 2

O trabalho que fizeste nos Takes 6 e 7 tem valor — as evidências visuais mostram que o ambiente foi construído e testado. O problema não é a qualidade do trabalho, é o modelo de entrega.

O repositório é a única fonte de verdade do projeto. Se o código não está no GitHub, para o projeto não existe. A tua prioridade imediata é sincronizar tudo o que está no teu ambiente local para a branch `feature/dev2-mountain-canyon`, seguindo o formato de commit e documentação descrito neste manual.

A partir daí, cada novo incremento deve seguir o ciclo de 10 passos. O Diretor está disponível para coordenar, mas não para bloquear — o desenvolvimento é contínuo.

---

*Este documento é a referência de trabalho para toda a equipa do projeto ORIGEM. Qualquer dúvida deve ser registada em `diretor_orientacoes/` na branch respectiva.*
