#pragma once

#include <stdbool.h>

struct appstate {
	// Mouse
	// Time
	bool quit_requested;
	struct SDL_Window* main_window;
};
