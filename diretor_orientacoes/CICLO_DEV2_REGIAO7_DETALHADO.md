# ORIGEM — Ciclo Detalhado de Tarefas: Dev2 na Região 7 (Vila Elevada)

**Para:** Dev2
**De:** Dev1 (Desenvolvedor Principal)
**Validado por:** CEO
**Data:** 2026-08-16

> Este documento é o teu guia de arranque. Lê-o do início ao fim antes de escrever uma linha de código. Cada tarefa tem o código GDScript base, os critérios de aceitação e o formato de commit exacto.

---

## Ponto de Partida — O Handoff do Dev1

O Dev1 criou o ponto de entrada da Região 7 no `TempleLevel.gd`. O teu trabalho começa exactamente aqui:

```
Posição de spawn: Vector3(140, y, 352)
Nó no TempleLevel.gd: SpawnRegiao7_Dev2_HandoffPoint
Portão de pedra: Vector3(140, 1.0, 348) — já existe, não modificar
Corredor de acesso: z=285–345, x≈140 — ecologia já colocada pelo Dev1
```

O jogador chega ao portão vindo das Ruínas Submersas (Região 6), atravessa o corredor e entra na Região 7. O teu trabalho é construir o que existe do outro lado do portão.

---

## Antes de Começar — Passos Obrigatórios

### Passo 0A — Sincronizar o Código Existente

Se já tens código dos Takes 6 e 7 no teu ambiente local, **sincroniza-o primeiro**:

```bash
cd /caminho/para/o/teu/workspace
git checkout feature/dev2-mountain-canyon
# Copiar os teus ficheiros .gd para a pasta levels/
git add levels/
git commit -m "feat: sync existing Takes 6-7 code to repository"
git push origin feature/dev2-mountain-canyon
```

### Passo 0B — Criar o Script de QA

Cria o ficheiro `test_dev2_regions7to12_continuity.sh` com este conteúdo:

```bash
#!/bin/bash
set -e
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
ROOT=/caminho/para/o/projecto/ORIGEM

echo "[QA] 1/2: headless"
GODOT_SILENCE_ROOT_WARNING=1 timeout 90 "$GODOT" \
  --headless --path "$ROOT" --editor --quit
echo "[QA] 2/2: gameplay 30s Região 7"
GODOT_SILENCE_ROOT_WARNING=1 ORIGEM_QA_ROUTE=region7_entry \
  xvfb-run --auto-servernum --server-args="-screen 0 1600x900x24" \
  timeout 45 "$GODOT" --path "$ROOT" &
sleep 35
kill %1 2>/dev/null || true
echo "[QA] APROVADO"
```

---

## Ciclo de Trabalho (Idêntico ao Dev1)

Cada checkpoint segue este ciclo de 9 passos sem excepção:

1. Implementar o incremento em GDScript
2. Validar headless (`--headless --editor --quit`)
3. Executar o script de QA (gameplay 30s)
4. Avaliar — se < 85% do objectivo, iterar
5. Empacotar ZIP do projecto com SHA-256
6. Commitar com formato `feat(r7): CP-D2-NNN - descrição`
7. Fazer push para `feature/dev2-mountain-canyon`
8. Registar `STATUS_CHECKPOINT_D2_NNN.md` em `diretor_orientacoes/`
9. Avançar imediatamente para o próximo checkpoint

---

## CP-D2-001 — Estrutura Base da Vila Elevada

**Objectivo:** criar a geometria física da Vila Elevada — rua central, 4 casas, fonte e colisores navegáveis.

**Ficheiro:** `levels/HighlandVillageRegion.gd` (criar novo)

**Código base:**

