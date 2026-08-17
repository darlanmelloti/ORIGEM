# STATUS CHECKPOINT 309 — Calibração diurna da abertura

**Frente:** Dev1 — Regiões 1–6 / Takes 1–11.

O CP 309 elevou o preenchimento ambiente global e reduziu o contraste excessivo das sombras. A alteração não adiciona luzes dinâmicas, conserva o orçamento da GTX 1050 Ti e torna mais legíveis a parede de pedra da Casa Voss, a água e a vegetação da abertura.

A validação Godot 4.7.1 headless foi concluída sem erros. A prova de gameplay de 30 segundos em `opengl3`, com áudio dummy, concluiu sem erro GDScript. A evidência visual correspondente é `cp309_daylight_calibration.png`.

A melhoria é aceite como ganho técnico de leitura, embora a tomada ainda não alcance a referência final de doze marcos: o Arco é visível, mas a ponte lateral não possui silhueta suficiente. O CP 310 já está iniciado para corrigir essa leitura sem alterar a escala cartográfica ou aumentar o número de luzes.
