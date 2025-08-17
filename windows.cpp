module sipng;

extern "C++" void sipng::deleter(char * ptr) { delete[] ptr; }
extern "C++" char * sipng::load_native(unsigned * w, unsigned * h, const char * fn, unsigned fns) {
#error Good luck trying to understand how to do that with Windows-based APIs in 2025
  return new char[0];
}
