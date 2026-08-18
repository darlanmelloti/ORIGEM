# ORIGEM — Funções da Equipa e Delegação de Tarefas Paralelas

**Repositório:** `darlanmelloti/ORIGEM`
**Data:** 2026-08-16
**Autoridade:** CEO (Darlan Melloti)

> Somos todos desenvolvedores. Cada membro tem autonomia total para executar o seu ciclo contínuo sem parar para pedir autorização. O commit é evidência, não pausa.

---

## Estrutura da Equipa

| Membro | Papel | Branch | Escopo Exclusivo |
|---|---|---|---|
| **Dev1 (Desenvolvedor Principal)** | Arquitectura, motor de jogo, Regiões 1–6 | `feature/dev1-gameplay-core` | Regiões 1–6, Takes 1–11, módulos: VossHouse, RiverRoadJourney, ForestLakeRegion, DaylightValley, LevelEnvironment, TempleLevel, RegionalCinematicDirector |
| **Dev2 (Desenvolvedor de Montanha)** | Regiões 7–12, combate avançado, puzzles temporais | `feature/dev2-mountain-canyon` | Regiões 7–12, Takes 12–22, módulos: HighlandRegion, OrionDestinationRegion e novos módulos das Regiões 8–12 |
| **Dev03 (Diretor Cinematográfico)** | Takes cinematográficos, câmaras, composição visual, cutscenes | `feature/dev1-gameplay-core` (leitura) + PR para main | RegionalCinematicDirector.gd — Takes 1–11 já existentes; propor novos ângulos e transições |
| **Dev5 (Mundo Cartesiano e Elias 3.ª Pessoa)** | Objectos 3D adicionais do mapa, biblioteca de activos e apresentação isolada de Elias | `feature/dev5-cartographic-world-third-person` | Só novos módulos em `levels/dev5/`, `assets/models_dev5/` e `entities/player/third_person/`; não editar R1–R6 existentes nem R7–R12 sem integração aprovada |
| **Diretor Geral** | Coordenação, briefings, auditoria de qualidade, comunicação CEO | Todas as branches (leitura) | `diretor_orientacoes/` — publicar briefings, validar entregas, coordenar integrações |

---

## Dev1 — Desenvolvedor Principal

### Função

O Dev1 é o arquitecto do motor de jogo. É responsável por toda a lógica procedural das Regiões 1–6, pela estabilidade do projecto Godot 4.7.1, pelo orçamento técnico (GTX 1050 Ti) e pela ponte de integração com as Regiões 7–12.

### Ciclo de Trabalho (não negociável)

1. Implementar incremento (GDScript)
2. Validar headless (`--headless --editor --quit`)
3. Executar gameplay integrado de 30 segundos
4. Avaliar — se < 85% do objectivo, iterar
5. Empacotar ZIP com SHA-256
6. Commitar com formato `feat(escopo): descrição`
7. Fazer push para `feature/dev1-gameplay-core`
8. Registar `STATUS_CHECKPOINT_NNN.md` em `diretor_orientacoes/`
9. Avançar imediatamente para o próximo incremento

### Próximas Tarefas (por ordem de prioridade)

- **CP 211** — Refinamento da neblina atmosférica (`LevelEnvironment.gd`): densidade 0.0022→0.0018, cor ligeiramente azulada para profundidade de campo
- **CP 212** — Variação de escala XZ das coníferas (±15%) para quebrar a uniformidade de silhueta
- **CP 213** — Luz de luar fria no Acampamento Majestic (SpotLight3D descendente, 0.3 energia, azul frio)
- **CP 214** — Pedras de travessia na Ponte de Pedra do Vale (3 pedras visíveis acima do nível da água)
- **CP 215** — Auditoria de colisores: verificar que nenhum colisor bloqueia o trilho principal

---

## Dev2 — Desenvolvedor de Montanha

### Função

