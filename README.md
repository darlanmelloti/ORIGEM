# ORIGEM — RPG AAA em Godot 4.x

> *"A descoberta é o elemento principal."*

**ORIGEM** é um RPG de exploração, arqueologia e mistério centrado na evolução da humanidade e nas consequências temporais das ações do jogador. Este repositório contém a fundação técnica do projeto, construída para escalar durante anos.

---

## Arquitetura

O projeto segue uma **Arquitetura Modular baseada em Componentes e Eventos**:

- **Componentes:** Lógica dividida em nós pequenos e reutilizáveis (`HealthComponent`, `MovementComponent`, `InteractableComponent`).
- **EventBus:** Todos os sistemas comunicam através do Autoload `EventBus`, sem referências diretas entre cenas.
- **Custom Resources:** Dados de itens, missões e NPCs definidos como ficheiros `.tres`, editáveis no Inspector do Godot.

---

## Autoloads (Singletons Globais)

| Autoload | Ficheiro | Função |
| :--- | :--- | :--- |
| `EventBus` | `_autoloads/EventBus.gd` | Sinais globais entre sistemas |
| `GameManager` | `_autoloads/GameManager.gd` | Estado global do jogo e eras temporais |
| `SaveManager` | `_autoloads/SaveManager.gd` | Guardar e carregar o progresso |

> **Importante:** Após copiar os ficheiros para o projeto Godot, é necessário registar estes três scripts como Autoloads em `Projeto > Definições do Projeto > Autoloads`.

---

## Estrutura de Pastas

```
res://
├── _autoloads/         → Singletons globais
├── components/         → Componentes reutilizáveis
│   ├── health/
│   ├── movement/
│   └── interaction/
├── core/               → Sistemas centrais
│   ├── inventory/
│   ├── quests/
│   ├── timeline/
│   └── save/
├── entities/           → Entidades do jogo
│   ├── player/
│   ├── npcs/
│   └── enemies/
├── levels/             → Cenas dos mapas e cenários
├── resources/          → Ficheiros .tres (dados de itens, missões, NPCs)
├── ui/                 → Interface do utilizador
│   ├── hud/
│   ├── inventory/
│   ├── dialogue/
│   └── menus/
└── tools/              → Ferramentas do editor (EditorPlugins)
```

---

## Sistemas Implementados

- [x] **EventBus** — Comunicação global por sinais
- [x] **GameManager** — Estado do jogo e sistema de eras temporais
- [x] **SaveManager** — Save/Load com suporte a 3 slots
- [x] **HealthComponent** — Vida e dano reutilizável
- [x] **InteractableComponent** — Interação com o mundo
- [x] **ItemData** — Estrutura de dados de itens (Custom Resource)
- [x] **QuestData** — Estrutura de dados de missões (Custom Resource)
- [ ] MovementComponent (Fase 2)
- [ ] InventoryManager (Fase 2)
- [ ] QuestManager (Fase 2)
- [ ] DialogueSystem (Fase 3)
- [ ] TimelineManager (Fase 3)
- [ ] NPC AI State Machine (Fase 3)

---

## Como Usar a IA (Windsurf / Cursor)

O ficheiro `.windsurfrules` na raiz do projeto define as regras que a IA deve seguir. Ao abrir a pasta do projeto no Windsurf ou Cursor, estas regras são aplicadas automaticamente a todas as gerações de código.

**Exemplo de prompt:**
> "Cria o MovementComponent para um CharacterBody3D com andar, correr e saltar. Segue as regras do projeto."

---

## Equipa Técnica

Arquitetura e implementação inicial: **Manus AI**
Visão e direção criativa: **Darlan Mello**
## Identificação da Branch Dev2

Esta branch também integra o pacote de desenvolvimento das Regiões 7–12 do projecto ORIGEM, incluindo os módulos de Takes 6–8 e as validações auditáveis do Desenvolvedor 2.

