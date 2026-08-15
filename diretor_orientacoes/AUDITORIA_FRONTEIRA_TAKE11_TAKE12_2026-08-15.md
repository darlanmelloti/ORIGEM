# Auditoria de Fronteira — Take 11 / Take 12

**Branch:** `feature/dev2-mountain-canyon`  
**Estado:** diretiva recebida e aplicada

## Correção operacional

A auditoria do diretor confirma que o mapa é a autoridade espacial e que o roteiro de cinco atos e 22 takes é a autoridade narrativa. O Desenvolvedor Principal permanece responsável pelas Regiões 1–6 e pelos Takes 1–11 corrigidos. O Take 11 não autoriza a subida à montanha: permanece associado às Regiões 4–6, incluindo Floresta Densa, Acampamento Majestic e Ruínas Submersas.

A frente do Novo Desenvolvedor começa somente no **Take 12**, na **Região 7 — Vila Elevada**, e segue até ao Take 22, na Região 12 — Hub Temporal. Esta branch não deve criar, alterar ou expandir qualquer módulo, câmara, geometria ou ativo das Regiões 1–6.

## Próximo incremento pertencente à outra branch

O passe de continuidade Casa Voss → Estrada do Rio → Arco das Ruínas → Floresta Densa → Acampamento Majestic → Ruínas Submersas pertence exclusivamente à `feature/dev1-gameplay-core`. A sua validação deve cobrir colisões, porta `[E]`, salto, stamina, navegação, leitura da montanha ao fundo e continuidade da água, com print de alta resolução e gameplay de aproximadamente 30 segundos.

## Ação desta branch

A `feature/dev2-mountain-canyon` retoma na Região 7, preservando a continuidade física para o Observatório, a Trilha da Montanha, a Caverna do Orion, a Câmara do Orion Cube e o Hub Temporal. A pergunta fica registada para auditoria, mas não bloqueia o desenvolvimento. Cada subtarefa continuará a exigir Godot 4.7.1, evidência visual, log e commit/push conforme a disponibilidade de autenticação remota.

> Regra de fronteira: **Take 11 encerra o bloco do Desenvolvedor Principal; Take 12 inaugura o bloco do Novo Desenvolvedor.**
