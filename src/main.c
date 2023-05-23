#include "game.h"
#include  "sooc.h"

#include "SDL.h"
#include "SDL_opengl.h"

#include "soloud_c.h"

#include <stdio.h>

int sys_update(struct app_state* app_state)
{
	// Render
	SDL_GL_SwapWindow(app_state->main_window);

	// Input
	SDL_Event event;
	while (SDL_PollEvent(&event)) {
		if (event.type == SDL_QUIT) {
			app_state->quit_requested = true;
		}
		if (event.type == SDL_WINDOWEVENT) {
			printf("Window changed\n");
		}
	}

	return (app_state->quit_requested) ? -1 : 0;
}

int main(int argc, char** argv)
{
	if (SDL_Init(SDL_INIT_VIDEO) < 0) {
		fprintf(stderr, "Error initializing SDL");
		return -1;
	}

	//SDL_GLContext maincontext;
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 2);

	SDL_GL_SetAttribute(SDL_GL_DOUBLEBUFFER, 1);
	SDL_GL_SetAttribute(SDL_GL_DEPTH_SIZE, 24);

//	Soloud* soloud = Soloud_create();
//	Soloud_initEx(soloud, SOLOUD_CLIP_ROUNDOFF | SOLOUD_ENABLE_VISUALIZATION, SOLOUD_AUTO, SOLOUD_AUTO, SOLOUD_AUTO, SOLOUD_AUTO);

	struct app_state app_state = { 0 };

	app_state.main_window = SDL_CreateWindow(
		APP_NAME,
		SDL_WINDOWPOS_CENTERED,
		SDL_WINDOWPOS_CENTERED,
		512, 512,
		SDL_WINDOW_OPENGL | SDL_WINDOW_SHOWN);

	if (app_state.main_window == NULL)
	{
		fprintf(stderr, "Unable to create main window");
		return -1;
	}

	while (app_state.quit_requested == false) 
	{
		sys_update(&app_state);
		game_update(&app_state);
	}

	return 0;
}
