export module sipng;
import hay;
import jute;

namespace sipng {
  extern "C++" void deleter(char *);
  extern "C++" char * load_native(unsigned * w, unsigned * h, const char * fn, unsigned fns);

  export struct image {
    unsigned width;
    unsigned height;
    hay<char *, nullptr, deleter> data;
  };

  export image load(jute::view file) {
    image res {
      .data = { load_native(&res.width, &res.height, file.begin(), file.size()) },
    };
    return res;
  }
}

#ifdef LECO_TARGET_APPLE
#pragma leco add_impl apple
#endif
