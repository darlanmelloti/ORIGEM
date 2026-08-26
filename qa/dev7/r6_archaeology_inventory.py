#!/usr/bin/env python3
"""Gera inventário espacial QA de elementos arqueológicos R6 existentes.
Não escreve nem instancia nós do projeto; apenas reproduz as fórmulas espaciais documentadas.
"""
from __future__ import annotations

from math import cos, pi, sin, sqrt, tau

ANCHOR_X = 60.0
ANCHOR_Z = 252.0
ROUTE_START_Z = ANCHOR_Z - 58.0
ROUTE_END_Z = ANCHOR_Z - 27.0


def lerp(start: float, end: float, amount: float) -> float:
    return start + (end - start) * amount


def path_x(world_z: float) -> float:
    t = max(0.0, min(1.0, (world_z - 116.0) / 124.0))
    return lerp(-9.0, 4.0, t) + sin(t * tau) * 2.4


def lake_shore_x(world_z: float) -> float:
    start_z = ANCHOR_Z - 107.0
    end_z = ANCHOR_Z - 28.0
    t = max(0.0, min(1.0, (world_z - start_z) / (end_z - start_z)))
    return lerp(path_x(start_z), ANCHOR_X - 46.0, t) + sin(t * pi) * 3.25 + sin(t * tau) * 0.85


def distance_to_route(x: float, z: float) -> float:
    samples = 1000
    best = float("inf")
    for index in range(samples + 1):
        z_sample = lerp(ROUTE_START_Z, ROUTE_END_Z, index / samples)
        x_sample = lake_shore_x(z_sample)
        best = min(best, sqrt((x - x_sample) ** 2 + (z - z_sample) ** 2))
    return best


def category(distance: float) -> str:
    if distance <= 4.0:
        return "imediata"
    if distance <= 10.0:
        return "próxima"
    return "média"


def append_element(rows: list[tuple[str, str, float, float, float, str]], name: str, form: str, x: float, z: float, scale: float, material: str) -> None:
    rows.append((name, form, x, z, distance_to_route(x, z), material))


def main() -> None:
    rows: list[tuple[str, str, float, float, float, str]] = []

    approach_specs = [
        (ANCHOR_Z - 52.0, -1.0, 10.8, 0.54),
        (ANCHOR_Z - 38.0, 1.0, 11.8, 0.62),
        (ANCHOR_Z - 31.0, -1.0, 8.7, 0.47),
    ]
    for index, (z, side, offset, scale) in enumerate(approach_specs, start=1):
        x = lake_shore_x(z) + side * offset
        append_element(rows, f"Vestígio de aproximação {index:02d}", "pilar inclinado", x, z, scale, "ruin_material")

    arrival_z = ANCHOR_Z - 26.0
    arrival_x = lake_shore_x(arrival_z)
    for index, (side, scale) in enumerate([(-1.0, 1.05), (1.0, 0.88)], start=1):
        append_element(rows, f"Vestígio de entrada {index:02d}", "pilar emergente", arrival_x + side * 4.35, arrival_z + side * 0.72, scale, "ruin_material")

    for index in range(8):
        angle = index * tau / 8.0
        x = ANCHOR_X + cos(angle) * (22.2 + (index % 3) * 0.74)
        z = ANCHOR_Z + sin(angle) * (17.1 + ((index + 1) % 3) * 0.62)
        append_element(rows, f"Pilar submerso {index:02d}", "pilar submerso", x, z, 0.68 + (index % 4) * 0.17, "ruin_material")

    for index in range(3):
        append_element(rows, f"Marco emergente {index:02d}", "pilar alto emergente", ANCHOR_X - 17.0 + index * 16.5, ANCHOR_Z - 9.0 + index * 5.0, 1.82 - index * 0.15, "ruin_material")

    append_element(rows, "Domo submerso do Hub", "cúpula achatada", ANCHOR_X, ANCHOR_Z, 1.32, "ruin_material")
    append_element(rows, "Estela da chegada", "estela vertical", ANCHOR_X - 8.0, ANCHOR_Z - 21.0, 0.86, "ruin_material")

    print("# Inventário espacial QA — R6 Archaeology Material Silhouette Audit")
    print()
    print("| Elemento existente | Forma | Posição X/Z estimada | Distância mínima à rota | Faixa | Material |")
    print("|---|---|---:|---:|---|---|")
    for name, form, x, z, distance, material in rows:
        print(f"| {name} | {form} | ({x:.2f}, {z:.2f}) | {distance:.2f} m | {category(distance)} | {material} |")
    print()
    print("## Parâmetros da rota QA")
    print()
    print(f"- Início `forest_to_ruins`: ({lake_shore_x(ROUTE_START_Z):.2f}, {ROUTE_START_Z:.2f})")
    print(f"- Alvo técnico antes da bacia: ({lake_shore_x(ROUTE_END_Z):.2f}, {ROUTE_END_Z:.2f})")
    print(f"- Centro cartográfico R6: ({ANCHOR_X:.2f}, {ANCHOR_Z:.2f})")


if __name__ == "__main__":
    main()
