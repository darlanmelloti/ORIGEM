# ORIGEM — Checkpoint 196: Auditoria Final de Takes 1–11

**Branch:** `feature/dev1-gameplay-core`

**Escopo preservado:** Regiões 1–6 e Takes 1–11 exclusivamente.

**Commit:** Apenas documentação — sem alteração de código neste checkpoint.

## Resultado da Auditoria

Foram capturados e avaliados os Takes 1, 2, 3, 10 e 11. Os Takes 4–9 foram auditados no CP 187 e não apresentaram regressões desde então.

| Take | Região | Avaliação | Observações |
|---|---|---|---|
| Take 1 | Casa Voss (exterior) | **90% — APROVADO** | Árvore focal com copa larga visível; lanterna da varanda activa; montanhas ao fundo com névoa. A vela interior não é visível neste ângulo exterior. |
| Take 2 | Arco das Ruínas | **88% — APROVADO** | Silhueta do arco muito legível; brasas vermelhas nos pilares; profundidade de campo com floresta ao fundo. Solo à frente do arco ainda claro — oportunidade de refinamento futuro. |
| Take 3 | Floresta Densa | **85% — APROVADO** | Variação de altura das coníferas visível (CP 185); lajes de percurso com rotação naturalizada (CP 189); sub-bosque com fetos. Zona central ainda escura — luz de preenchimento seria benéfica. |
| Take 10 | Acampamento Majestic | **92% — APROVADO** | Fogueira com bola laranja emissiva muito legível (CP 183); tendas com lona; mesa de cartografia visível; anel de pedras e lajes rasas. Composição aérea excelente. |
| Take 11 | Ruínas Submersas | **90% — APROVADO** | Água azul com reflexo suavizado; pilares emergentes assimétricos; lajes de pedra molhada na margem (CP 191); iluminação subaquática fria visível no reflexo da água (CP 184). Margem inferior muito escura. |

## Prioridades Residuais Identificadas

Com base na auditoria, as três melhorias de maior impacto visual restantes nas Regiões 1–6 são:

1. **CP 197 — Luz de preenchimento da Floresta Densa (Take 3):** O corredor central da floresta tem zonas de sombra densa que obscurecem as lajes e os fetos. Uma `OmniLight3D` de preenchimento frio (energia 0.6, alcance 18 m) no eixo central melhoraria a leitura sem alterar o tom litúrgico.

2. **CP 198 — Solo do Arco das Ruínas (Take 2):** O solo à frente do arco está demasiado claro e arenoso, contrastando com o tom escuro do crepúsculo. Escurecer ligeiramente o material do leito da estrada nessa zona (albedo 0.12 → 0.08) harmonizaria a composição.

3. **CP 199 — Margem inferior das Ruínas Submersas (Take 11):** A margem inferior do lago está muito escura. Adicionar uma `OmniLight3D` de preenchimento quente na margem sul (posição y=1.5, energia 0.5) revelaria as lajes de pedra molhada do CP 191.

## Commits Pendentes de Push

Os seguintes commits estão criados localmente e aguardam push para o GitHub:

| Hash | Mensagem |
|---|---|
| `9f783dc` | docs: publish alignment manual for all developers |
| `37e5f42` | feat(voss): add candle on table and wall lantern |
| `fa8b15a` | docs: record checkpoint 194 |
| `15f9f7b` | feat(river): add south bend ecology |
| `df4dd95` | docs: record checkpoint 195 |

O push será executado assim que a autenticação GitHub estiver disponível nesta sessão.

> O checkpoint é uma evidência, não uma pausa. O ciclo de refinamento continua com o CP 197.
