@import CoreGraphics;

namespace sipng {
  void deleter(char * ptr) { delete[] ptr; }
  char * load_native(unsigned * w, unsigned * h, const char * fn, unsigned fns);
}

char * sipng::load_native(unsigned * w, unsigned * h, const char * fn, unsigned fns) {
  if (w) *w = 0;
  if (h) *h = 0;

  CFURLRef url = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8 *)fn, fns, false);
  CGDataProviderRef src = CGDataProviderCreateWithURL(url);
  CGImageRef img = CGImageCreateWithPNGDataProvider(src, NULL, NO, kCGRenderingIntentDefault);

  if (!img) return nullptr;

  unsigned width = CGImageGetWidth(img);
  unsigned height = CGImageGetHeight(img);
  if (w) *w = width;
  if (h) *h = height;

  char * res = new char[width * height * 4];
  CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
  CGContextRef ctx = CGBitmapContextCreate(res, width, height, 8, width * 4, cs, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

  CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), img);

  CGContextRelease(ctx);
  CGColorSpaceRelease(cs);
  CGImageRelease(img);
  CGDataProviderRelease(src);
  CFRelease(url);

  return res;
}
