# ORIGEM — Piloto Meshy CP-CARTO-81

**Decisão:** o Meshy é **útil como fonte complementar de props focais**, mas não deve substituir a composição, o terreno procedural, as árvores de massa ou a validação física do ORIGEM.

## Por que é útil

A plataforma pode gerar um modelo 3D a partir de texto ou imagem e exportar GLB, FBX, OBJ, STL, USDZ, 3MF e `.blend`. Para Godot, o formato preferencial é **GLB**, pois inclui as texturas no próprio ficheiro, evitando referências perdidas que ocorrem com conjuntos FBX/OBJ separados. [1]

O ganho real para o ORIGEM está em acelerar peças singulares: marcos de percurso, restos de ruína, esculturas quebradas, pequenas estruturas do acampamento ou relicários. Não é uma solução adequada para preencher centenas de árvores, relva ou rochas: esses elementos requerem repetição controlada, LOD e materiais consistentes com a GTX 1050 Ti.

## Limitação prática importante

O plano Free oferece 100 créditos mensais, mas a documentação actual indica que **não permite descarregar os modelos gerados**. Ele serve para avaliar silhueta e conceito; a importação efectiva requer uma descarga obtida por plano pago, campanha que conceda download ou conta já elegível. [2]

> Modelos do plano Free usam CC BY 4.0 e exigem atribuição; planos pagos conferem propriedade privada dos activos criados, condicionada à legalidade dos materiais de entrada. [3]

## Piloto escolhido: Estela de Direcção Majestic

| Campo | Especificação |
|---|---|
| Função no mundo | Marco tridimensional da bifurcação Floresta → Acampamento Majestic, reforçando a orientação X/Z recém-validada sem criar painel 2D. |
| Local de ensaio | Região 4–5, junto ao conector físico de `z≈178`, sem tocar no caminho de Elias. |
| Formato de exportação | GLB com texturas embutidas. |
| Orçamento de ficheiro | Máximo de 4 MB antes da importação Godot. |
| Geometria alvo | Até 15 mil triângulos, uma malha principal, sem rig, sem animação e sem partículas. |
| Texturas | PBR 1K; reduzir para 512 px se a captura revelar pressão de VRAM ou detalhe imperceptível. |
| Instanciação | Uma instância focal; nenhuma duplicação de massa até existir LOD manual e teste de desempenho. |
| Licença | Registar origem, prompt, data, plano e exigência de atribuição nos créditos do jogo. |

### Prompt de geração recomendado

```text
Single watertight game prop, ancient ruined stone wayfinding stele for a dark alpine fantasy world. A weathered vertical monolith, 2.4 metres tall, irregular broken top, subtle carved spiral and a shallow non-readable compass motif, damp moss in crevices, dark granite and muted grey-brown stone. Grounded broad base, asymmetrical silhouette readable from 25 metres, no text, no letters, no symbols from existing games, no background, no character, no foliage, no particles. Optimized low-poly game asset with clean UVs, PBR albedo normal roughness metallic textures, one mesh, one material set, real 3D geometry, export as GLB.
```

## Porta de entrada no Godot

1. Descarregar o GLB para `assets/models_generated/meshy/` e preservar o ficheiro original.
2. Confirmar que texturas, materiais, escala, pivô e orientação foram importados correctamente.
3. Medir tamanho do ficheiro, número de materiais e nós; rejeitar se exceder o orçamento definido.
4. Inserir **somente no harness QA** do conector Majestic, aterrado pelo `TerrainPatch` e fora da cápsula do jogador.
5. Validar no Godot 4.7.1, Menu → Novo Jogo e sessão real de 36 segundos em 1600×900.
6. Promover para produção apenas se a leitura do desvio melhorar pelo menos 85%, sem regressão de navegação, luzes ou estética.

## Referências

[1] [Meshy Docs — Export & File Formats](https://docs.meshy.ai/en/webapp/guides/platform/export-formats)  
[2] [Meshy Help — What is included on the Free plan?](https://help.meshy.ai/en/articles/15696428-what-is-included-on-the-free-plan)  
[3] [Meshy Help — Commercial use and license](https://help.meshy.ai/en/articles/9992001-can-i-use-meshy-assets-commercially-license-copyright-explained)
