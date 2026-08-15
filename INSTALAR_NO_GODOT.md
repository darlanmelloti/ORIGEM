# Como Instalar os Ficheiros no Godot — Guia Passo a Passo

Siga estes passos para ativar toda a arquitetura do projeto ORIGEM no seu Godot.

---

## PASSO 1 — Copiar os Ficheiros para a Pasta do Projeto

Copie **toda a pasta `ORIGEM_Godot4`** (ou o seu conteúdo) para dentro da pasta do seu projeto Godot existente. Pode fazer isso pelo Explorador de Ficheiros do Windows.

> A pasta do seu projeto Godot é a que contém o ficheiro `project.godot`.

---

## PASSO 2 — Registar os Autoloads no Godot

Este é o passo mais importante. Sem ele, os scripts `EventBus`, `GameManager` e `SaveManager` não funcionam.

1. No Godot, vá ao menu: **Projeto > Definições do Projeto**
2. Clique no separador **Autoloads** (no topo da janela)
3. Adicione os três scripts, um a um:

| Nome (campo "Nome") | Caminho (campo "Caminho") |
| :--- | :--- |
| `EventBus` | `res://_autoloads/EventBus.gd` |
| `GameManager` | `res://_autoloads/GameManager.gd` |
| `SaveManager` | `res://_autoloads/SaveManager.gd` |

Para cada um: clique no ícone de pasta, navegue até ao ficheiro `.gd`, escreva o nome no campo "Nome" e clique em **Adicionar**.

4. Clique em **Fechar**.

---

## PASSO 3 — Abrir a Pasta do Projeto no Windsurf

1. Abra o **Windsurf** (o editor de IA).
2. Clique no botão **"IDE"** no canto superior direito.
3. Vá a **File > Open Folder** e selecione a pasta do seu projeto Godot.
4. O Windsurf vai detetar automaticamente o ficheiro `.windsurfrules` e aplicar as regras do projeto ORIGEM a todas as gerações de código.

---

## PASSO 4 — Testar que Tudo Funciona

1. No Godot, prima **F5** (ou o botão ▶️ Play).
2. Se não houver erros a vermelho no painel "Saída" (em baixo), a instalação foi bem-sucedida.
3. Os Autoloads estão ativos e prontos a ser usados em qualquer script do projeto.

---

## PASSO 5 — Criar o Primeiro Script com a IA

Com o projeto aberto no Windsurf, clique na caixa de chat (onde diz "Plan, Build...") e escreva:

> "Cria o MovementComponent para um CharacterBody3D. Deve suportar andar, correr com Shift e saltar com Espaço. Usa as regras do projeto."

A IA vai gerar o código seguindo todas as regras do projeto ORIGEM automaticamente!

---

## Estrutura de Ficheiros Criados

```
_autoloads/
  EventBus.gd          ← Sistema de sinais globais
  GameManager.gd       ← Estado do jogo e eras temporais
  SaveManager.gd       ← Save/Load com 3 slots

components/
  health/
    HealthComponent.gd ← Vida e dano reutilizável
  interaction/
    InteractableComponent.gd ← Interação com objetos do mundo

core/
  inventory/
    ItemData.gd        ← Estrutura de dados de itens
  quests/
    QuestData.gd       ← Estrutura de dados de missões

.windsurfrules         ← Regras para a IA (aplicadas automaticamente)
README.md              ← Documentação do projeto
```
