#include <stdbool.h>

#include "errno.h"
#include "ctype.h"

/*Copyright 2018 Benji Dial*/

size_t _pos;
volatile uint16_t *_buf;
uint8_t _color;

/*TODO: remove*/
/*TODO: rename*/
/*TODO: tmpfile*/
/*TODO: tmpnam*/
/*TODO: fclose*/
/*TODO: fflush*/
/*TODO: fopen*/
/*TODO: freopen*/
/*TODO: setbuf*/
/*TODO: setvbuf*/
/*TODO: fprintf*/
/*TODO: fscanf*/
/*TODO: printf*/
/*TODO: scanf*/
/*TODO: snprintf*/
/*TODO: sprintf*/
/*TODO: sscanf*/
/*TODO: vfprintf*/
/*TODO: vfscanf*/
/*TODO: vprintf*/
/*TODO: vscanf*/
/*TODO: vsnprintf*/
/*TODO: vsprintf*/
/*TODO: vsscanf*/
/*TODO: fgetc*/
/*TODO: fgets*/
/*TODO: fputc*/
/*TODO: fputs*/
/*TODO: getc*/
/*TODO: getchar*/
/*TODO: gets*/
/*TODO: putc*/

bool _putchar(uint16_t character) {
  if (iscontrol(character % 0x0100))
    switch (character % 0x0100) {
     /*TODO: 0x00 - 0x07*/
     case 0x08:
      buf[--_pos] = (character & 0xff00) | 0x0020;
      break;
     /*TODO: 0x09*/
     case 0x0a:
      pos = (pos / 80 + 1) * 80;
      break;
     /*TODO: 0x0b - 0x0c*/
     case 0x0d:
      pos = (pos / 80) * 80;
      break;
     /*TODO: 0x0e - 0x1f*/
     case 0x7f:
      buf[_pos] = (character & 0xff0) | 0x0020;
    }
  buf[_pos++] = character;
  return true;
}

int putchar(int character) {
  return (_putchar(((uint16_t)_color << 8) + (uint16_t)character)) ? character : EOF;
}

int _puts(const char *str) {
  uint16_t _ = (uint16_t)_color << 8;
  for (size_t i = 0; str[i] != 0; i++)
    _putchar(_ + str[i]);
}

int puts(const char *str) {
  if (_puts(str) == EOF)
    return EOF;
  pos = (pos / 80 + 1) * 80;
}

/*TODO: ungetc*/
/*TODO: fread*/
/*TODO: fwrite*/
/*TODO: fgetpos*/
/*TODO: fseek*/
/*TODO: fsetpos*/
/*TODO: ftell*/
/*TODO: rewind*/
/*TODO: clearerr*/
/*TODO: feof*/
/*TODO: ferror*/

void perror(const char *str) {
  if (str) {
    _puts(str);
    putchar(':');
    putchar(' ');
  }
  switch (errno) {
   case 0:
    puts("No error");
    break;
   case EDOM:
    puts("Domain error");
    break;
   case ERANGE:
    puts("Range error");
    break;
   case EILSEQ:
    puts("Encoding error");
    break;
   default:
    puts("Error");
  }
}

/*TODO: BUFSIZ*/

#define EOF -128

/*TODO: FILENAME_MAX*/
/*TODO: FOPEN_MAX*/
/*TODO: L_tmpnam*/

#define NULL (void *)0

/*TODO: TMP_MAX*/


enum buf_mode {
  _IOFBF,
  _IOLBF,
  _IONBF
}

enum seek_origin {
  SEEK_SET,
  SEEK_CUR,
  SEEK_END
}

/*TODO: FILE*/
/*TODO: fpos_t*/
/*TODO: size_t*/
