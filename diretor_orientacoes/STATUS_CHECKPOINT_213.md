# ORIGEM — Checkpoint 213: Luar Frio no Acampamento Majestic

**Branch:** `feature/dev1-gameplay-core`  
**Módulo:** `levels/ForestLakeRegion.gd`  
**Âmbito:** Região 5 — Acampamento Majestic, sem alterações nas Regiões 7–12.

## Incremento Aplicado

Foi introduzida a luz `LuarFrioDoAcampamento`, uma `SpotLight3D` descendente de cor azul fria, energia `0.30`, alcance de `16 m` e ângulo de `44°`. A fonte é posicionada acima do anel de tendas e não gera sombras dinâmicas. O objectivo é separar visualmente lonas, mastros e solo da luz quente da fogueira, preservando o contraste de crepúsculo sem elevar de forma material a carga de renderização.

| Parâmetro | Valor | Salvaguarda |
|---|---:|---|
| Tipo | `SpotLight3D` | Direccional e localizada |
| Energia | `0.30` | Baixa intensidade |
| Alcance | `16 m` | Inferior ao preenchimento ambiental do acampamento |
| Sombras | Desactivadas | Sem custo de shadow map adicional |
| Cor | Azul frio | Contraste narrativo com a fogueira âmbar |

## Verificação Obrigatória

| Verificação | Resultado |
|---|---|
| Arranque técnico headless Godot 4.7.1 | ✅ Aprovado |
| Gameplay integrado — prólogo 30 s | ✅ Aprovado |
| Gameplay integrado — Acampamento Majestic → lago 30 s | ✅ Aprovado |
| Orçamento de luzes simultâneas | ✅ Mantido; luz local e sem sombras |
| Fronteira Regiões 7–12 | ✅ Mantida |

## Próximo Passo

**CP 214 — Pedras de travessia na Ponte de Pedra do Vale.** Inserir três pedras emergentes visíveis acima do nível da água, aterrar as geometrias no relevo e garantir que não criam colisores bloqueadores no trilho principal.
