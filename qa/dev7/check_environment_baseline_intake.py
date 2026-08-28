#!/usr/bin/env python3
"""Valida, sem escrita de produção, o bundle publicado da baseline ambiental Dev1."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any

from PIL import Image

ROUTES = (
    "road_to_arch",
    "arch_to_forest",
    "forest_to_majestic",
    "majestic_to_lake",
    "forest_to_ruins",
    "ruins_arrival",
)
DECISIONS = (
    "PASS_LEITURA",
    "OBSERVAR_SEM_PRODUCAO",
    "HIPOTESE_CAUSAL_REQUERIDA",
)


def find_route_pngs(capture_dir: Path, route: str) -> list[Path]:
    return sorted(path for path in capture_dir.glob("*.png") if route in path.name.lower())


def image_state(paths: list[Path]) -> dict[str, Any]:
    if not paths:
        return {"present": False, "files": [], "size_ok": False}
    details: list[dict[str, Any]] = []
    for path in paths:
        try:
            with Image.open(path) as image:
                size = list(image.size)
            details.append({"path": str(path), "size": size, "size_ok": size == [1600, 900]})
        except Exception as exc:  # Reporta bundle inválido, sem alterar ficheiros.
            details.append({"path": str(path), "error": str(exc), "size_ok": False})
    return {
        "present": True,
        "files": details,
        "size_ok": all(item["size_ok"] for item in details),
    }


def route_state(report_text: str, route: str) -> dict[str, Any]:
    """Encontra decisões apenas nas linhas que identificam a rota.

    A versão anterior procurava numa janela de 500 caracteres após a primeira
    ocorrência da rota. Em manifestos Markdown completos, essa janela podia
    alcançar decisões de linhas seguintes e produzir falsos múltiplos. A
    associação por linha preserva a validação somente de leitura e impede que
    vocabulário de limites globais seja confundido com a decisão da rota.
    """
    route_lines = [line for line in report_text.splitlines() if route in line]
    matches = [decision for decision in DECISIONS if any(decision in line for line in route_lines)]
    return {"decision_matches": matches, "decision_ok": len(matches) == 1}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--report", type=Path, required=True, help="Relatório Markdown publicado por Dev1.")
    parser.add_argument("--captures", type=Path, required=True, help="Diretório das capturas PNG Dev1.")
    parser.add_argument("--output", type=Path, required=True, help="JSON de resultado QA Dev7.")
    args = parser.parse_args()

    report_exists = args.report.is_file()
    captures_exists = args.captures.is_dir()
    report_text = args.report.read_text(encoding="utf-8") if report_exists else ""

    routes: dict[str, Any] = {}
    for route in ROUTES:
        pngs = find_route_pngs(args.captures, route) if captures_exists else []
        routes[route] = {"capture": image_state(pngs), "report": route_state(report_text, route)}

    report_has_telemetry = all(token in report_text.lower() for token in ("spawn", "câmara", "luz"))
    report_has_all_routes = all(route in report_text for route in ROUTES)
    any_input = report_exists or captures_exists
    all_ready = (
        report_exists
        and captures_exists
        and report_has_telemetry
        and report_has_all_routes
        and all(data["capture"]["size_ok"] and data["report"]["decision_ok"] for data in routes.values())
    )
    invalid = any_input and not all_ready and report_exists and captures_exists
    result = "READY_FOR_DEV7_RECONCILIATION" if all_ready else ("INVALID_INPUT" if invalid else "PENDING")
    payload = {
        "tool": "check_environment_baseline_intake",
        "result": result,
        "production_mutations": 0,
        "report": str(args.report),
        "captures": str(args.captures),
        "required_resolution": [1600, 900],
        "required_routes": list(ROUTES),
        "allowed_decisions": list(DECISIONS),
        "report_has_telemetry": report_has_telemetry,
        "report_has_all_routes": report_has_all_routes,
        "routes": routes,
        "note": "READY confirma apenas completude de intake; não autoriza teste, hipótese ou produção R6.",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"[DEV7-ENV-INTAKE] result={result}")
    return 0 if result in {"PENDING", "READY_FOR_DEV7_RECONCILIATION"} else 2


if __name__ == "__main__":
    raise SystemExit(main())
