# CP 222 — Registo de Âncoras Cartográficas

**Branch:** `feature/dev1-gameplay-core`  
**Escopo:** Arquitectura espacial comum; alterações físicas apenas nas Regiões 1–6 e no handoff já autorizado.  
**Contrato aplicado:** `CONTRATO_CARTOGRAFICO_MUNDO_3D.md`.

## Medição espacial

| Relação | Distância medida no mundo |
|---|---:|
| Casa Voss → Arco das Ruínas | 40,34 unidades através da Estrada do Rio |
| Arco das Ruínas → Entrada da Floresta Densa | 68,44 unidades |
| Floresta Densa → Acampamento Majestic | 100,42 unidades de flanco ocidental |
| Acampamento Majestic → Ruínas Submersas | 165,47 unidades através do vale central |
| Ruínas Submersas → Handoff Vila Elevada | 128,06 unidades |

## Alteração

Foi criado `levels/CartographicAnchors.gd`, um registo único com as coordenadas oficiais dos doze marcos do mapa. A Casa Voss e o handoff para a Vila Elevada passam a usar esse registo, eliminando a dependência de números dispersos para os dois extremos do corredor Dev1.

A classe `CartographicAnchors` declara explicitamente Casa Voss, Estrada do Rio, Arco, Floresta, Acampamento, Ruínas Submersas, Vila, Observatório, Trilha, Caverna, Câmara e Hub Temporal. O mapa torna-se assim uma fonte técnica de verdade para futuros módulos, QA e direção cinematográfica.

## Validação

| Prova | Resultado |
|---|---|
| Registo de classe Godot `CartographicAnchors` | Aprovado |
| Arranque headless Godot 4.7.1 | Aprovado |
| Novo Jogo | Aprovado |
| Exploração contínua | 30 segundos aprovados |
| Erros de parser/script | Nenhum |
| Fronteira Regiões 7–12 | Preservada |

## Próximo incremento autónomo

**CP 223 — Leitura cartográfica Casa Voss → Estrada do Rio.** O próximo passe refina o arranque sudoeste para que a saída de Elias revele estrada, rio e arco em ordem visual, sem mover a Casa nem alterar qualquer marco do Dev2.
