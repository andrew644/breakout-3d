package game

import "core:c"
import rl "vendor:raylib"


run: bool
camera: rl.Camera
sound: rl.Sound

init :: proc() {
	run = true
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.SetConfigFlags(rl.ConfigFlags{rl.ConfigFlag.MSAA_4X_HINT})
	rl.InitWindow(1000, 1000, "Game")
	rl.InitAudioDevice()
	rl.SetMasterVolume(1)
	rl.SetTargetFPS(60)

	camera.position = {2, 4, 6}
	camera.target = {0, 0, 0}
	camera.up = {0, 1, 0}
	camera.fovy = 90
	camera.projection = rl.CameraProjection.PERSPECTIVE

	//sound = rl.LoadSound("assets/knifeSlice.ogg")
	sound = rl.LoadSound("assets/test.wav")
}

update :: proc() {
	if rl.IsKeyPressed(rl.KeyboardKey.SPACE) {
		rl.TraceLog(rl.TraceLogLevel.INFO, "SPACE")
		rl.PlaySound(sound)
	}
	rl.BeginDrawing()
	{
		rl.ClearBackground({33, 33, 200, 255})

		rl.BeginMode3D(camera)
		{
			rl.DrawPlane(rl.Vector3(0), {10, 10}, rl.WHITE)
			rl.DrawCube(rl.Vector3(0), 2, 4, 2, rl.GRAY)
		}
		rl.EndMode3D()

		rl.DrawFPS(10, 10)
	}
	rl.EndDrawing()

	free_all(context.temp_allocator)
}

parent_window_size_changed :: proc(width, height: int) {
	rl.SetWindowSize(c.int(width), c.int(height))
}

shutdown :: proc() {
	rl.UnloadSound(sound)
	rl.CloseAudioDevice()
	rl.CloseWindow()
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		if rl.WindowShouldClose() {
			run = false
		}
	}

	return run
}
