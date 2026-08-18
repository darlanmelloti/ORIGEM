# Referências Dev5

Esta pasta contém as duas referências originais fornecidas pelo CEO para a frente `feature/dev5-cartographic-world-third-person`.

| Ficheiro | Uso permitido | Uso proibido |
|---|---|---|
| `MAP.webp` | Autoridade espacial, sequência de marcos, escala relativa, leitura de rios, pontes, ruínas, acampamento e montanha. | Usar como fundo plano, panorama, billboard, terreno texturizado ou substituto de geometria. |
| `Elias1600x900.jpg` | Direcção de vestuário e silhueta da apresentação 3D inicial de Elias: cabelo escuro, camisa clara, colete castanho, calças escuras, botas e espada lateral. | Aplicar como textura de personagem, usar recorte 2D, alegar que é um modelo rigado ou reutilizar a imagem no mundo 3D. |

O mapa deve ser comparado com `levels/CartographicAnchors.gd`. As âncoras X/Z existentes são a fonte numérica de posicionamento no mundo; a imagem confirma a composição e a leitura, não autoriza a compressão de distâncias reais.

Todo activo 3D futuro deve ser criado como geometria tridimensional real e guardado em `assets/models_dev5/` com a sua licença, origem, contagem aproximada de triângulos e materiais documentados no checkpoint correspondente.
