#include "Autokey.h"
#include "string.h"
#include "stdio.h"

int main(int argc, char **argv)
{
	if (!strcmp(SYSTEM, "Darwin"))
	{
		printf("Darwin");
	}
	else if (!strcmp(SYSTEM, "Windows"))
	{
		printf("Windows");
	}
	else if (!strcmp(SYSTEM, "Linux"))
	{
		printf("Linux");
	}
	else
	{
		printf("Unsuported OS");
	}
	return 0;
}
