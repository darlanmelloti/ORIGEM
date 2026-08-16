# Região 12 — Optimização de Builder, Ciclo 111

A remoção das luzes de contacto foi executada e validada com parser/runtime Godot 4.7.1 limpos. A amostragem permaneceu em 20–21 FPS, sem ganho suficiente. A evidência visual manteve-se estável.

O resultado está `REJECTED_TECHNICAL`: o custo dominante não está nas luzes removidas. A próxima acção imediata é ocultar o builder integrado completo no harness isolado, mantendo apenas o proxy dedicado e os elementos de iluminação necessários. O builder principal permanece intacto; esta alteração é exclusiva da cena de validação.
