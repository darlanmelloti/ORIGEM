# CP-D5-016 — Portal remoto da Floresta: rejeitado em QA

**Marco:** 4 — Floresta Densa, âncora `(-9; 116)`.  
**Validação:** parser Godot 4.7.1, sessão QA de 36 segundos e captura interna.  
**Escopo:** `levels/dev5/DenseForestPortalPreview.tscn`; nenhuma alteração em `ForestLakeRegion.gd`.

O candidato remoto cumpriu a passagem central declarada e não tocou produção, mas a captura mostrou troncos cilíndricos expostos, bases cúbicas e barras horizontais visíveis. O conjunto lê como uma armação provisória, não como uma entrada natural de floresta. Também não atinge o padrão de floresta navegável do mapa: a estrutura não cria profundidade orgânica, mas um portão artificial.

A captura interna adicionada neste checkpoint é mantida como suporte QA. O candidato geométrico não deve ser integrado nem receber nova variante com os mesmos troncos e barras. Uma futura proposta de marco 4 deve começar por activos vegetais reais com LOD e dispersão lateral comprovada; nunca por um portal estrutural.

## Continuidade automática

CP-D5-017 fica activo: validar visualmente o candidato técnico de cais das Ruínas Submersas. A falha do portal não permite espera nem repetição.
