# Plano de Integração — Dev2: Região 7 (Vila Elevada) com Métodos Dev1

**Destinatário:** Desenvolvedor 2 (branch `feature/dev2-mountain-canyon`)
**Autor:** Desenvolvedor 1 | **Data:** Agosto 2026
**Referência:** Manual de Alinhamento (`MANUAL_ALINHAMENTO_TODOS_DESENVOLVEDORES.md`)

---

## 1. Ponto de Partida — O que já existe

O Dev1 preparou o handoff na branch `feature/dev1-gameplay-core`. O Dev2 deve clonar ou fazer fetch desta branch para ver os seguintes elementos já criados:

| Nó no TempleLevel.gd | Posição | Função |
|---|---|---|
| `Region7TransitionGate` | z=285–348, x≈140 | Trilho de 12 lajes + portão de pedra |
| `SpawnRegiao7_Dev2_HandoffPoint` | Vector3(140, y, 352) | Ponto exacto de entrada na Região 7 |
| `LuzPortaoR7` | Topo do portão, z=348 | Luz âmbar de sinalização |

O `HighlandRegion.gd` já existe na branch dev2 com `village_x=140, village_z=352`. O Dev2 só precisa de garantir que a Vila Elevada está visível e navegável a partir desse ponto.

---

## 2. Ciclo de Trabalho Obrigatório (igual ao Dev1)

Cada incremento na Região 7 deve seguir estes 10 passos sem excepção:

**Passo 1 — Implementar:** escrever o código GDScript no módulo correcto (`HighlandRegion.gd` ou módulo dedicado à Região 7).

**Passo 2 — Validar headless:** executar o comando abaixo e confirmar que não há erros de sintaxe:
```bash
GODOT_SILENCE_ROOT_WARNING=1 timeout 90 "$GODOT" --headless --path "$ROOT" --editor --quit
```

**Passo 3 — Capturar:** usar `ORIGEM_CAPTURE_TAKE=N xvfb-run...` para capturar o take correspondente à Região 7 (Take 12 em diante).

**Passo 4 — Avaliar:** comparar a captura com a referência visual. Se o resultado for ≥85% do esperado, avançar. Se não, iterar.

**Passo 5 — Gameplay 30s:** executar o roteiro de QA regional com pelo menos 30 segundos de gameplay real na Região 7.

**Passo 6 — Empacotar:** criar o ZIP do projecto com o nome `ORIGEM_V2_RegionalWorld_Phase{NNN}_{Descricao}_Validated.zip`.

**Passo 7 — Commitar:** `git add` + `git commit -m "feat(highland): descrição do incremento"`.

**Passo 8 — Push:** `git push origin feature/dev2-mountain-canyon`.

**Passo 9 — Registar:** criar `STATUS_CHECKPOINT_{NNN}.md` em `diretor_orientacoes/` com a tabela de verificações, SHA-256 do ZIP e próximas prioridades.

**Passo 10 — Avançar:** sem parar, sem pedir autorização. O commit é evidência, não pausa.

---

## 3. Prioridades de Refinamento para a Região 7

Seguindo a mesma lógica de impacto visual que o Dev1 usou nas Regiões 1–6, as prioridades para a Vila Elevada são:

### Prioridade A — Aterramento físico da Vila (equivalente ao CP 155 do Dev1)
A Vila Elevada tem terraços e casas, mas as estruturas podem estar a flutuar. Aplicar o método `_snap_to_terrain()` ou calcular `_height_at(x, z)` para cada elemento antes de posicioná-lo.

### Prioridade B — Iluminação de crepúsculo consistente (equivalente ao CP 149 do Dev1)
A Vila deve usar a mesma paleta de crepúsculo litúrgico das Regiões 1–6: exposição 1.25, luz ambiente 0.98, energia solar 0.70. Verificar que o `LevelEnvironment.gd` já aplica estas definições globalmente — se sim, não é necessário duplicar.

### Prioridade C — Ecologia lateral das ruas (equivalente ao CP 165 do Dev1)
As ruas da Vila devem ter pedras de pavimento com variação de rotação (±0.15 rad), fetos nas margens e pelo menos 2 árvores focais por terraco. Usar os mesmos assets CC0 do Dev1: `rock_moss_set_01.gltf`, `fern_02.gltf`, `island_tree_01.gltf`.

### Prioridade D — Fogueiras e lanternas (equivalente ao CP 183 do Dev1)
Cada terraco da Vila deve ter pelo menos uma fonte de luz diegética: fogueira, lanterna de parede ou braseiro. Usar OmniLight3D com energia ≤1.2 e alcance ≤10m para respeitar o orçamento da GTX 1050 Ti.

### Prioridade E — Estela de chegada (equivalente ao CP 154 do Dev1)
Colocar uma estela interactiva na entrada da Vila (z≈355) com o texto "Vila Elevada — Marco 7". Usar o mesmo padrão de raio físico de interacção (Area3D com raio 2.5m) que o Dev1 usou nas estelas do Acampamento Majestic e do Lago.

---

## 4. Orçamento Técnico para a Região 7

Seguindo as salvaguardas definidas no CP 200:

| Recurso | Limite por Região | Motivo |
|---|---|---|
| Luzes dinâmicas (OmniLight3D) | ≤8 por região | GTX 1050 Ti: ≤16 simultâneas no total |
| Alcance máximo de cada luz | ≤15m | Reduz tiles iluminados por frame |
| Colisores (StaticBody3D) | ≤20 por região | Impacto CPU acima de 60 total |
| SurfaceTool (malhas procedurais) | ≤4 por módulo | Custo de geração em runtime |

---

## 5. Formato de Commit Obrigatório

```
feat(highland): descrição do incremento em português
feat(region7): descrição
docs: record checkpoint NNN descrição
fix(highland): descrição da correcção
```

---

## 6. Ponto de Handoff — O que o Dev2 deve confirmar antes de começar

Antes de escrever qualquer código novo, o Dev2 deve confirmar as seguintes condições:

1. A branch `feature/dev2-mountain-canyon` está actualizada com `git pull origin feature/dev2-mountain-canyon`.
2. O `HighlandRegion.gd` carrega sem erros no headless.
3. O nó `Region7TransitionGate` é visível no editor (vem da branch dev1 via `TempleLevel.gd`).
4. O ponto `Vector3(140, y, 352)` está acessível a pé a partir do portão em z=348.

Se alguma destas condições falhar, reportar ao Diretor antes de avançar.

---

## 7. Referência Rápida de Coordenadas

| Marco | Região | Posição central | Branch |
|---|---|---|---|
| 6 | Ruínas Submersas | Vector3(60, water_y, 252) | dev1 |
| **7** | **Vila Elevada** | **Vector3(140, y, 352)** | **dev2** |
| 8 | Observatório | A definir pelo Dev2 | dev2 |
| 9 | Trilha da Montanha | A definir pelo Dev2 | dev2 |
| 10 | Caverna | A definir pelo Dev2 | dev2 |
| 11 | Câmara do Cube | A definir pelo Dev2 | dev2 |
| 12 | Hub Temporal | A definir pelo Dev2 | dev2 |

O eixo Z cresce para norte. A distância entre marcos deve ser ≥60m para manter a escala estilo Elden Ring definida pelo CEO.
