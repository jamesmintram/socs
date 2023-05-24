local BUILD_DIR = path.join("build", _ACTION)

local VENDOR_DIR = "vendor/"

solution "sglbase"
	location(BUILD_DIR)
	
	configurations { "Release", "Debug" }
	
    platforms "x86_64"

	filter "configurations:Release"
		optimize "Full"
	filter "configurations:Debug*"
		defines
		{
			"_DEBUG",
		}
		optimize "Debug"
		symbols "On"
	filter "platforms:x86_64"
		architecture "x86_64"
	filter "system:macosx"
		defines { "PLATFORM_OSX" }
		platforms { "MacOSX-x64", "MacOSX-ARM" }
		xcodebuildsettings {
			["MACOSX_DEPLOYMENT_TARGET"] = "10.9",
			["ALWAYS_SEARCH_USER_PATHS"] = "YES", -- This is the minimum version of macos we'll be able to run on
            ['ALWAYS_SEARCH_USER_PATHS'] = "NO",
		};

	filter {"system:windows"}
		defines { "PLATFORM_WINDOWS" }

	filter {"platforms:MacOSX-x64"}
		architecture "x64"

	filter {"platforms:MacOSX-ARM"}
		architecture "ARM"

project "sglbase"
	kind "ConsoleApp"
	language "C"
	debugdir "runtime"
	exceptionhandling "Off"
	rtti "Off"
	editandcontinue "Off"

	-- defines {
    --     "GL_GLEXT_PROTOTYPES"
    -- }

	files {"src/**.c", "src/**.h", "src/**.inl", "premake5.lua", "README.md", ".gitignore"}

	includedirs
	{
		"src",
        path.join(VENDOR_DIR, "SDL2/include"),
		path.join(VENDOR_DIR, "soloud/include"),
	}
    
	filter "system:windows"
	libdirs { 
        path.join(VENDOR_DIR, "SDL2/lib/x64"),
		path.join(VENDOR_DIR, "soloud/lib/x64"),
	}
	links { "SDL2", "SDL2main", "soloud" }
	-- links { "gdi32", "kernel32", "psapi" }
	-- filter "system:linux"
	-- 	links { "dl", "GL", "pthread", "X11" }
	filter "system:macosx"
    libdirs {
        path.join(VENDOR_DIR, "SDL2/lib/darwin"),
        path.join(VENDOR_DIR, "soloud/lib"),
    }
    links { "SDL2" }
    embed {
        "libSDL2.dylib",
    }
	-- 	links { "QuartzCore.framework", "Metal.framework", "Cocoa.framework", "IOKit.framework", "CoreVideo.framework" }
	-- 	linkoptions { 
	-- 		"-lc++",
	-- 	}
