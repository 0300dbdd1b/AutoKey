#include "Autokey.h"
#include "string.h"
#include "stdio.h"





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
return 0;
}
