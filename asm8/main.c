#include <stdio.h>

float calc(float a, float b, char sign)
{
    float result;

    __asm__(
         "flds %2\n\t"
        "flds %1\n\t"
        "mov %3, %%al\n\t"

        "cmp $43, %%al\n\t"
        "je plus\n\t"
        "cmp $45, %%al\n\t"
        "je minus\n\t"
        "cmp $42, %%al\n\t"
        "je asterisk\n\t"
        "cmp $47, %%al\n\t"
        "je backslash\n\t"

        "plus:\n\t"
        "faddp\n\t"
        "jmp quit\n\t"

        "minus:\n\t"
        "fsubp\n\t"
        "jmp quit\n\t"

        "asterisk:\n\t"
        "fmulp\n\t"
        "jmp quit\n\t"

        "backslash:\n\t"
        "fdivp\n\t"
        "quit:\n\t"
        "fstps %0"
        : "=m"(result)
        : "m"(a), "m"(b), "m"(sign)
        : "%al");

    return result;
}

int main()
{
    float a, b;
    char sign;

    printf("Enter a, sign, b: ");
    scanf("%f %c %f", &a, &sign, &b);

    printf("Result: %f\n", calc(a, b, sign));

    return 0;
}
