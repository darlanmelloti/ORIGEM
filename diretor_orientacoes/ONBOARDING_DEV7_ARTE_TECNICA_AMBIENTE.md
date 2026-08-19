# Onboarding — Dev7: Arte Técnica de Ambiente

## Missão

Dev7 transforma os candidatos QA validados em **ambiente de produção visualmente coerente** para as Regiões 1–6. O foco é terreno, materiais PBR, água, nevoeiro, iluminação, LOD e integração de vegetação/ruínas, mantendo o mapa cartográfico como autoridade espacial.

## Repositório e orientação

| Item | Referência |
|---|---|
| Git | `https://github.com/darlanmelloti/ORIGEM.git` |
| Branch de trabalho | Criar `feature/dev7-environment-art` a partir de `feature/cine07-final` actualizada |
| Workspace recomendado | `/home/ubuntu/ORIGEM_dev7_environment_art` |
| Orientações obrigatórias | `diretor_orientacoes/CONTINUIDADE_DEV7.md` e `diretor_orientacoes/PROTOCOLO_CONTINUIDADE_ACTIVA_DEV7.md` |
| Fonte de integração Dev5 | `diretor_orientacoes/CP_D5_095_INTEGRACAO_MAPA_VIVO_R1_R6.md` |
| Godot | 4.7.1, `opengl3/gl_compatibility` |

## Escopo exclusivo

Dev7 pode editar materiais, configuração atmosférica, terreno, água, vegetação e ruínas dos módulos **R1–R6** apenas depois de criar um commit isolado e reversível. Dev7 não altera R7–R12, `Player.gd`, a porta de Casa Voss, regras de combate ou câmaras narrativas sem coordenação explícita.

| Prioridade | Entrega de produção |
|---|---|
| 1 | Integrar a Estrada do Rio viva R2 segundo `CP_D5_096_FICHA_INTEGRACAO_R2.md` |
| 2 | Integrar a Floresta Densa viva R4 segundo `CP_D5_097_FICHA_INTEGRACAO_R4.md` |
| 3 | Refinar Majestic e Ruínas: materiais húmidos, margem orgânica, neblina e leitura de marcos |
| 4 | Converter candidatos Dev5 restantes em integração controlada R1, R3, R5 e R6 |

## Regras visuais e técnicas

O mundo deve manter geometria tridimensional real. Não usar outdoors, árvores em parede, portais florestais estruturais, cais de lajes rejeitado ou arco estrutural. Respeitar os limites: um pinheiro PBR focal, três árvores detalhadas em plano médio, seis árvores leves em plano distante e um feto por lado do trilho. O orçamento global não pode ultrapassar 16 luzes dinâmicas simultâneas.

## Ciclo contínuo obrigatório

1. Ler `CONTINUIDADE_DEV7.md` e iniciar a primeira tarefa aberta.
2. Alterar um único marco por commit reversível.
3. Executar parser Godot, gameplay/captura de pelo menos 36 segundos e avaliação visual.
4. Publicar commit, captura e relatório curto.
5. Após **10 segundos**, sincronizar o Git e consultar o marcador.
6. Se existir tarefa nova, executá-la imediatamente. Se não existir, **não parar**: escolher a primeira acção permitida da escada abaixo, actualizar o marcador e iniciar.

> A verificação após 10 segundos serve apenas para sincronização. Ela nunca é autorização para ficar parado.

### Escada de contingência Dev7

1. Corrigir regressão de terreno, água, rota, material ou luzes.
2. Integrar o próximo candidato Dev5 já validado.
3. Refinar material/LOD do marco com menor qualidade visual.
4. Produzir composição QA antes de tocar produção.
5. Auditar orçamento GTX 1050 Ti e preparar a tarefa seguinte.

## Primeira tarefa activa

**DEV7-001 — Integração controlada R2.** Criar um commit reversível que integre a ponte modular, fauna afastada e vegetação de margem segundo a ficha CP-D5-096. Validar `road_to_arch` por 36 segundos, confirmar a água e não usar a ponte GLB rejeitada.
