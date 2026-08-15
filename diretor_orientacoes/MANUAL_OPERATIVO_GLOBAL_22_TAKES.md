# ORIGEM — Manual Operativo Global Aplicado

**Versão:** Definitiva — 12 Regiões do Mapa e 22 Takes
**Aplicação:** 15 de agosto de 2026
**Estado:** Registado para coordenação entre branches.

## Autoridade espacial e narrativa

O mapa oficial de doze marcos é a autoridade da escala explorável. A sequência cinematográfica de 22 takes define a apresentação narrativa, mas nenhum take substitui a continuidade física do mundo. A progressão parte da Casa Voss, atravessa o rio, o arco, a floresta, o acampamento e o lago, e só depois avança para a ascensão, a montanha e o complexo temporal.

| Região do mapa | Marco | Takes / capítulos associados | Responsável |
|---:|---|---|---|
| 1 | Casa Voss | 1–8 | `feature/dev1-gameplay-core` |
| 2 | Estrada do Rio | 9–10 | `feature/dev1-gameplay-core` |
| 3 | Arco das Ruínas | 10 | `feature/dev1-gameplay-core` |
| 4 | Floresta Densa | 11 | `feature/dev1-gameplay-core` |
| 5 | Acampamento Majestic | 11 | `feature/dev1-gameplay-core` |
| 6 | Ruínas Submersas | 11 | `feature/dev1-gameplay-core` |
| 7 | Vila Elevada | 12–16 | `feature/dev2-mountain-canyon` |
| 8 | Observatório | 15–16 | `feature/dev2-mountain-canyon` |
| 9 | Trilha da Montanha | 17 | `feature/dev2-mountain-canyon` |
| 10 | Caverna do Orion | 18–19 | `feature/dev2-mountain-canyon` |
| 11 | Câmara do Orion Cube | 20–21 | `feature/dev2-mountain-canyon` |
| 12 | Hub Temporal | 22 | `feature/dev2-mountain-canyon` |

## Bloco exclusivo da branch principal

A frente `feature/dev1-gameplay-core` é responsável por **Regiões 1–6 e Takes 1–11 corrigidos**. O seu escopo cobre a fundação interativa da Casa Voss, memória do avô, espada, visitantes de Majestic/MJ-12, resposta da espada, saída por porta interativa `[E]`, Estrada do Rio, Arco das Ruínas, bifurcação inicial da floresta, Acampamento Majestic e Ruínas Submersas.

O objetivo técnico é entregar um prólogo jogável e um vale lacustre fisicamente contínuo, com leitura alpina e desempenho adequado à GTX 1050. O arco deve constituir uma fronteira de luz e sombra; a floresta deve introduzir fetos, raízes, pedras húmidas e sinais P-0; o lago deve conter pilares antigos e indícios temporais discretos.

## Bloco exclusivo da nova frente

A frente `feature/dev2-mountain-canyon` herda a base consolidada e é responsável por **Regiões 7–12 e Takes 12–22**. Este bloco compreende Vila Elevada, Observatório, Trilha da Montanha, desfiladeiro, fissuras, Caverna do Orion, Galeria das Três Eras, Câmara do Orion Cube e Hub Temporal.

As alterações históricas realizadas em `HighlandRegion.gd` e `OrionDestinationRegion.gd` permanecem como referência de base até revisão da nova frente, mas a branch principal não deve criar, modificar ou expandir esses módulos após este manual.

## Cadência de execução obrigatória

| Frequência | Regra |
|---|---|
| A cada 10 minutos | Ler `diretor_orientacoes/` no GitHub antes de continuar o desenvolvimento. |
| A cada 30 minutos ou fim de subtarefa | Validar no Godot 4.7.1, capturar imagem em alta resolução, executar gameplay com cerca de 30 segundos e fazer commit/push na branch própria. |
| A cada 20 minutos após commits | A direção audita narrativa, imagem, estabilidade e aderência à divisão de trabalho. |

> **Limite inegociável:** a branch principal não altera módulos, geometria, câmaras ou ativos das Regiões 7–12. A nova frente não altera módulos, geometria, câmaras ou ativos das Regiões 1–6, salvo correção de integração explicitamente coordenada.
