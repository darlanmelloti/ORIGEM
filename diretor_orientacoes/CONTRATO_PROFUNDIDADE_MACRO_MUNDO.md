# Contrato de Profundidade Macro do Mundo

O mapa cartográfico continua a ser a autoridade lógica; este contrato determina como ele será sentido no mundo tridimensional. Cada região deverá manter a âncora canónica para UI, missões e navegação, enquanto o seu cenário passa a obedecer ao factor macro de referência `2,5×` a partir da Casa Voss.

| Faixa | Responsável | Geometria activa | Requisitos de leitura | Física e desempenho |
|---|---|---|---|---|
| Casa–Estrada–Arco | Dev1 | Região 1–3 | Casa enquadra a origem; Estrada desce em curvas; Arco lê como destino de plano médio. | Colisores apenas no percurso; activos próximos com detalhe normal. |
| Floresta–Majestic–Bacia | Dev1 | Região 4–6 | Vegetação cria profundidade, mas conserva clareiras; água e ruínas definem a bacia antes do handoff. | Instâncias e LOD; colisores apenas junto da rota. |
| Vila–Observatório–Orion–Hub | Dev2 | Região 7–12 | Vila e Observatório destacam-se em patamares; Orion domina o horizonte; Hub ocupa o canto inferior direito do vale. | Silhuetas de baixo custo a longa distância; geometria detalhada só ao aproximar. |
| Comparação de tomada | Dev3 | Apenas câmaras e evidências | A mesma lente verifica camadas de primeiro plano, vale médio e horizonte. | Nunca altera FOV ou oculta lacunas para simular escala. |
| Coordenação | Dev4 | Matriz, contratos e retorno | Toda reescala tem proprietário, verificação e artefacto inicial. | Nenhuma paragem declarativa; cada lacuna abre tarefa activa. |

A transição entre marcos deve ficar progressivamente mais longa e rica, com curvas de terreno, referências laterais e variações de elevação. Um objecto de horizonte só pode usar geometria simplificada se continuar volumétrico e for substituído por detalhe real ao entrar na zona próxima. Painéis, paredes de árvores, fundos planos e redução artificial de distâncias são proibidos.

## Próximo passe imediato

Dev1 inicia a profundidade do corredor Casa–Estrada–Arco. Dev2 recebe o contrato para preparar silhuetas macro 7–12. Dev3 mantém o Take 0C com a mesma lente para medir o ganho de profundidade depois de cada integração. Dev4 actualiza a grelha DIR-118 assim que uma camada se tornar legível.
