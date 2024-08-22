#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char **argv)
{
char *token, *string, *tofree;

tofree = string = strdup("00:01:30.500");
while ((token = strsep(&string, ":.")) != NULL)

printf("%s\n", token);

free(tofree);
}
