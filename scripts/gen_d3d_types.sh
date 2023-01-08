cat > headers <<- EOM
#define static
#define __buildmemorybarrier() {}
#define _CONST_RETURN
#define LPCONTEXT int
#define __inline
#define _MarkAllocaS mark_alloca_s
#define PtrToPtr64 ptrtoptr64
#define Ptr64ToPtr ptr64toptr
#define HandleToHandle64 handletohandle64
#define Handle64ToHandle handle64tohandle
#define _TEB _XSTATE_CONTEXT
typedef unsigned short wchar_t;
EOM

DxPath=/opt/projects/3rd/pop3/dxsdk/Include

parse_header() {
    cp ./headers ./header_1
    echo $2 >> ./header_1
    cat ./header_1 | i686-w64-mingw32-gcc -std=c99 -D__restrict__="" -U_AMD64_ -I${DxPath} -P -E - | sed 's/__asm__ .*);/\/\*__asm__\*\//g' > $1

    sed "s/typedef PCONTEXT int;//" -i $1
    sed -e "/void MemoryBarrier/,+17d" -i $1
    rm ./header_1
}

parse_header ./ddraw.h "#include <ddraw.h>"
parse_header ./d3d.h "#include <d3d.h>"
parse_header ./dsound.h "#include <dsound.h>"

rm headers