O Dev2 é responsável pelas Regiões 7–12 — o interior da montanha, a caverna, a câmara do Cubo de Orion e o Hub Temporal. O seu trabalho começa exactamente no ponto de handoff definido pelo Dev1: `Vector3(140, y, 352)` (nó `SpawnRegiao7_Dev2_HandoffPoint` no `TempleLevel.gd`).

### Ciclo de Trabalho (idêntico ao Dev1)

O Dev2 deve adoptar o mesmo ciclo de 9 passos do Dev1. A numeração de checkpoints sugerida é **CP-D2-001, CP-D2-002**, etc., para evitar colisão com a numeração do Dev1.

### Próximas Tarefas (por ordem de prioridade)

- **CP-D2-001** — Sincronizar o código existente dos Takes 6 e 7 para a branch `feature/dev2-mountain-canyon`
- **CP-D2-002** — Criar o script de QA integrado para as Regiões 7–12 (equivalente ao `test_checkpoint143_regions1to6_continuity.sh`)
- **CP-D2-003** — Vila Elevada (Região 7): estrutura física com casas, rua central, fonte e 2 NPCs placeholder
- **CP-D2-004** — Observatório (Região 8): plataforma elevada, telescópio procedural, luz de estrelas
- **CP-D2-005** — Trilha da Montanha (Região 9): percurso físico com colisores, pedras e neblina densa

### Regras de Orçamento

- Máximo 8 luzes dinâmicas simultâneas por região
- Alcance máximo de cada luz: 15m
- Nenhum ficheiro das Regiões 1–6 pode ser tocado

---

## Dev03 — Diretor Cinematográfico

### Função

O Dev03 é responsável pela direcção visual e cinematográfica do projecto. O seu trabalho é estudar o estado actual das Regiões 1–6 (já construídas pelo Dev1), propor melhorias de composição nos Takes 1–11, e criar novos takes cinematográficos que contem a história de ORIGEM de forma imersiva.

### Como Começar (Autonomia Total)

1. **Ler o estado actual** — consultar `diretor_orientacoes/STATUS_CHECKPOINT_210.md` e `AUDITORIA_COMPLETA_ORIGEM_CEO.md` para entender o que foi construído
2. **Estudar os takes existentes** — ler `RegionalCinematicDirector.gd` para ver as posições e FOVs dos Takes 1–11
3. **Propor melhorias** — identificar takes com composição fraca e propor novos ângulos
4. **Implementar** — editar `RegionalCinematicDirector.gd` directamente na branch `feature/dev1-gameplay-core` (com PR ou commit directo conforme autorização do CEO)
5. **Validar** — capturar o take antes e depois, comparar, iterar

### Próximas Tarefas (por ordem de impacto)

- **CINE-001** — Rever o Take 1 (Casa Voss): a câmara actual está demasiado afastada; propor enquadramento mais íntimo que mostre a vela na mesa e a luz do pórtico
- **CINE-002** — Novo Take 1B (interior da Casa Voss): câmara dentro da casa, olhando para a porta aberta com o crepúsculo ao fundo
- **CINE-003** — Rever o Take 3 (Floresta Densa): aumentar o FOV de 52° para 58° para mostrar mais copas e criar sensação de floresta densa
- **CINE-004** — Novo Take 10B (fogueira próxima): câmara a 3m da fogueira do Acampamento Majestic, olhando para o lago ao fundo
- **CINE-005** — Estudar técnicas de câmara do Elden Ring (posição elevada, ângulo de 15–20° descendente) e aplicar nos takes das Ruínas Submersas

### Referência de Trabalho

```
# Formato de um take no RegionalCinematicDirector.gd
"1": {
    "position": Vector3(-22, 4.5, 14),
    "target": Vector3(-22, 1.5, 8),
    "fov": 52.0,
    "label": "Casa Voss — Prólogo"
}
```

---

## Dev5 — Mundo Cartesiano e Elias em Terceira Pessoa

### Função

