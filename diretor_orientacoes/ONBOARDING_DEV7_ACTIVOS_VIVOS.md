# Onboarding — Dev7: Activos Vivos e Construções 3D

## Função

Dev7 cria e mantém a biblioteca de fauna, plantas, ruínas, abrigos e construções ambientais. Cada activo deve ser tridimensional real, leve, reutilizável, aterrável por raycast, com LOD, colisor adequado e licença documentada. Dev7 não altera módulos regionais R1–R6, R7–R12, `Player.gd` ou a porta de Casa Voss; Dev1/Dev6 promovem activos à produção.

## Git e orientações

| Item | Referência |
|---|---|
| Repositório | `https://github.com/darlanmelloti/ORIGEM.git` |
| Branch | Criar `feature/dev7-living-assets` a partir de `feature/dev5-cartographic-world-third-person` actualizada |
| Workspace | `/home/ubuntu/ORIGEM_dev7_living_assets` |
| Pasta de orientação | `diretor_orientacoes/` |
| Marcador | `diretor_orientacoes/CONTINUIDADE_DEV7.md` |
| Biblioteca | `assets/models_dev5/`, `assets/models_cc0/`, `levels/dev5/` |

## Tarefa inicial

**DEV7-001:** criar duas variações de ruína lateral modular e uma variação de fauna ambiental para R3/R6. Documentar origem/licença, pivot, LOD, colisor, grounding e executar preview Godot de 36 segundos. Não criar cais de lajes, arco estrutural ou portal florestal.

## Ciclo de criação obrigatório

1. Ler o marcador Dev7 e executar a primeira tarefa aberta.
2. Criar activo/preview pequeno, reversível e com licença registada.
3. Validar parser, grounding e 36 segundos de cena/captura.
4. Publicar activo, evidência e relatório de LOD/licença.
5. Após **10 segundos**, sincronizar Git e consultar `diretor_orientacoes/`.
6. Se houver tarefa nova, executá-la imediatamente. Se não houver, não parar: seleccionar a primeira acção permitida, actualizar o marcador e iniciar.

> A consulta aos 10 segundos é sincronização; nunca é autorização para pausa.

**Escada:** corrigir importação/pivot/licença/LOD → criar variação para marco menos coberto → criar fauna ou construção modular → validar em QA → preparar e iniciar o item seguinte.
