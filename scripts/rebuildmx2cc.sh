
source common.sh

echo ""
echo "***** Rebuilding mx2cc *****"
echo ""

$mx2cc makemods -clean -verbose -config=release monkey libc miniz stb-image stb-image-write stb-vorbis zlib std

$mx2cc makeapp -clean -verbose -apptype=console -config=release -product=scripts/mx2cc.products/mx2cc_$host ../src/mx2cc/mx2cc.monkey2

cp mx2cc.products/mx2cc_$host $mx2cc
