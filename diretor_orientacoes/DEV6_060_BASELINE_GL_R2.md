# DEV6-060 — Baseline GL Compatibility R2

A baseline foi executada no renderizador `gl_compatibility`, sem alteração de cenas. A auditoria estática não encontrou referências a `Light3D`, `OmniLight3D`, `SpotLight3D` ou `DirectionalLight3D` dentro das funções Dev6 R1, R2, R3, R4 e R6.

| Verificação | Resultado |
|---|---|
| Parser Godot 4.7.1 | `PASS` |
| Referências de luz nos blocos Dev6 | `0` |
| Rota Estrada do Rio → Arco | `PASS`, 36 s |
| Grounding R2 | `9/9`, X/Z preservado |
| Luzes dinâmicas R2 declaradas | `0` |

O manifesto externo `qa_evidence_dev6_gl/dev6_060_manifest.sha256` preserva os hashes do parser, log e captura desta sessão. A baseline confirma compatibilidade técnica de Dev6 em GL, mas não altera o estado visual `REJECTED_VISUAL` dos candidatos até às recapturas de terceira pessoa.