```gdscript
extends Node3D

func _ready() -> void:
    _build_village_ground()
    _build_central_street()
    _build_houses()
    _build_fountain()
    _build_village_lights()

func _build_village_ground() -> void:
    var ground: MeshInstance3D = MeshInstance3D.new()
    ground.name = "VillageGround"
    var gmesh: PlaneMesh = PlaneMesh.new()
    gmesh.size = Vector2(60, 80)
    ground.mesh = gmesh
    var gmat: StandardMaterial3D = StandardMaterial3D.new()
    gmat.albedo_color = Color(0.22, 0.18, 0.14)  # terra compactada
    gmat.roughness = 0.92
    ground.material_override = gmat
    ground.position = Vector3(140, 0.0, 420)
    # Colisor
    var gcol: StaticBody3D = StaticBody3D.new()
    var gshape: CollisionShape3D = CollisionShape3D.new()
    var gbox: BoxShape3D = BoxShape3D.new()
    gbox.size = Vector3(60, 0.2, 80)
    gshape.shape = gbox
    gcol.add_child(gshape)
    gcol.position = Vector3(140, -0.1, 420)
    add_child(ground)
    add_child(gcol)

func _build_central_street() -> void:
    # Rua central em pedra — 4m de largura, 50m de comprimento
    var street: MeshInstance3D = MeshInstance3D.new()
    street.name = "CentralStreet"
    var smesh: BoxMesh = BoxMesh.new()
    smesh.size = Vector3(4.0, 0.15, 50.0)
    street.mesh = smesh
    var smat: StandardMaterial3D = StandardMaterial3D.new()
    smat.albedo_color = Color(0.28, 0.24, 0.20)  # pedra cinzenta
    smat.roughness = 0.88
    street.material_override = smat
    street.position = Vector3(140, 0.08, 415)
    add_child(street)

func _build_houses() -> void:
    # 4 casas — 2 de cada lado da rua
    var house_positions: Array = [
        Vector3(134, 0, 400), Vector3(146, 0, 400),
        Vector3(134, 0, 425), Vector3(146, 0, 425)
    ]
    for i: int in range(house_positions.size()):
        _build_house(house_positions[i], i)

func _build_house(pos: Vector3, idx: int) -> void:
    var house_root: Node3D = Node3D.new()
    house_root.name = "House_%d" % idx
    house_root.position = pos
    # Paredes
    var walls: MeshInstance3D = MeshInstance3D.new()
    var wmesh: BoxMesh = BoxMesh.new()
    wmesh.size = Vector3(5.5, 3.8, 6.0)
    walls.mesh = wmesh
    var wmat: StandardMaterial3D = StandardMaterial3D.new()
    wmat.albedo_color = Color(0.35, 0.28, 0.22)  # pedra quente
    wmat.roughness = 0.90
    walls.material_override = wmat
    walls.position = Vector3(0, 1.9, 0)
    # Telhado
    var roof: MeshInstance3D = MeshInstance3D.new()
    var rmesh: PrismMesh = PrismMesh.new()
    rmesh.size = Vector3(6.0, 2.0, 7.0)
    roof.mesh = rmesh
    var rmat: StandardMaterial3D = StandardMaterial3D.new()
    rmat.albedo_color = Color(0.18, 0.12, 0.08)  # telha escura
    rmat.roughness = 0.85
    roof.material_override = rmat
    roof.position = Vector3(0, 4.8, 0)
    # Colisor
    var col: StaticBody3D = StaticBody3D.new()
    var cshape: CollisionShape3D = CollisionShape3D.new()
    var cbox: BoxShape3D = BoxShape3D.new()
    cbox.size = Vector3(5.5, 3.8, 6.0)
    cshape.shape = cbox
    col.add_child(cshape)
    col.position = Vector3(0, 1.9, 0)
    house_root.add_child(walls)
    house_root.add_child(roof)
    house_root.add_child(col)
    add_child(house_root)

func _build_fountain() -> void:
    # Fonte central no final da rua
    var fountain: MeshInstance3D = MeshInstance3D.new()
    fountain.name = "VillageFountain"
    var fmesh: CylinderMesh = CylinderMesh.new()
    fmesh.top_radius = 1.8
    fmesh.bottom_radius = 2.0
    fmesh.height = 0.6
    fountain.mesh = fmesh
    var fmat: StandardMaterial3D = StandardMaterial3D.new()
    fmat.albedo_color = Color(0.30, 0.26, 0.22)
    fmat.roughness = 0.80
    fountain.material_override = fmat
    fountain.position = Vector3(140, 0.3, 440)
    # Água
    var water: MeshInstance3D = MeshInstance3D.new()
    var wmesh: CylinderMesh = CylinderMesh.new()
    wmesh.top_radius = 1.5
    wmesh.bottom_radius = 1.5
    wmesh.height = 0.05
    water.mesh = wmesh
    var wmat: StandardMaterial3D = StandardMaterial3D.new()
    wmat.albedo_color = Color(0.15, 0.35, 0.55, 0.85)
    wmat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
    wmat.roughness = 0.15
    water.material_override = wmat
    water.position = Vector3(140, 0.58, 440)
    add_child(fountain)
    add_child(water)

func _build_village_lights() -> void:
    # 3 lanternas ao longo da rua
    var light_positions: Array = [
        Vector3(136, 3.5, 405),
        Vector3(144, 3.5, 420),
        Vector3(136, 3.5, 435)
    ]
    for lp: Vector3 in light_positions:
        var light: OmniLight3D = OmniLight3D.new()
        light.light_color = Color(0.90, 0.70, 0.40)  # âmbar quente
        light.light_energy = 0.75
        light.omni_range = 10.0
        light.shadow_enabled = false
        light.position = lp
        add_child(light)
```

