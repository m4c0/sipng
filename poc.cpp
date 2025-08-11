#pragma leco test

import print;
import sipng;

int main() {
  auto [w, h, d] = sipng::load("poc.png");
  char * data = d;

  putln("Got ", w, "x", h, " image");
  putfn("First pixel: %02hhx %02hhx %02hhx %02hhx",
      data[0], data[1], data[2], data[3]);
}
