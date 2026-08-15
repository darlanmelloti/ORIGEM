# ORIGEM — Ponto de Situação Takes 6–7

**Branch:** `feature/dev2-mountain-canyon`  
**Motor:** Godot 4.7.1  
**Fronteira:** Take 5, rio e blocos do Desenvolvedor Principal permanecem congelados.

Os Takes 6 e 7 foram implementados e validados em ciclos repetidos de F5, print 1600×900, gameplay de 30 segundos e comparação de frames. O Take 6 inclui desfiladeiro profundo, fendas tectónicas, vestígios históricos e ressonância ciano. O Take 7 inclui praça ciclópica, anel de arena, silhueta táctica Kharu, marcadores históricos e Cubo de Orion com material azul emissivo controlado.

O primeiro ciclo do Take 6 falhou por câmara dentro da parede; a câmara foi reposicionada e a versão final manteve renderização durante o ciclo. O Take 7 exigiu quatro correções de enquadramento; a versão final usa uma aproximação pelo corredor limpo, mantém o Cubo central e permite sweep lateral subtil durante 30 segundos. Os logs `TAKE6_FECHO_2026-08-15.md` e `TAKE7_FECHO_2026-08-15.md` contêm o fecho auditável de cada setor.

As evidências finais estão em `evidence/take6/` e `evidence/take7/`. Permanece um caveat visual não bloqueante: algumas fontes antigas do perímetro do Take 7 ainda são brancas e podem ser substituídas por materiais ciano num passe de produção posterior.
