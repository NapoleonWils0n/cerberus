#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


/* help status */
void status ();

int main (int argc, char **argv)
{
  /* variables */
  char *start;
  char *end;
  char t[] = NULL;
  int c;

  opterr = 0;

  /* getopts */
  while ((c = getopt (argc, argv, ":s:e:h")) != -1)
    switch (c)
      {
      case 's':
        start = optarg;
        break;
      case 'e':
        end = optarg;
        break;
      case 'h':
        status();
        break;
      case ':':
        printf("option needs a value\n"); 
        break;
      case '?':
        printf("unknown option: %c\n", optopt);
        break;
      default:
        abort ();
      }

  printf("start = %s, end = %s\n",
          start, end);

  return 0;
}

/* status */
void status () 
{
  printf("sexagesimal-time -s 00:00:00 -e 00:00:00\n");
}
