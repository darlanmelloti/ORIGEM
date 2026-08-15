# Ruptura Visual — Decisões de Iluminação Global

## Fontes consultadas

1. [Godot Docs — SDFGI](https://docs.godotengine.org/en/stable/tutorials/3d/global_illumination/using_sdfgi.html)
2. [Godot Docs — Environment and Post-processing](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html)
3. [Godot Docs — Introduction to Global Illumination](https://docs.godotengine.org/en/stable/tutorials/3d/global_illumination/introduction_to_global_illumination.html)

## Conclusões aplicadas ao ORIGEM

O SDFGI é suportado apenas pelo renderizador **Forward+**, pode acompanhar níveis procedurais e beneficia interiores de pedra com luzes persistentes. Porém, a documentação oficial identifica-o como uma das técnicas de GI mais exigentes; por isso o ORIGEM não deve aplicá-lo a todo o vale aberto na GTX 1050. Nesta fase ele será reservado ao volume interior do Santuário da Nascente, com quatro cascatas ou menos, resolução GI reduzida e Y Scale de 50–75%.

Os objetos estáticos de nível devem contribuir para SDFGI em modo estático. Personagens e inimigos dinâmicos recebem a iluminação, mas não precisam contribuir para ela. Braseiros de longa duração podem usar contribuição estática; efeitos temporários de espada permanecem fora do cálculo de GI.

O SSR dá mais detalhe a superfícies húmidas e água apenas quando os objetos refletidos estão visíveis no ecrã. As ReflectionProbes locais constituem a reserva para reflexos fora do enquadramento. Para a GTX 1050, SSR mantém 32 passos e as ReflectionProbes usam atualização única.

SSAO e SSR são mantidos moderados. A documentação salienta que ambos são efeitos de espaço de ecrã e têm custo relevante; não devem ser ampliados sem medição de desempenho. A névoa tradicional ajuda a disfarçar transições de cascata de SDFGI e mantém custo inferior à névoa volumétrica global.
