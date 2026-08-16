# Ordem Correctiva Dev2 — CP-D2-004

**Branch:** `feature/dev2-mountain-canyon`  
**Âmbito exclusivo:** Regiões 7–12, do ponto de handoff da Vila Elevada ao Hub Temporal.

## Auditoria CP 249

O commit `7d3dda9` colocou `levels/CartographicAnchors.gd` na branch Dev2, mas os módulos `HighlandRegion.gd` e `OrionDestinationRegion.gd` ainda não consultam esse registo. A topologia dos marcos 7–12, portanto, continua com coordenadas dispersas no código. A auditoria também encontrou **25 declarações de luzes** nesses dois módulos, acima do orçamento de segurança para a GTX 1050 Ti se as zonas forem observadas em conjunto.

| Requisito | Estado actual | Acção obrigatória |
|---|---|---|
| Registo de âncoras presente | Sim | Preservar |
| Uso de âncoras nos módulos Dev2 | Não | Integrar no CP-D2-004 |
| Ordem espacial 7→12 | Parcialmente codificada | Centralizar nos marcos oficiais |
| Luzes declaradas | 25 | Reduzir visibilidade simultânea para no máximo 12 |

## Implementação obrigatória

No início de `HighlandRegion.gd` e `OrionDestinationRegion.gd`, carregar o registo comum:

```gdscript
const CARTOGRAPHIC_ANCHORS = preload("res://levels/CartographicAnchors.gd")
```

Aplicar as posições por meio das âncoras oficiais, preservando offsets locais apenas quando forem necessários para a geometria:

```gdscript
var village_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.VILA_ELEVADA
var observatory_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.OBSERVATORIO
var trail_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.TRILHA_MONTANHA
var cave_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.CAVERNA_ORION
var chamber_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.CAMARA_ORION
var hub_anchor: Vector2 = CARTOGRAPHIC_ANCHORS.HUB_TEMPORAL
```

A sequência espacial obrigatória é:

> **Vila Elevada (7) → Observatório (8) → Trilha da Montanha (9) → Caverna do Orion (10) → Câmara do Orion Cube (11) → Hub Temporal (12).**

O Hub Temporal é uma transição temporal autorizada e não deve ser tratado como continuação terrestre directa da Câmara.

## Orçamento de iluminação

As luzes comuns de vila, estelas e marcos não podem ser criadas dentro de ciclos de pilares, casas ou adereços. Separar a criação de arquitectura da criação de luzes. Para uma câmara na Vila Elevada, manter no máximo:

| Grupo | Máximo simultâneo |
|---|---:|
| Lua/horizonte | 2 |
| Praça, forja e fonte | 4 |
| Estelas e marcos activos | 3 |
| Passagem de rota | 3 |
| **Total** | **12** |

## Evidência de aceitação

O Dev2 deve concluir, sem esperar aprovação intermédia:

1. validação headless Godot 4.7.1;
2. gameplay de 30 segundos na Vila Elevada;
3. gameplay de 30 segundos na rota Observatório→Trilha;
4. captura de cada percurso;
5. relatório `STATUS_CP_D2_004.md` e push;
6. início imediato do CP-D2-005, com Caverna do Orion ancorada ao marco 10.

A equipa Dev1 não deve editar estes módulos. Esta ordem é autónoma e não altera o limite operacional entre as branches.
