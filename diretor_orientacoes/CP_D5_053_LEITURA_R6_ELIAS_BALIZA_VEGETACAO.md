# CP-D5-053 — Leitura R6: Elias, baliza e vegetação ribeirinha

**Escopo:** cena QA isolada em `levels/dev5/`. Não altera `Player.gd`, módulos regionais, água, mapa UI ou o candidato de cais rejeitado.

## Objectivo

Comprovar que a margem das Ruínas Submersas pode reunir, em leitura técnica, a baliza monolítica, Elias em terceira pessoa e vegetação lateral mínima sem bloquear o corredor cartográfico e sem converter a composição numa plataforma de lajes.

| Elemento | Contrato testado | Resultado |
|---|---|---|
| Baliza monolítica | X/Z `(52,260)`, ajuste apenas em Y | Aterrado; zero lajes de cais |
| Elias | Corredor `X=60`, câmara externa exclusiva | Aprovado; dois ciclos sem bloqueio |
| Folga | Mínimo `4,00 m` | `6,05 m` confirmado |
| Vegetação | 1 árvore leve e 1 feto por lado | 3/3 aterrados; corredor aberto |
| Luzes | Uma direccional QA | 1/1; zero Omni/Spot |
| Produção | Dev1/Dev2 protegidos | 0 alterações |

## Validação

O parser Godot 4.7.1 passou. A cena executou 36 segundos, completou dois ciclos de passagem, preservou X/Z nos quatro candidatos aterrados e gerou captura interna. A câmara interna da apresentação de Elias permaneceu inactiva; a `CameraQAR6Leitura` foi a proprietária da viewport.

A leitura mantém carácter **técnico QA**. Embora confirme separação espacial e contratos físicos, não promove a baliza, a vegetação ou Elias ao mundo de produção. A eventual integração permanece sob decisão do Dev1 e requer gameplay regional de pelo menos 30 segundos.

## Próxima tarefa automática

**CP-D5-054 — Comparativo técnico R5/R6.** Produzir uma folha de comparação dos dois cenários QA, destacando diferenças de folga, densidade vegetal, coordenadas, câmara e condições de reversão para acelerar a decisão Dev1.
