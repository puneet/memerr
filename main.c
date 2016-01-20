#include <dlfcn.h>

typedef void (*routines_t)(void);

int main(int argc, char*argv[]) {
  void* dll = 0;
  dll = dlopen("./foo.so", RTLD_LAZY);
  void* table = dlsym(dll, "startup_routines");
  routines_t* routines = (routines_t*)table;
  unsigned tmp;
  for (tmp = 0 ;  routines[tmp] ;  tmp += 1) {
    (routines[tmp])();
  }
}
