# Auditoria de Fronteira — Take 6

A leitura de `levels/RegionalCinematicDirector.gd` confirma que o Take 6 está definido com `position.z = 462.0` e `target.z = 535.0`. Essas coordenadas pertencem ao bloco de montanha/cânion atribuído ao Desenvolvedor 2 e não às Regiões 1–6 do Desenvolvedor 1.

A decisão operacional para esta branch é **atribuir o Take 6 à Dev2**. O dicionário não foi alterado nesta branch, porque modificar o director partilhado sem coordenação poderia invadir a fronteira do Dev1. O Take 8 permanece a próxima implementação formal da Dev2, na Região 8 / Trilha da Montanha.

**Estado:** auditado e documentado.  
**Regiões 1–6:** não modificadas.  
**Próxima prioridade:** CP-D2-001 / Take 8.
