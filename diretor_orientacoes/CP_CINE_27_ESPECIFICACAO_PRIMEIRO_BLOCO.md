# CP-CINE-27 — Especificação do Primeiro Bloco Subterrâneo Orion

O inventário confirma que o projecto contém `stone_largeA`, `stone_largeB`, `stone_smallF`, `stone_tallC`, `cliff_blockSlope_rock` e `cliff_cave_rock`. Os dois últimos não serão reutilizados sem uma nova medição de pivô: a auditoria CP-CINE-23B demonstrou que o activo de caverna anterior não era adequado à leitura da aproximação exterior.

O primeiro bloco de interior será limitado à **soleira de transição**. Não incluirá altar, Cube, partículas ou luz Chronos.

| Componente | Regra de integração |
|---|---|
| Piso | Malha/colisão de módulo interior próprio, sem laje exterior visível |
| Parede de entrada | Uma secção física de rocha, testada com o pivô medido no ambiente de interior |
| Escala | Corredor útil mínimo de 4,2 m, altura mínima de 3,2 m |
| Luz | Apenas ambiente neutro fraco; luz Chronos continua bloqueada |
| Cube | Nenhuma instância no bloco de soleira |
| Validação | Captura pelo mundo principal e 30 segundos de movimento, sem objectos suspensos |

O bloco só poderá ser integrado depois de a transição de carregamento de módulo ser implementada como um gatilho físico reversível. **CP-CINE-28 já está iniciado** para construir esse gatilho sem teletransportar a câmara ou contaminar a abertura.
