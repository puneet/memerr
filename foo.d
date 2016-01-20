import std.stdio;
import core.thread;

void main() {
  writeln("Start frop from D");
  frop();
}

extern(C) void initialize() {
  import core.runtime;  
  Runtime.initialize;
  writeln("Start frop from C");
  frop();
  Runtime.terminate();
}

void foo() {
  Dynamic obj = new Dynamic;
  obj.proc();
  for (size_t i; i!=100; ++i) {
    obj.rehash();
    if(Dynamic.dash[0] != '-') {
      writeln(i, " -> ", Dynamic.dash);
      return;
    }
  }
  writeln("Successfully completed loop....");
}

void frop() {
  // foo(); // a direct call is not corrupting
  Thread bar = new Thread(&foo);
  bar.start();
  bar.join();
}

final class Hash {
  private bool[int] _m_map;
  private Dynamic[10000] objs;
  this() {
    foreach(ref obj; objs) {
      obj = new Dynamic;
    }
  }
  public void clear() {
    // only a static instance of Hash is used
    // no synchronized region required -- but still
    _m_map = null;
  }
}

class Dynamic {
  static char[] space; 
  static char[] dash;
  void rehash () {
    static Hash hash ;
    hash = new Hash;
    hash.clear();
  }
  void proc () {
    dash.length = 32;
    dash[] = '-';
  }
} 
