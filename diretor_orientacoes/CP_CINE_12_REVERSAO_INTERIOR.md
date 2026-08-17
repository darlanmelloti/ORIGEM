# CP-CINE-12 — Reversão Controlada da Câmara Orion

A entrada exterior da Caverna Orion permanece validada como geometria volumétrica do CP-CINE-11. Durante a validação de CP-CINE-12, foram testadas abóbadas fechadas e contrafortes internos para ocultar o céu e revelar o Cubo de Orion no interior. A instrumentação confirmou que o Cubo e a Câmara respondiam à proximidade correcta de Elias, mas as opções de volume contínuo ou paredes de rocha não produziram uma leitura visual aceitável na câmara de compatibilidade: ora ocultavam o artefacto, ora expunham o céu e malhas isoladas.

A experimentação foi integralmente revertida. O ficheiro `OrionDestinationRegion.gd` regressou à entrada volumétrica estável publicada no CP-CINE-11, e a validação headless passou após a reversão. Não foi publicada qualquer geometria degradada.

| Critério | Resultado CP-CINE-12 |
|---|---|
| Entrada Orion sem painel plano | Preservada a base CP-CINE-11 |
| Câmara interior visualmente legível | Não atingida; revertida |
| Cubo restrito ao interior no estado de cena | Confirmado pela auditoria runtime |
| Base técnica após reversão | Validada em Godot headless |

## CP-CINE-13 já iniciado

A próxima solução não usará uma esfera, cápsula ou parede de ocultação. O proprietário R10–R12 deve auditar a rota e colisores físicos da boca para a Câmara, dividindo-a em secções exploráveis de rocha — soleira, corredor e altar — onde cada secção pode ser testada separadamente. O Cubo só será apresentado após a rota interior possuir uma tomada física verificável.
