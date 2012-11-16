cat > mycprogram.c << EOF
#include <stdio.h>
int main(int argc, char *argv[])
{
    char array[] = { 0x25, 115, 0 };
    char array2[] = { 68, 0x61, 118, 0x69, 0144, 040,
                        0107, 97, 0x74, 119, 0157, 0x6f,
                        100, 0x20, 0x72, 117, 'l', 0x65,
                        115, 041, 012, 0 };
    printf(array, array2);
}
EOF