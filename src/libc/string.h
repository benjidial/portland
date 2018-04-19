#include <stdint.h>

/*
#include "stdlib.h"
*/

/*Copyright 2018 Benji Dial*/

#define NULL (void *)0

void *memcpy(void *destination, const void *source, size_t num) {
  uint8_t *src_ = source, *dest_ = destination;
  while (num--)
    *(dest_++) = *(src_++);
  return destination;
}

/*
void *memmove(void *destination, const void *source, size_t num) {
  void *tmp = malloc(num);
  memcpy(tmp, source);
  return memcpy(destination, tmp);
}
*/

int memcmp(const void *ptr1, const void *ptr2, size_t num) {
  uint8_t *ptr1_ = ptr1, *ptr2_ = ptr2;
  int dif = 0;
  while (num--)
    if (dif = *(ptr1_++) - *(ptr2_++))
      return dif;
  return 0;
}

char *strcpy(char *dest, const char *src) {
  char *src_ = src, *dest_ = dest;
  do
    *(dest_++) = *(src_++);
  while (*dest_);
  return dest;
}

char *strncpy(char *dest, const char *src, size_t count) {
  if (count) {
    char *src_ = src, *dest_ = dest;
    do
      *(dest_++) = *(src_++);
    while (--count && *src_);
    while (count--)
      *(dest_++) = '\0';
  }
  return dest;
}

char *strcat(char *dest, const char *src) {
  char *src_ = src, *dest_ = dest;
  if (*dest_)
    while (*++dest_)
      ;
  do
    *(dest_++) = *(src_++);
  while (*dest_);
  return dest;
}

char *strncat(char *dest, const char *src, size_t count) {
  char *src_ = src, *dest_ = dest;
  if (*dest_)
    while (*++dest_)
      ;
  do
    *(dest_++) = *(src_++);
  while (--count && *dest_);
  *dest_ = '\0';
  return dest;
}

/*TODO: strxfrm*/

size_t strlen(const char *str) {
  char *str_ = str;
  size_t len = 0;
  while (*(str_++))
    len++;
  return len;
}

int strcmp(const char *lhs, const char *rhs) {
  int dif;
  char *lhs_ = lhs, *rhs_ = rhs;
  do
    if (*lhs_ || *lhs_)
      return 0;
  while (!(dif = *(lhs_++) - *(rhs_++)));
  return dif;
}

int strncmp(const char *lhs, const char *rhs, size_t count) {
  int dif;
  char *lhs_ = lhs, *rhs_ = rhs;
  do
    if (!((count--) && (*lhs_ || *lhs_)))
      return 0;
  while (!(dif = *(lhs_++) - *(rhs_++)));
  return dif;
}

/*TODO: strcoll*/

void *memchr(const void *ptr, int value, size_t num) {
  uint8_t *ptr_ = ptr - 1;
  while (num--)
    if (*++ptr_ == value)
      return ptr_;
  return NULL;
}

char *strchr(const char *str, int ch) {
  char *str_ = str, ch_ = (char)ch;
  if (*str_ == ch_)
    return str_;
  while (*++str_ != ch_)
    if (!*str_)
      return NULL;
  return str_;
}

char *strrchr(const char *str, int ch) {
  char *str_ = str, ch_ = (char)ch;
  while (*(str_++))
    ;
  if (!ch_)
    return str_;
  while (*--str_ != ch_)
    if (str_ == str)
      return NULL;
  return str_;
}

/*TODO: strspn*/
/*TODO: strpbrk*/
/*TODO: strcspn*/
/*TODO: strstr*/
/*TODO: strtok*/

void *memset(void *ptr, int value, size_t num) {
  uint8_t *ptr_ = ptr;
  while (num--)
    *(ptr_++) = value;
  return ptr;
}

char *strerror(int errnum) {
  switch (errnum) {
   case 0:
    return "No error";
    break;
   case EDOM:
    return "Domain error";
    break;
   case ERANGE:
    return "Range error";
    break;
   case EILSEQ:
    return "Encoding error";
    break;
   default:
    return "Error";
  }
}
