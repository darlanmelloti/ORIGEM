# Onboarding — Dev6: Arte Técnica de Ambiente

## Função

Dev6 é responsável por transformar os candidatos QA validados em qualidade visual de produção nas Regiões 1–6: terreno, materiais PBR, água, nevoeiro, iluminação, LOD, vegetação e integração controlada de ruínas. Não altera R7–R12, `Player.gd`, a porta de Casa Voss ou combate.

## Git e orientações

| Item | Referência |
|---|---|
| Repositório | `https://github.com/darlanmelloti/ORIGEM.git` |
| Branch | Criar `feature/dev6-environment-art` a partir de `feature/cine07-final` actualizada |
| Workspace | `/home/ubuntu/ORIGEM_dev6_environment_art` |
| Pasta de orientação | `diretor_orientacoes/` |
| Marcador | `diretor_orientacoes/CONTINUIDADE_DEV6.md` |
| Referências Dev5 | `CP_D5_095_INTEGRACAO_MAPA_VIVO_R1_R6.md`, fichas R1–R6 e previews Dev5 |

## Tarefa inicial

**DEV6-001:** integrar a Estrada do Rio viva R2 de forma reversível, a partir de `CP_D5_096_FICHA_INTEGRACAO_R2.md`. Validar `road_to_arch` durante 36 segundos, preservar água, ponte funcional e leitura do Arco.

## Ciclo de criação obrigatório

1. Ler o marcador Dev6 e executar a primeira tarefa aberta.
2. Trabalhar um marco por commit reversível; validar parser, captura e 36 segundos de gameplay.
3. Publicar commit, evidência e próximo estado.
4. Após **10 segundos**, sincronizar Git e consultar `diretor_orientacoes/`.
5. Se houver tarefa nova, executá-la imediatamente. Se não houver, não parar: escolher a primeira acção da escada abaixo, actualizar o marcador e iniciar.

> A consulta aos 10 segundos é sincronização; nunca é autorização para pausa.

**Escada:** regressão técnica → integrar candidato Dev5 validado → melhorar material/LOD do marco menos polido → composição QA → auditoria GTX 1050 Ti.