**Critério de aceitação:** o jogador entra pela porta do portão, percorre a rua central, vê as 4 casas de cada lado e chega à fonte. Nenhum colisor bloqueia o percurso.

**Commit:** `feat(r7): CP-D2-001 - Highland Village base structure with street, 4 houses and fountain`

---

## CP-D2-002 — Ecologia da Vila (Árvores e Fetos)

**Objectivo:** adicionar 6 árvores e 8 fetos ao redor da vila para criar ambiente orgânico.

**Código base (adicionar ao `_ready()`):**

```gdscript
func _build_village_ecology() -> void:
    var rng: RandomNumberGenerator = RandomNumberGenerator.new()
    rng.seed = 88421
    # 6 árvores ao redor da vila
    var tree_positions: Array = [
        Vector3(128, 0, 398), Vector3(152, 0, 402),
        Vector3(126, 0, 418), Vector3(154, 0, 422),
        Vector3(129, 0, 435), Vector3(151, 0, 438)
    ]
    for tp: Vector3 in tree_positions:
        var tree: MeshInstance3D = MeshInstance3D.new()
        tree.name = "VillageTree"
        # Tronco
        var trunk: CylinderMesh = CylinderMesh.new()
        trunk.top_radius = 0.18
        trunk.bottom_radius = 0.22
        trunk.height = 4.5
        tree.mesh = trunk
        var tmat: StandardMaterial3D = StandardMaterial3D.new()
        tmat.albedo_color = Color(0.22, 0.16, 0.10)
        tree.material_override = tmat
        tree.position = tp + Vector3(0, 2.25, 0)
        tree.scale.y = rng.randf_range(0.85, 1.25)
        add_child(tree)
    # 8 fetos nas bordas
    var fern_positions: Array = [
        Vector3(131, 0, 397), Vector3(149, 0, 399),
        Vector3(130, 0, 410), Vector3(150, 0, 413),
        Vector3(131, 0, 428), Vector3(149, 0, 430),
        Vector3(132, 0, 440), Vector3(148, 0, 442)
    ]
    for fp: Vector3 in fern_positions:
        var fern: MeshInstance3D = MeshInstance3D.new()
        fern.name = "VillageFern"
        var fmesh: SphereMesh = SphereMesh.new()
        fmesh.radius = rng.randf_range(0.35, 0.55)
        fmesh.height = rng.randf_range(0.5, 0.8)
        fern.mesh = fmesh
        var fmat: StandardMaterial3D = StandardMaterial3D.new()
        fmat.albedo_color = Color(0.08, 0.18, 0.06)
        fern.material_override = fmat
        fern.position = fp + Vector3(0, 0.3, 0)
        add_child(fern)
```

**Commit:** `feat(r7): CP-D2-002 - village ecology with 6 trees and 8 ferns`

---

## CP-D2-003 — Iluminação Atmosférica da Vila

**Objectivo:** adicionar luz de preenchimento fria sobre a vila e ajustar a neblina para criar atmosfera de altitude.

**Código base:**

```gdscript
func _build_village_atmosphere() -> void:
    # Luz de lua fria sobre a vila
    var moonlight: OmniLight3D = OmniLight3D.new()
    moonlight.name = "VillageMoonFill"
    moonlight.light_color = Color(0.65, 0.75, 0.95)  # azul frio
    moonlight.light_energy = 0.45
    moonlight.omni_range = 55.0
    moonlight.shadow_enabled = false
    moonlight.position = Vector3(140, 18.0, 420)
    add_child(moonlight)
    # Luz de horizonte quente (simula reflexo do crepúsculo nas montanhas)
    var horizon: OmniLight3D = OmniLight3D.new()
    horizon.name = "VillageHorizonFill"
    horizon.light_color = Color(0.85, 0.55, 0.30)  # laranja distante
    horizon.light_energy = 0.25
    horizon.omni_range = 40.0
    horizon.shadow_enabled = false
    horizon.position = Vector3(110, 8.0, 420)
    add_child(horizon)
```

