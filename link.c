extern void initialize();

void (*startup_routines[])() = {
  initialize,
  0
};
