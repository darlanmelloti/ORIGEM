# ORIGEM — Contrato Cartográfico do Mundo 3D

**Estado:** obrigatório para todas as novas implementações e refinamentos.  
**Autoridade visual:** mapa cartográfico oficial de doze marcos fornecido pela Direcção.  
**Princípio:** o mapa não é uma ilustração decorativa. Ele é o espelho espacial do mundo jogável.

> Cada marco cartográfico deve ter equivalente físico no Godot: posição relativa, elevação, silhueta, percurso de chegada, relação com água/floresta/ruína e leitura à distância. Um marco só é considerado concluído quando a sua presença no mundo 3D permite reconhecer a mesma geografia do mapa.

## Convenção de coordenadas

O mundo usa **X negativo para oeste**, **X positivo para este** e **Z crescente para norte**. A altitude vem do terreno por `height_at(x, z)`. A escala do desenho cartográfico é narrativa, não uma conversão literal de metros; a obrigação é preservar a topologia: Casa no sudoeste, rio e estrada de ligação, arco como garganta, floresta central, acampamento no bordo ocidental, lago/ruínas como centro hídrico, vila e observatório a nordeste, trilha ascendente, Montanha Orion ao norte e Hub Temporal a sudeste.

| Marco | Referência cartográfica que deve existir em 3D | Âncora actual / prevista | Dono |
|---:|---|---|---|
| 1 — Casa Voss | Casa isolada no sudoeste, ruínas baixas e saída orientada para o vale. | `(-22, 8)` | Dev1 |
| 2 — Estrada do Rio | Percurso de pedra e margem de rio que sai da Casa e sobe para o coração do vale. | `x≈-21→-10; z=10→120` | Dev1 |
| 3 — Arco das Ruínas | Garganta monumental no eixo da estrada, com pilares, coroa quebrada e leitura de passagem. | `x≈-18; z=48` | Dev1 |
| 4 — Floresta Densa | Massa central de árvores atravessável, raízes, fetos e trilho legível; nunca uma parede de vegetação. | `x≈-9→4; z=116→240` | Dev1 |
| 5 — Acampamento Majestic | Clareira/plateau a oeste da floresta e do lago, com tendas, fogueira e estela. | `(-88, 178)` | Dev1 |
| 6 — Ruínas Submersas | Grande corpo de água central-oriental, pilares/templo afundado e margens exploráveis. | `(60, 252)` | Dev1 |
| 7 — Vila Elevada | Terraços e casas sobre a encosta oriental, alcançados pela estrada que sai do lago. | `(140, 352)` | Dev2 |
| 8 — Observatório | Domo/observatório acima da vila, dominante na silhueta oriental. | `(194, 404)` | Dev2 |
| 9 — Trilha da Montanha | Serpentina rochosa que sobe do observatório e inflecte para o maciço Orion. | `(174,414)→(-112,532)` | Dev2 |
| 10 — Caverna do Orion | Boca física escura inserida na montanha, com percurso final legível e não uma parede plana. | `(-116, 548)` | Dev2 |
| 11 — Câmara do Orion Cube | Câmara/altar imediatamente além da caverna, culminando no cubo azul. | `(-116, 562)` | Dev2 |
| 12 — Hub Temporal | Círculo megalítico separado a sudeste do lago, acessível como destino temporal e visualmente distinto. | `(164, 210)` | Dev2 |

## Relações espaciais inegociáveis

| Relação no mapa | Tradução obrigatória no jogo |
|---|---|
| Casa Voss → Estrada → Arco | A saída da Casa deve revelar a rota de pedra e a presença do arco como primeiro limiar monumental, sem teleporte entre marcos. |
| Arco → Floresta → Acampamento | O arco entrega Elias à borda sul da floresta; a clareira Majestic permanece no flanco oeste e não deve encerrar o trilho. |
| Floresta/Acampamento → Lago | A copa abre gradualmente para revelar água, ruínas e as margens. O lago precisa manter a montanha como destino remoto. |
| Lago → Vila → Observatório | A vila sobe pela margem oriental; o observatório domina o topo e deve poder ser reconhecido de longe. |
| Observatório → Montanha Orion | A trilha curva para norte e ganha cota; cada curva mostra rocha, vale e o maciço, evitando corredores rectos ou painéis de fundo. |
| Montanha → Câmara do Cube | A boca da caverna é uma entrada física, e a câmara é um clímax interno. |
| Lago → Hub Temporal | O Hub fica a sudeste, separado da rota de ascensão para Orion, tal como no mapa. |

## Auditoria actual das Regiões 1–6

| Região | Aderência actual | Lacuna a tratar em próximos ciclos |
|---|---|---|
| Casa Voss | A posição inicial, a porta interativa e a leitura de saída já existem. | Reforçar a leitura sudoeste do vale e a vista inicial da rota, sem alterar o interior funcional. |
| Estrada do Rio | Estrada física, rio, ponte e variação de margens já cobrem a ligação norte. | Fazer a curva da estrada ler mais claramente como ligação cartográfica, não apenas corredor local. |
| Arco das Ruínas | Arco no eixo `z=48`, bases, fetos e coroa quebrada implementados. | Consolidar a silhueta como gargalo entre margem e floresta. |
| Floresta Densa | Trilho contínuo `z=116→240`, coníferas variadas e sub-bosque presentes. | Ampliar a leitura de floresta central aberta e a ligação visual ao lago. |
| Acampamento Majestic | Localizado a oeste em `(-88,178)`, com luz de luar e fogueira. | Tornar a clareira mais reconhecível como acampamento/plateau ocidental no mapa. |
| Ruínas Submersas | Centro hídrico em `(60,252)`, com pilares, margem e transição para Região 7. | Reforçar a panorâmica lago → vila/montanha sem criar activos das Regiões 7–12. |

## Regra de produção

1. Nenhum novo objecto regional pode ser criado apenas porque “fica bonito”. Deve reforçar uma relação explícita do mapa: rota, marco, encosta, margem, floresta, ruína ou silhueta.
2. Dev1 modifica apenas as Regiões 1–6. Dev2 modifica apenas as Regiões 7–12. As coordenadas acima são um contrato de integração, não autorização para atravessar a fronteira de módulos.
3. Cada checkpoint deve declarar quais marcos foram reforçados, manter a rota física livre e validar em Godot com gameplay/captura de pelo menos 30 segundos.
4. O próximo passe visual de cada região deve favorecer **leitura à distância primeiro, chegada segundo e detalhe de proximidade terceiro**, espelhando a forma como o mapa orienta o jogador.
