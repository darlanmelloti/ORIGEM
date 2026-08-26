#!/usr/bin/env python3
"""Mede diferenças de fotogramas para a auditoria visual R5."""
from __future__ import annotations

import json
from pathlib import Path

import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parents[2]
CAPTURES = ROOT / "reports" / "r5" / "captures"
FILES = [CAPTURES / f"majestic_wind_frame_{index:02d}.png" for index in (1, 2, 3)]


def load(path: Path) -> np.ndarray:
    with Image.open(path) as image:
        return np.asarray(image.convert("RGB"), dtype=np.int16)


def stats(first: np.ndarray, second: np.ndarray) -> dict[str, float | int]:
    delta = np.abs(second - first)
    mean_per_pixel = delta.mean(axis=2)
    changed = mean_per_pixel > 1.0
    return {
        "mean_rgb_delta": round(float(delta.mean()), 5),
        "max_rgb_delta": int(delta.max()),
        "changed_pixels": int(changed.sum()),
        "changed_ratio": round(float(changed.mean()), 7),
    }


def main() -> None:
    frames = [load(path) for path in FILES]
    if any(frame.shape != frames[0].shape for frame in frames):
        raise SystemExit("[ORIGEM_R5_WIND_VISUAL_ERROR] dimensões de captura inconsistentes")

    result = {
        "resolution": [int(frames[0].shape[1]), int(frames[0].shape[0])],
        "frame_01_to_02": stats(frames[0], frames[1]),
        "frame_02_to_03": stats(frames[1], frames[2]),
    }
    print("[ORIGEM_R5_WIND_VISUAL] " + json.dumps(result, ensure_ascii=False, sort_keys=True))
    if result["frame_01_to_02"]["changed_pixels"] <= 0 or result["frame_02_to_03"]["changed_pixels"] <= 0:
        raise SystemExit("[ORIGEM_R5_WIND_VISUAL_ERROR] não houve variação temporal mensurável")
    print("[ORIGEM_R5_WIND_VISUAL_OK] variação temporal discreta mensurável; enquadramento estável")


if __name__ == "__main__":
    main()
