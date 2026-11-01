/* The collector's entry points as the runtime archives built for --gc=none
   (-DSP_GC_NONE: lib/libspinel_rt_nogc.a and its variants) define them. The
   archive's own members and the program's TU take the inline forms of
   lib/sp_gc.h, which mark nothing and name none of these; an object built
   with the collector that links such an archive -- a package's native
   object, or one the program links itself -- still calls the markers from
   its scan functions, and here each does nothing, since no collection runs
   (#10699). The define is dropped for this one file so the header declares
   the names it defines. A build that compiles every lib/*.c without the
   define (the CRuby extension's, tools/cext) gets nothing from it: sp_gc.c
   defines the markers there. */
#ifdef SP_GC_NONE
#undef SP_GC_NONE
#include "sp_gc.h"

void sp_gc_mark(void *obj) { (void)obj; }
void sp_gc_mark_str(const char *s) { (void)s; }
#else
typedef int sp_gc_none_not_this_build;
#endif
