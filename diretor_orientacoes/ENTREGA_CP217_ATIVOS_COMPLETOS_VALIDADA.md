# ORIGEM — Entrega CP 217: Activos Completos Validados

## Incidente corrigido

O pacote CP 216 excluiu indevidamente os recursos em `assets/textures/generated/`. Isso retirou `regional_wet_forest_floor.png`, uma textura pré-carregada por `TerrainPatch.gd`, e bloqueou a acção **Novo Jogo** durante a importação.

## Regra de empacotamento corrigida

O CP 217 inclui todos os ficheiros do projecto e exclui apenas caches transitórias `.godot/` e metadados `.git/`. Nenhuma textura, modelo, áudio ou recurso de jogo pode ser excluído de futuras entregas sem uma auditoria de referências.

| Controlo | Resultado |
|---|---|
| Referências locais ausentes no projecto-fonte | 0 |
| `regional_wet_forest_floor.png` no ZIP | Presente |
| Modelos e texturas geradas no ZIP | Presentes |
| Importação numa pasta limpa | Aprovada |
| Novo Jogo na cópia extraída | Aprovado |
| Exploração contínua na cópia extraída | 30 segundos aprovados |

> O pacote CP 217 é a primeira distribuição testada depois de extracção limpa. O CEO deve importar apenas este ZIP numa pasta nova no Godot 4.7.1.