O Dev5 acelera a conversão do mapa cartográfico em mundo jogável, criando objectos 3D reais e desacoplados que reforçam a leitura dos marcos sem substituir geometria regional existente. Também mantém a apresentação isolada de **Elias** em terceira pessoa, orientada pela referência fornecida pelo CEO. A imagem é uma referência artística; o substituto final exige um GLB humano rigado e licenciado.

### Escopo e integração

O Dev5 cria apenas novos ficheiros em `levels/dev5/`, `assets/models_dev5/`, `entities/player/third_person/`, `references/dev5/` e os seus marcadores em `diretor_orientacoes/`. Não edita `Player.gd`, `TempleLevel.gd`, `ForestLakeRegion.gd`, `RiverRoadJourney.gd`, `VossHouse.gd`, `CartographicAnchors.gd`, `ui/menus/` nem módulos R7–R12 na primeira fase. A integração é feita por pedido de pull ou cherry-pick para a branch cinematográfica depois de parser Godot, 30 segundos de gameplay/captura e avaliação visual.

### Fila contínua

- **CP-D5-001** — consolidar `CartographicLandmarkObjects.gd` e o orçamento de objectos.
- **CP-D5-002** — ponte de pedra tridimensional do marco 2, em módulo isolado, com colisores próprios e zero luzes.
- **CP-D5-003** — apresentação `EliasThirdPersonPresentation`, sem substituir o controlador actual.
- **CP-D5-004** — cena QA de Elias em terceira pessoa no marco 1, sem afectar Casa Voss, porta E, salto ou stamina.
- **CP-D5-005** — integrar um GLB humano rigado apenas se licenciado, recuperável, até 10 MB e dentro do orçamento GTX 1050 Ti.

A instrução detalhada, os anexos e os checksums estão em `ONBOARDING_DEV5_MUNDO_CARTESIANO.md`, `CONTINUIDADE_DEV5.md` e `references/dev5/README.md`.

---

## Diretor Geral

### Função

O Diretor Geral coordena a equipa sem bloquear o desenvolvimento. O seu papel é auditar, orientar e comunicar — nunca aprovar antes de executar.

### Responsabilidades

- Publicar briefings de novas funcionalidades em `diretor_orientacoes/` antes de cada sprint
- Auditar os STATUS_CHECKPOINT de cada developer e responder com feedback em 24h
- Coordenar a integração das branches dev1 e dev2 na branch `main` quando ambas estiverem estáveis
- Comunicar ao CEO o estado semanal do projecto
- Resolver conflitos de fronteira operacional (ex.: Take 6 que estava na dev1 mas pertence à dev2)

### Próximas Tarefas

- **DIR-001** — Resolver o Take 6 no `RegionalCinematicDirector.gd` da branch dev1 (coordenadas z=462–535 estão fora do escopo dev1; transferir para dev2 ou remover)
- **DIR-002** — Preparar o briefing da Região 7 (Vila Elevada) para o Dev2: referências visuais, escala, NPCs, atmosfera
- **DIR-003** — Definir os critérios de aceitação para a integração das branches dev1 + dev2 na `main`
- **DIR-004** — Rever o MANUAL_ALINHAMENTO_TODOS_DESENVOLVEDORES.md e confirmar que o Dev2 e o Dev03 o leram

---

## Regras Gerais (Não Negociáveis)

Qualquer tarefa só é aceite após validação técnica e pelo menos 30 segundos de gameplay real ou captura de cena. Se o resultado não atingir 85% do solicitado, continuar a iterar. O commit é evidência, não pausa. Ninguém pede autorização para continuar — consulta-se o `diretor_orientacoes/` a cada 10 minutos e avança-se.

---

## Comunicação entre Membros

Toda a comunicação técnica é feita através da pasta `diretor_orientacoes/` no repositório. Cada membro deve:

- Publicar um `STATUS_CHECKPOINT_NNN.md` após cada incremento
- Ler os documentos dos outros membros antes de iniciar uma nova tarefa
- Nunca modificar ficheiros fora do seu escopo sem autorização explícita do Diretor Geral ou do CEO
