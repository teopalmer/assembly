#include <stdio.h>
#include <string.h>

#define N 255

int assemblyStrLen(const char *s)
{
    int n = 0;
    const char *str_copy = s;

    __asm__(
        "mov $0, %%al\n\t"
        "mov %1, %%rdi\n\t"
        "mov $0xffffffff, %%ecx\n\t"
        "repne scasb\n\t"
	"not %%ecx\n\t"
        "dec %%ecx\n\t"
        "mov %%ecx, %0"
        : "=r"(n)
        : "r"(str_copy)
        : "%ecx", "%rdi", "%al");

    return n;
}

void strcopy(char *dest, char *src, int len);

int main()
{
    	const char *str = "Hello World!.";
	char src[N] = "Documentation is a love letter.";
	char dest[N] = "That you write to yourself.";

    	printf("%d %d\n", assemblyStrLen(str), strlen(str));
	printf("%s %s\n", src, dest);
	strcopy(src, dest, assemblyStrLen(str));
	printf("%s %s\n", src, dest);
    	return 0;
}
