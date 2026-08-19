# Fonte CC0 aprovada — Substituição Majestic

## Activo

**Medieval Village MegaKit [Standard]**, de Quaternius. O pacote gratuito disponibiliza peças modulares em glTF e é declarado pelo autor como utilizável em projectos pessoais, educativos e comerciais sob CC0.

- Página: https://quaternius.itch.io/medieval-village-megakit
- Formato de integração: `glTF`
- Arquivo obtido localmente: `Medieval Village MegaKit[Standard].zip`
- Conteúdo local de análise: `assets/models_dev7/medieval_village_cc0/Medieval Village MegaKit[Standard]/glTF/`

## Construção Majestic proposta

A substituição deve ser um **abrigo de pedra e madeira parcialmente colapsado**, montado por componentes, e não uma casa completa ou um pavilhão simétrico. A composição inicial usa:

| Função | Peças CC0 candidatas |
|---|---|
| Fundação | `Floor_UnevenBrick.gltf` e `Floor_Brick.gltf` |
| Parede sobrevivente | variantes `Wall_*Brick*` ou `Wall_*WoodDark*` |
| Entrada degradada | `DoorFrame_Round_Brick.gltf` sem porta fechada |
| Cobertura parcial | `Roof_RoundTiles_4x4.gltf` e `Roof_FrontSupports.gltf` |
| Colapso lateral | módulo de telhado rodado e afastado, sem bloquear a rota |

## Regras de integração

1. Importar apenas as peças e texturas efectivamente usadas; não versionar o ZIP de 153 MB.
2. Preservar o corredor R4→R5 com **mínimo 5,2 m livres**.
3. Aplicar `CartographicGroundingSystem.gd`; X/Z não podem mudar.
4. O abrigo deve ficar lateral ao percurso e nunca no centro da clareira.
5. Máximo de uma luz dinâmica adicional; preferir luz ambiente e materiais.
6. Executar parser Godot e 36 segundos de QA antes de qualquer proposta ao Dev1.
7. Se a leitura voltar a ser protótipo, rejeitar e escolher outra combinação modular; não promover.

## Próxima tarefa Dev7

**DEV7-002 — Montar e validar o abrigo colapsado CC0 do Acampamento Majestic em cena QA isolada.**

A conclusão abre imediatamente DEV7-003: comparação visual com o candidato procedural rejeitado, sem espera passiva.

## Referência de licença

A página oficial declara licença CC0 e compatibilidade glTF: https://quaternius.itch.io/medieval-village-megakit
