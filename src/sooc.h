#pragma once

#include <stdbool.h>

struct app_state {
	// Mouse
	// Time
	bool quit_requested;
	struct SDL_Window* main_window;
    struct SDL_GLContext* gl_context;
};
