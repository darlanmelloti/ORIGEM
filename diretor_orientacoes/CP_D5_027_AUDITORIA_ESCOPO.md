# CP-D5-027 — Auditoria de escopo e dependências QA

## Resultado

A auditoria verificou os previews `DenseForestPortalPreview` e `SubmergedRuinsPierPreview`, além do módulo `CartographicLandmarkObjects.gd`. As referências a `ForestLakeRegion.gd`, `TempleLevel.gd` e `Player.gd` encontradas no repositório estão em documentação, contratos e relatórios; não foram encontradas dependências de runtime desses módulos nos previews pendentes. Os candidatos continuam isolados em `levels/dev5/`.

| Verificação | Resultado |
|---|---|
| Módulos de produção instanciados pelos previews R4/R6 | Nenhum |
| Luzes dinâmicas criadas pelos objectos | Nenhuma; as luzes presentes são exclusivamente `LuzQAForesta`/`LuzQARuinas` dos harnesses |
| Colisores | `StaticBody3D`/`CollisionShape3D` apenas no módulo de landmarks QA, conforme a rota exige |
| Geometrias rejeitadas repetidas | Não |
| Alterações fora de `levels/dev5/` e documentação Dev5 | Não |
| Working tree antes do relatório | Limpo |

As strings de módulos de produção em documentos de continuidade e relatórios são referências de fronteira/escopo, não imports ou instâncias executáveis. A avaliação visual R4/R6 permanece pendente porque o renderer headless não oferece uma imagem de viewport válida; o CP-D5-026 documenta o procedimento para um viewport gráfico.

## Validação

`git diff --check` passou. A auditoria foi realizada sem alterar `ForestLakeRegion.gd`, `TempleLevel.gd`, `Player.gd` ou qualquer módulo regional. O log bruto está em `CP-D5-027_AUDITORIA_ESCoPO.log`.

## Próxima acção

A próxima tarefa pode continuar a trabalhar em auditoria/ficha QA não concorrente, mantendo R4/R6 como candidatos técnicos não promovidos.
