# Avaliação Meshy — Fontes Oficiais

**Data:** 18 de agosto de 2026  
**Finalidade:** avaliar Meshy como fonte complementar de modelos 3D para o ORIGEM, não como substituto do controlo técnico no Godot.

## Factos verificados

| Tema | Informação oficial relevante | Implicação para ORIGEM |
|---|---|---|
| Geração | Meshy oferece geração 3D a partir de texto e imagens, dirigida também a desenvolvimento de jogos. | Pode acelerar a criação de props heróicos e variantes específicas; não deve ser usado para povoar o mundo sem revisão. |
| Exportação | Exporta GLB, FBX, OBJ, STL, USDZ e 3MF. O GLB embute texturas; FBX/OBJ dependem de ficheiros de textura separados. | **GLB** é o formato piloto preferencial para Godot 4: um único activo portátil, semelhante aos modelos já usados no projecto. |
| Entrada de texturização | A web app aceita FBX, OBJ, STL, glTF e GLB para AI Texturing; limite indicado de 50 MB por modelo. | Poderá enriquecer um modelo de base se as texturas forem verificadas e reduzidas antes da importação Godot. |
| Plano gratuito | Tem 100 créditos/mês, mas a documentação mais recente afirma que utilizadores Free não podem descarregar modelos gerados. | O plano gratuito serve para avaliação visual; não desbloqueia o pipeline de importação do ORIGEM. |
| Licença Free | CC BY 4.0, permite uso comercial com atribuição. | Se modelos Free forem obtidos por campanha/download permitido, a atribuição a Meshy deve constar nos créditos do jogo. |
| Plano pago | A página de preços declara API e propriedade privada dos activos no plano Pro; a ajuda afirma que assinantes pagos detêm os assets, desde que os insumos não violem direitos de terceiros. | Só considerar uma subscrição quando o piloto cumprir métricas Godot; não comprar nem gerar em massa antes da prova local. |

## Fontes oficiais

1. [Meshy — Export & File Formats](https://docs.meshy.ai/en/webapp/guides/platform/export-formats)
2. [Meshy — Pricing & Plans](https://www.meshy.ai/pricing)
3. [Meshy Help — What is included on the Free plan?](https://help.meshy.ai/en/articles/15696428-what-is-included-on-the-free-plan)
4. [Meshy Help — Commercial use and license](https://help.meshy.ai/en/articles/9992001-can-i-use-meshy-assets-commercially-license-copyright-explained)
