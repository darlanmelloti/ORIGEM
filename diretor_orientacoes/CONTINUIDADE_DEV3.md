# Continuidade — Dev3

- **Última prova registada:** Passe 0B — Grelha de Legibilidade dos 12 Marcos, com `0/12` reconhecíveis na tomada actual.
- **Diagnóstico activo:** ausência de marcos é lacuna espacial atribuída; não encerra a direcção cinematográfica.
- **Execução iniciada:** `Take 1 — Casa Voss/Estrada`, seguido obrigatoriamente de `Take 2 — Arco`, `Take 3 — Arco–Floresta–Bacia` e `Recaptura 0C` com a lente-mestre inalterada.
- **Responsáveis das lacunas:** Dev1 para marcos 1–6; Dev2 para marcos 7–12.
- **Critério de aceitação:** cada take publica grelha de legibilidade, proprietário de lacuna e próximo passe já iniciado; 0C compara a mesma câmara com 0B.
- **Estado:** `EM EXECUÇÃO — NÃO AGUARDAR RESPOSTA`.


## Recuperação obrigatória de workspace

**Ramo remoto verificado:** `origin/feature/cine07-final`. A referência histórica `feature/director-cinematic-polish` não está publicada no remoto e não pode ser usada como razão para encerrar esta frente.

Quando o ambiente Dev3 não tiver checkout local, a acção inicial é recuperar o ramo canónico:

```bash
git clone --branch feature/cine07-final --single-branch https://github.com/darlanmelloti/ORIGEM.git ORIGEM_dev3_recovery
cd ORIGEM_dev3_recovery
```

Se a clonagem falhar por conectividade ou credencial, Dev3 deve criar, assim que existir qualquer checkout acessível, `BLOQUEIO_DEV3.md` no formato de `PROTOCOLO_RECUPERACAO_DEV3.md`; antes disso, deve emitir uma única nota estruturada com a URL, erro e hora UTC. O ciclo seguinte começa directamente por nova tentativa de clone. Não repetir varreduras de caminhos ausentes e não declarar a frente concluída.

Após a recuperação, Dev3 deve retomar o plano já aberto: confirmar `project.godot`, ler os marcadores de orientação, manter a matriz de legibilidade dos doze marcos e prosseguir `Take 1 — Casa Voss/Estrada` pela lente-mestre. A tarefa seguinte permanece sempre anotada antes da publicação de cada checkpoint.


## Apoio técnico Dev4 activo — CINE-PAIR-01

Dev4 foi reatribuído como parceiro técnico directo do interior Orion. O checkout canónico `feature/cine07-final` contém `project.godot`; não existe bloqueio material activo para Dev3 neste ramo.

Dev3 deve usar a sonda física temporária criada por Dev4 para seleccionar uma única melhoria cinematográfica que não repita candidatos rejeitados em `CP_CINE_56_DIAGNOSTICO_MOVIMENTO.md`. A decisão, a alteração, a validação de 30 segundos e a próxima hipótese já aberta pertencem ao mesmo ciclo `CINE-PAIR-01`.

> A conclusão de uma captura ou um diagnóstico não encerra a frente: inicia imediatamente `CINE-PAIR-02` com Dev4 para a implementação/revisão da próxima alteração comprovada.
