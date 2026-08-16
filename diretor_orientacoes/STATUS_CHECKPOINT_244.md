# CP 244 — Margem do Lago sem Lajes de Greybox

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Região 6 — Ruínas Submersas e acesso à margem.

## Auditoria e prioridade

A procura por primitivas nos módulos Dev1 encontrou elementos funcionais e decorativos. A prioridade visual foi a escadaria de chegada ao lago: sete `BoxMesh` eram visíveis no fim do percurso cartográfico e reduziam a leitura natural da margem.

Os elementos funcionais de UI, portas, água, estrada e colisores não foram alterados neste checkpoint.

## Alteração

Cada laje visível da chegada à margem passou a ser um afloramento de rocha orgânica do kit local, com escala, rotação e pequena inclinação alternadas. Os colisores `BoxShape3D` baixos foram mantidos deliberadamente, pois constituem a superfície de travessia estável e não são geometria visível.

| Critério | Resultado |
|---|---|
| Visual | 7 afloramentos de margem orgânicos |
| Percurso físico | 7 colisores estáveis preservados |
| Luzes | Nenhuma luz adicional |
| Marco cartográfico | Ruínas Submersas, ponto 6, preservado |
| Escopo Dev2 | Não alterado |

## Validação

| Prova | Resultado |
|---|---|
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |

## Próximo incremento autónomo

**CP 245 — Passe de integração cartográfica Dev1.** O ciclo seguinte confirmará que todos os pontos 1–6 continuam legíveis física e cartograficamente depois das substituições orgânicas recentes.
