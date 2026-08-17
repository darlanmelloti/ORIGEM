# CP 324 — Materialidade de solo da abertura

O shader do relevo foi calibrado para elevar moderadamente a reflectância difusa de lama húmida, matéria vegetal e textura PBR. A alteração melhora a distinção de valores entre o terreno da bacia, a estrada e a água sem luz adicional, geometria artificial ou alteração da escala cartográfica.

A validação técnica Godot foi concluída sem erros de GDScript. A execução gráfica em compatibilidade manteve a cena principal disponível durante 30 segundos, sem erros de script e sem alteração da rota Dev1.

A evidência de abertura está em `qa_evidence_voss_vista/cp324_ground_material.png`. O ganho é incremental, não uma aprovação final da tomada de 12 marcos; o CP 325 já inicia a separação macro entre a bacia e a ponte pela continuidade de margens reais.
