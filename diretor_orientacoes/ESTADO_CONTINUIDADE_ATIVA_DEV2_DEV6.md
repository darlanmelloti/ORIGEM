# ESTADO CONTINUIDADE ACTIVA — Dev2–Dev6

## ⚡ ESTADO ACTUAL (CICLO ACTIVO)

- **DISTRIBUICAO**: Dev2, Dev3, Dev4, Dev5 e Dev6 activos; Dev1 em STANDBY; Dev7 e Dev8 indisponíveis.
- **REGIAO_ACTUAL**: Passe de Fidelidade Cartográfica R1–R6, com interface R6→R7 protegida.
- **STATUS_CODE**: PASSED — directiva operacional publicada localmente e pronta para sincronização remota.
- **TAREFA_EM_EXECUCAO_AGORA**: Dev2 coordena o primeiro passe; Dev5 prepara grounding, marcos e objectos; Dev6 prepara ambiente; Dev3 prepara câmaras; Dev4 prepara harness e auditoria.
- **AUTORIDADE_ESPACIAL**: `mapaorigem.webp` através de `CartographicAnchors.gd`.
- **ORCAMENTO_R12**: máximo 16 luzes dinâmicas; qualquer alteração requer inventário Dev4.
- **CICLO_OBRIGATORIO**: executar → validar → capturar → analisar → corrigir → ZIP/SHA-256 → commit/sincronizar → reler Git → iniciar próxima tarefa.
- **NEXT_ACTION_IMMEDIATE**: publicar esta directiva e este estado na branch canónica; depois iniciar o contrato Casa Voss → Estrada do Rio → Arco.
- **WAIT_ALLOWED**: false.
