# CP-CINE-51B — Resultado da Prioridade de Câmara

A sonda confirmou que a câmara activa passou a ser a de Elias:

> `/root/OrionInterior/Player/Head/Camera3D`

A prioridade da câmara estática foi, portanto, corrigida. As três posições físicas, inclusive a vista média com orientação global forçada, continuam a apresentar uma parede dominante e apenas uma faixa reduzida de piso. A causa remanescente é a **secção transversal e a curvatura do casco**, não a selecção de câmara.

A correcção de prioridade será preservada, porque elimina um conflito real de gameplay. A instrumentação QA será removida. O próximo bloco não deve alterar materiais ou luzes: deve validar um perfil de corredor com maior afastamento lateral antes do início da curva, garantindo que a perspectiva de Elias enxerga o piso e o espaço de avanço.

## Próximo ciclo activo

**CP-CINE-52 — Perfil de rota legível.** Comparar uma única variante de perfil com largura adicional e curvatura atrasada, mantendo o mesmo número de luzes e o Cube oculto.
