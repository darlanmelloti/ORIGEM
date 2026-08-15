# Take 5 cycle 1 findings

The three cave braziers were added and set to #5CC8FF, energy 2.5, range 8 m. F5 completed without script parser errors, and a 30-second MP4 plus 1600x900 print were produced. The print remains black with only the crosshair, so lighting alone did not solve the acceptance issue. The next correction moves the deterministic camera to the cave mouth to isolate clipping/occlusion while retaining the same light setup.

## Take 5 cycle 2 findings

The cave-mouth camera now renders a clear 1600×900 frame: organic rock walls, river, Kharu markers, HUD, and the route are visible. The black-frame failure is therefore caused by the deeper camera position/clipping, not solely missing lights. The composition still reads as an exterior corridor rather than the intended cave interior, and the validation camera is static. Next cycle: animate the camera slowly from the mouth toward the first illuminated rock corridor while keeping the safe limit outside the clipping zone.

## Take 5 cycle 5 findings

Timed captures show the scene is fully visible at 5, 10, and 15 seconds, with the valley/canyon walls, river, blue fissures, and HUD readable. The scene becomes black by 20 seconds and remains black at 25–30 seconds. The 15-second frame is not inside solid geometry, so the failure is a timed transition or process/camera state change, not the initial spawn or lack of blue light. The next correction must isolate the cause of this delayed black transition before declaring the Take 5 evidence valid.

## Take 5 cycle 6 root cause

Process-state diagnostics show Godot is alive at 5, 10, and 15 seconds, then dead at 20 seconds. The launch used `--quit-after 40`; in Godot this value is a frame count, not seconds. With the heavy llvmpipe capture path, 40 frames took approximately 16 seconds, after which the Xvfb display remained black. The blue-light and safe camera corrections are valid; the validation harness must omit `--quit-after` or use a sufficiently large frame count, then terminate the process only after the 30-second recording.
