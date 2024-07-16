#include "Autokey.h"
#include "string.h"
#include "stdio.h"
#include <stdlib.h>
#include <GLFW/glfw3.h>

static void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
        glfwSetWindowShouldClose(window, GLFW_TRUE);
}

int main(int argc, char **argv) 
{
	#if defined(PLATFORM_DARWIN)
	{
    	printf("Building for Darwin\n");
	}
	#elif defined(PLATFORM_LINUX)
	{
    	printf("Building for Linux\n");
	}
	#elif defined(PLATFORM_WINDOWS)
	{
		printf("Building for Windows\n");
	}
	#else
	{
    	printf("Unsupported system\n");
	}
	#endif
	glfwInit();
	GLFWwindow* window = glfwCreateWindow(640, 480, "My Title", NULL, NULL);
	while (!glfwWindowShouldClose(window))
	{
		glfwSetKeyCallback(window, key_callback);
	}
	glfwTerminate();
return 0;
}
