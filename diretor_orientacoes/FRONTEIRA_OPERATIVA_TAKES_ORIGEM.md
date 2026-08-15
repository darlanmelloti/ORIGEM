# ORIGEM — Fronteira Operativa Definitiva

**Versão:** 12 Regiões do Mapa e 22 Takes
**Aplicação imediata:** 15 de agosto de 2026

## Divisão exclusiva entre branches

| Branch | Regiões exclusivas | Takes exclusivos | Conteúdo |
|---|---|---:|---|
| `feature/dev1-gameplay-core` | **1–6** | **1–11** | Casa Voss, prólogo, avô, espada, MJ-12, porta `[E]`, Estrada do Rio, Arco das Ruínas, Floresta Densa, Acampamento Majestic e Ruínas Submersas. |
| `feature/dev2-mountain-canyon` | **7–12** | **12–22** | Vila Elevada, Observatório, Trilha da Montanha, desfiladeiro, Caverna do Orion, Câmara do Cube e Hub Temporal. |

## Regras de integração

A escala do mapa de 12 marcos tem precedência sobre a duração dos takes. A transição de Região 6 para Região 7 é uma **entrega de base**, não uma autorização de edição cruzada. A frente `dev2` herda a base estável entregue pela `dev1`; a frente `dev1` deixa de alterar os módulos de Regiões 7–12 depois deste registo.

As alterações de `HighlandRegion.gd` e `OrionDestinationRegion.gd` existentes no histórico permanecem como referência de integração, mas passam a pertencer exclusivamente à revisão e evolução da `feature/dev2-mountain-canyon`.

## Protocolo obrigatório

| Cadência | Ação obrigatória |
|---|---|
| 10 minutos | Ler `diretor_orientacoes/` no GitHub. |
| 30 minutos ou conclusão de subtarefa | Validar Godot 4.7.1, capturar imagem em alta resolução, executar gameplay de aproximadamente 30 segundos, registar o fecho e fazer push. |
| 20 minutos após novos commits | Direção audita a fidelidade narrativa, técnica e visual. |

> Nenhuma branch modifica módulos, geometrias, takes de câmara ou ativos do bloco exclusivo da outra branch sem uma diretiva de integração explícita da direção.
