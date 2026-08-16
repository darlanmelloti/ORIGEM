# ORIGEM — Orientação de Continuidade Autónoma: Dev03 (Diretor Cinematográfico)

**Para:** Dev03
**De:** Dev1 (Desenvolvedor Principal)
**Validado por:** CEO
**Data:** 2026-08-16

---

## O Que Foi Construído (Estado Actual — CP 210)

As Regiões 1–6 estão completas e refinadas. O jogador percorre um mundo físico e navegável de 6 regiões com 11 takes cinematográficos já definidos. Aqui está o resumo do que existe:

| Região | Conteúdo | Módulo |
|---|---|---|
| 1 — Casa Voss | Casa procedural, vela na mesa, lanterna de parede, luz de pórtico, porta [E] | `VossHouse.gd` |
| 2 — Estrada do Rio | Rio com pedras emergentes, margens com fetos e variação de cor, Arco das Ruínas com fragmentos de coroa | `RiverRoadJourney.gd` |
| 3 — Arco das Ruínas | Pilares com pedras de base, fetos, fragmentos de coroa, brasas | `RiverRoadJourney.gd` |
| 4 — Floresta Densa | Coníferas com variação de altura, copas focais de folha larga, sub-bosque, luzes de preenchimento frias | `ForestLakeRegion.gd` |
| 5 — Acampamento Majestic | Tendas, fogueira animada com luz pulsante, mesa de cartografia, estela interativa, trilho com meandra | `ForestLakeRegion.gd` |
| 6 — Ruínas Submersas | Lago com pilares irregulares, iluminação subaquática fria, lajes de pedra molhada, marcos emergentes | `ForestLakeRegion.gd` |

---

## Os 11 Takes Actuais (RegionalCinematicDirector.gd)

Lê o ficheiro `levels/RegionalCinematicDirector.gd` para ver as coordenadas exactas. Aqui está o resumo:

| Take | Posição | Alvo | FOV | Região |
|---|---|---|---|---|
| 1 | (-22, 4.5, 14) | (-22, 1.5, 8) | 52° | Casa Voss |
| 2 | (-8, 5.5, 42) | (0, 1.5, 52) | 48° | Estrada do Rio |
| 3 | (-12, 8.5, 148) | (-8, 1.5, 162) | 52° | Floresta Densa |
| 4 | (2, 6.5, 92) | (8, 1.5, 105) | 45° | Margem do Lago |
| 5 | (-88, 10.5, 108) | (-82, 1.5, 118) | 50° | Acampamento Majestic |
| 9 | (-104, 16, 163) | (-36, 1.6, 180) | 42° | Conector Majestic–Lago |
| 10 | (-100, 6.8, 158) | (-88, 1.45, 172) | 40° | Acampamento (mesa) |
| 11 | (15, 8.5, 216) | (60, 1.0, 252) | 47° | Ruínas Submersas |

---

## A Tua Missão (Ciclo Contínuo)

O teu trabalho é melhorar a direcção visual e propor novos takes sem parar. O ciclo é:

1. **Ler** — consultar este documento e o `STATUS_CHECKPOINT_210.md`
2. **Estudar** — ler `RegionalCinematicDirector.gd` e analisar os takes actuais
3. **Propor** — identificar o take com maior potencial de melhoria
4. **Implementar** — editar `RegionalCinematicDirector.gd` directamente
5. **Capturar** — usar `ORIGEM_CAPTURE_TAKE=N xvfb-run...` para ver o resultado
6. **Comparar** — avaliar antes vs depois; se < 85% do objectivo, iterar
7. **Commitar** — `feat(cine): CINE-001 - descrição`
8. **Fazer push** — para `feature/dev1-gameplay-core`
9. **Registar** — `STATUS_CINE_001.md` em `diretor_orientacoes/`
10. **Avançar** — iniciar imediatamente o CINE-002

---

## Próximas Tarefas (Executar por Ordem)

### CINE-001 — Take 1 Mais Íntimo (Casa Voss)

**Problema actual:** a câmara está demasiado afastada; a vela na mesa e a luz do pórtico não são visíveis.

**Solução proposta:**
```gdscript
"1": {
    "position": Vector3(-22, 3.2, 12.5),
    "target": Vector3(-22, 1.2, 7.5),
    "fov": 48.0,
    "label": "Casa Voss — Prólogo Íntimo"
}
```

**Critério de aceitação:** a luz do pórtico âmbar deve ser visível no canto inferior direito do enquadramento e a silhueta da casa deve ocupar pelo menos 40% da altura do frame.

---

### CINE-002 — Novo Take 1B (Interior da Casa Voss)

**Objectivo:** câmara dentro da casa, olhando para a porta aberta com o crepúsculo ao fundo — cria a sensação de "sair para a aventura".

**Implementação:**
```gdscript
"1b": {
    "position": Vector3(-22, 1.8, 5.5),
    "target": Vector3(-22, 1.8, 10.5),
    "fov": 55.0,
    "label": "Casa Voss — Interior para Exterior"
}
```

---

### CINE-003 — Take 3 com FOV Alargado (Floresta Densa)

**Problema actual:** FOV de 52° não mostra as copas focais ampliadas (CP 182).

**Solução:**
```gdscript
"3": {
    "position": Vector3(-12, 8.5, 148),
    "target": Vector3(-8, 1.5, 162),
    "fov": 60.0,  # era 52°
    "label": "Floresta Densa — Copas Visíveis"
}
```

---

### CINE-004 — Novo Take 10B (Fogueira Próxima)

**Objectivo:** câmara a 3m da fogueira, olhando para o lago ao fundo — mostra o calor da fogueira em contraste com a água fria.

```gdscript
"10b": {
    "position": Vector3(-84, 2.2, 170),
    "target": Vector3(-60, 1.0, 210),
    "fov": 45.0,
    "label": "Acampamento — Fogueira e Lago"
}
```

---

### CINE-005 — Estudo de Técnicas Elden Ring

Antes de implementar novos takes nas Ruínas Submersas, estudar:
- Posição elevada (Y alto, ângulo 15–20° descendente)
- FOV entre 40–50° para sensação de grandiosidade
- Alvo sempre ligeiramente abaixo do horizonte para mostrar o solo e criar escala

Referência: Take 10 actual (position Y=6.8, FOV=40°) é o mais próximo do estilo FromSoftware.

---

## Comandos de Captura

```bash
# Capturar um take específico
GODOT=/home/ubuntu/tools/godot471/Godot_v4.7.1-stable_linux.x86_64
ROOT=/home/ubuntu/origem_v2_casa_voss_full/ORIGEM_Integracao_Controlada_recovered

GODOT_SILENCE_ROOT_WARNING=1 ORIGEM_CAPTURE_TAKE=1 \
  xvfb-run --auto-servernum --server-args="-screen 0 1600x900x24" \
  "$GODOT" --path "$ROOT" &
sleep 35
# Capturar com scrot ou import
```

---

## Formato de Commit

```
feat(cine): CINE-001 - intimate take 1 framing showing porch light and candle
feat(cine): CINE-002 - new take 1b interior-to-exterior composition
docs: STATUS_CINE_001 - cinematographic take 1 improvement validated
```

---

## Regra de Ouro

Nunca parar. Se um take não atingiu 85% do objectivo, iterar. Se esgotaste as ideias para um take, avançar para o próximo e voltar mais tarde. O repositório é a evidência do trabalho — cada commit conta.
