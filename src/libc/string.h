/*Copyright 2018 Benji Dial*/

#define NULL (void *)0

/*TODO: wchar_t*/

/*TODO: wint_t*/

/*TODO: wint_t*/

/*TODO: mbstate_t*/

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
  char *src_ = src;
  size_t len = 0;
  while (*(src_++))
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
  char *src_ = src, ch_ = (char)ch;
  while (*(src_++))
    ;
  if (!ch_)
    return src_;
  while (*--src_ != ch_)
    if (src_ == src)
      return NULL;
  return src_;
}

/*TODO: rest*/