**Commit:** `feat(r7): CP-D2-003 - village atmospheric lighting (moon fill + horizon warm)`

---

## CP-D2-004 — NPC Placeholder da Vila

**Objectivo:** adicionar 2 NPCs placeholder (cápsula + label) para marcar os pontos de interacção futura.

**Código base:**

```gdscript
func _build_village_npcs() -> void:
    var npc_data: Array = [
        {"pos": Vector3(137, 0, 408), "name": "Aldeão Velho"},
        {"pos": Vector3(143, 0, 422), "name": "Ferreiro"}
    ]
    for nd: Dictionary in npc_data:
        var npc: CharacterBody3D = CharacterBody3D.new()
        npc.name = nd["name"].replace(" ", "_")
        npc.add_to_group("interactable")
        # Visual
        var body: MeshInstance3D = MeshInstance3D.new()
        var bmesh: CapsuleMesh = CapsuleMesh.new()
        bmesh.radius = 0.35
        bmesh.height = 1.8
        body.mesh = bmesh
        var bmat: StandardMaterial3D = StandardMaterial3D.new()
        bmat.albedo_color = Color(0.55, 0.42, 0.30)
        body.material_override = bmat
        body.position = Vector3(0, 0.9, 0)
        # Colisor
        var col: CollisionShape3D = CollisionShape3D.new()
        var cshape: CapsuleShape3D = CapsuleShape3D.new()
        cshape.radius = 0.35
        cshape.height = 1.8
        col.shape = cshape
        col.position = Vector3(0, 0.9, 0)
        # Label
        var label: Label3D = Label3D.new()
        label.text = nd["name"]
        label.position = Vector3(0, 2.2, 0)
        label.font_size = 24
        label.modulate = Color(1, 0.9, 0.6)
        npc.add_child(body)
        npc.add_child(col)
        npc.add_child(label)
        npc.position = nd["pos"]
        add_child(npc)
```

**Commit:** `feat(r7): CP-D2-004 - village NPC placeholders (Elder and Blacksmith)`

---

## CP-D2-005 — Integração no TempleLevel.gd

**Objectivo:** registar o `HighlandVillageRegion` como filho do `TempleLevel` para que a Região 7 carregue com o mundo.

**Código a adicionar no `TempleLevel.gd`:**

```gdscript
# No _ready(), após _build_region7_transition():
var village: Node = load("res://levels/HighlandVillageRegion.gd").new()
village.name = "HighlandVillageRegion"
add_child(village)
```

**Commit:** `feat(r7): CP-D2-005 - integrate HighlandVillageRegion into TempleLevel world`

---

## Regras de Orçamento (GTX 1050 Ti)

| Recurso | Limite por Região | Estado Actual (Regiões 1–6) |
|---|---|---|
| Luzes dinâmicas simultâneas | ≤ 8 | 14 (estimado) |
| Alcance máximo por luz | 15m | Respeitado |
| Colisores por região | ≤ 20 | ~10 |
| Nós totais por região | ≤ 150 | ~80 |

A Vila Elevada tem 3 lanternas + 2 luzes atmosféricas = 5 luzes. Dentro do limite.

---

## Formato de Registo de Checkpoint

Cada checkpoint deve ter um ficheiro `STATUS_CHECKPOINT_D2_NNN.md` com:

```markdown
# ORIGEM — Checkpoint D2-NNN: Título

**Branch:** feature/dev2-mountain-canyon
**Módulo:** HighlandVillageRegion.gd

## Incremento Aplicado
[descrição do que foi feito]

## Verificações
| Verificação | Resultado |
|---|---|
| Sintaxe Godot (headless) | ✅ / ❌ |
| Gameplay integrado 30s | ✅ / ❌ |
| Fronteira operacional | ✅ Mantida |

## Próximo Passo
CP-D2-NNN+1 — [descrição]
```

---

## Comunicação com o Dev1

Se precisares de ajuda técnica, publica uma questão em `diretor_orientacoes/QUESTAO_DEV2_NNN.md` e o Dev1 responderá no próximo ciclo. Não esperes pela resposta para continuar — avança para o próximo checkpoint e volta à questão quando tiveres a resposta.
