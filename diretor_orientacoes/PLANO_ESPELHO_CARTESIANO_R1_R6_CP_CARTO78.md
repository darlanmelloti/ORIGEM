# ORIGEM — Plano de Espelhamento Cartesiano R1–R6

**Checkpoint de abertura:** CP-CARTO-78  
**Escopo:** apenas Regiões 1–6 — Casa Voss, Estrada do Rio, Arco das Ruínas, Floresta Densa, Acampamento Majestic e Ruínas Submersas.  
**Fronteira:** não editar módulos, activos, câmaras ou geometria das Regiões 7–12.

## Objectivo

O mapa oficial deixa de ser somente uma imagem de consulta. As suas âncoras passam a governar a **posição física**, a **sequência de leitura visual** e a **orientação do percurso** no mundo 3D. Uma localização só é considerada espelhada quando o jogador, ao viajar no plano cartesiano X/Z, encontra o marco equivalente no mapa e consegue ler o próximo destino sem depender de painéis, outdoors ou teletransporte.

> Convenção canónica: **X negativo = oeste; X positivo = este; Z crescente = norte**. Todas as distâncias futuras devem ser justificadas por `CartographicAnchors.gd`, não por conveniência visual.

## Malha espacial canónica R1–R6

| Marco | Âncora 3D X/Z | Papel espacial | Próxima leitura obrigatória |
|---:|---:|---|---|
| 1 — Casa Voss | `(-22.0, 8.0)` | Origem sudoeste e saída para o vale | Estrada do Rio a norte |
| 2 — Estrada do Rio | `(-21.4, 12.0)` | Corredor inicial com água a leste | Arco das Ruínas no eixo norte |
| 3 — Arco das Ruínas | `(-16.741, 48.0)` | Primeiro marco arquitectónico | Entrada da Floresta Densa |
| 4 — Floresta Densa | `(-9.0, 116.0)` | Corredor profundo e transição de escala | Desvio ocidental Majestic |
| 5 — Acampamento Majestic | `(-88.0, 178.0)` | Ponto opcional a oeste, não um bloqueio | Retorno à rota para as Ruínas |
| 6 — Ruínas Submersas | `(60.0, 252.0)` | Bacia/lago e limiar para R7 | Passagem futura Vila Elevada |

A ordem de caminhada não deve comprimir as separações macro. Em particular, o deslocamento **Floresta → Majestic → Ruínas** deve continuar a mostrar a divergência para oeste e a reconvergência para leste, tal como a geometria das âncoras exige.

## Passes propostos

| Passo | Entregável técnico | Critério de aceitação |
|---|---|---|
| **CP-CARTO-78 — Régua cartográfica** | Harness QA que regista posição X/Z, marco mais próximo, próximo marco e distância real durante as rotas R1–R6 existentes. Não modifica geometria de produção. | Parser Godot, uma sessão de 36 s por corredor relevante e logs que concordem com as âncoras. |
| **CP-CARTO-79 — Leituras de horizonte** | Matriz de enquadramentos para cada transição: o marco seguinte deve ocupar uma posição visual coerente com o vetor cartesiano sem transformar assets em outdoor. | Capturas 1600×900 e comparação causal; só promover se a leitura ganhar pelo menos 85%. |
| **CP-CARTO-80 — Continuidade de macroescala** | Correcções locais de trilho, terreno e oclusão apenas onde a rota física contradisser a separação entre âncoras. | 30+ s de gameplay, colisão livre e nenhuma redução das distâncias canónicas. |
| **CP-CARTO-56 — Handoff R6→R7** | Aplicar a checklist pareada após Dev2 publicar uma subida física R7. | Scope guard, passagem física, captura e nenhuma edição de módulos Dev2 nesta branch. |

## Regras de produção

Nenhum passe poderá mover um marco canónico, alterar a água, reintroduzir props rejeitados ou alterar R7–R12 sem uma prova causal. As árvores, rochas, relva, fetos, lanternas e água já aprovados ou rejeitados mantêm os respectivos registos de decisão. Alterações futuras são sempre de **leitura espacial**, não de decoração aleatória.

Cada incremento exige validação headless, Menu → Novo Jogo, pelo menos 30 segundos de gameplay real, captura 1600×900 e verificação do orçamento de até 16 luzes dinâmicas. O commit é evidência; o checkpoint seguinte abre imediatamente após a publicação.

## Próxima execução

Assim que o pacote validado for entregue, iniciar **CP-CARTO-78**: construir a régua cartográfica de QA para a rota Casa Voss → Estrada → Arco e comparar as distâncias logadas com as seis âncoras acima. O resultado permitirá distinguir de forma objectiva uma falha de escala, de orientação ou de leitura visual antes de tocar no mundo de produção.
