# Handoff Dev5→Dev6 — CP-D5-448

## Contrato recebido

O Dev5 entrega ao Dev6 o resultado aprovado do Passe de Fidelidade Cartográfica R1–R6. A autoridade espacial única é `mapaorigem.webp`, consumida pelas âncoras cartográficas existentes. Não devem ser criadas coordenadas alternativas nem duplicada a geometria da interface R6→R7.

| Marco | Âncora | Bounding/critério entregue | Grounding/custo |
|---|---:|---|---|
| Casa Voss | 1 | Casa e corredor cartográfico preservados | Grounding aprovado; 12 colisores; 1 luz existente |
| Ponte Marco 2 | 2 | Travessia modular e clearance `0.21` | Grounding aprovado; 14 colisores; 1 luz existente |
| Floresta Densa | 4 | Passagem mínima `2.4 m`; sem parede de árvores | Grounding aprovado; 20 colisores; 1 luz existente |
| Acampamento Majestic | 5 | Área de pausa e composição vegetal `1/3/4` | Grounding aprovado; 4 colisores; 1 luz existente |
| Ruínas Submersas | 6 | Landmark submerso; emissivo desligado | Grounding aprovado; 18 colisores; 0 luzes dinâmicas no landmark |
| Vegetação Média | 4 | Proxy vegetal associado a R4 | Não bloqueante; 0 colisores; 1 luz existente |

## Requisitos para Dev6

Dev6 pode trabalhar em água, céu, ciclo dia/noite, vegetação, materiais, nevoeiro e atmosfera, mantendo as alterações reversíveis e compatíveis com GL Compatibility/Forward+. Deve preservar escala, pivôs, grounding, navegação e a composição vegetal `1 PBR / 3 medium / 4 distant`. O trabalho não deve introduzir novas OmniLight em produção e deve respeitar o teto de 16 luzes dinâmicas.

A interface R6→R7 está autorizada apenas como contrato de continuidade de escala, direção e navegação. A geometria regional R7–R12 permanece fora do escopo Dev5 deste handoff.

## Evidência

Parser Godot: `PARSER_EXIT=0`. QA headless 36 segundos em 1600×900: `QA_EXIT=124`, encerramento por timeout controlado. Relatório: `CP_D5_448_AUDITORIA_INTEGRADA.md`. Runtime: `CP-D5-448_RUNTIME.log`.
