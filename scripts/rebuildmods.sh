
source common.sh

echo ""
echo "***** Rebuilding modules *****"
echo ""

$mx2cc makemods -clean -verbose -target=desktop -config=release
$mx2cc makemods -clean -verbose -target=desktop -config=debug
