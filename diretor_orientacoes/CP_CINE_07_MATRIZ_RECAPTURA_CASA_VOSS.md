# CP-CINE-07 — Matriz de recaptura Casa Voss após integração Dev2

## Estado de sincronização

A ordem CP-CINE-06 está publicada em `c0b27b6`. A consulta da origem remota confirma que ainda não existe um novo commit Dev2 de cadeia remota. Enquanto a integração não chega, esta matriz fixa o método de retorno e elimina decisões de câmara improvisadas.

## Tomada bloqueada para comparação

A recaptura mantém a configuração CP317 em `VossHouse.gd`: posição do afloramento ocidental `(-42, ground+6.8, 1.5)`, FOV `72°` e alvo na direcção do leito do vale. Não mudar posição, FOV, altura, rotação, ponte, estrada, taludes ou exposição durante o retorno Dev2.

## Critérios de leitura

| Profundidade | Evidência exigida | Rejeitar quando |
|---|---|---|
| Primeiro plano | Casa Voss ainda ocupa a margem esquerda sem cobrir o centro | A casa sai do quadro ou volta a preencher o centro |
| Plano médio Dev1 | Água lateral, Estrada e Arco físico permanecem legíveis | Uma massa Dev2 tapa a estrada, o rio ou o Arco |
| Plano remoto Dev2 | Vila em socalcos, observatório não emissivo e contrafortes distinguíveis após a bacia | Apenas surge um farol, painel ou pico isolado |
| Escala | Orion continua a destino remoto e a rota entre marcos mantém distância real | A cadeia comprime a bacia ou aproxima a montanha artificialmente |
| Limpeza | Sem HUD e sem emissão técnica ciano | Balizas Chronos competem com a geografia |

## Sequência obrigatória

1. Dev2 publica o commit, o frame 16:9 e a prova de 30 segundos das Regiões 7–9.
2. Dev3 recaptura a mesma tomada acima com `ORIGEM_QA_CINEMATIC_CAPTURE=1`.
3. Dev1 valida que nenhum módulo das Regiões 1–6 mudou como efeito colateral.
4. CP-CINE-07 aceita a cadeia ou devolve exactamente uma correcção ao Dev2. O relatório deve abrir CP-CINE-08 imediatamente.

> Não existe pausa operacional: enquanto a integração remota é produzida pelo proprietário Dev2, as regras de comparação e o retorno já estão definidos e versionados.
