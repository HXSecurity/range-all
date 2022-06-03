#!/bin/sh

case "$1" in
-q|--quiet) quiet="-D-Dorg.owasp.esapi.logSpecial.discard=true"; shift  ;;
*)          quiet=""    ;;
esac
mvn ${quiet} initialize
mvn ${quiet} package cargo:run -Pdeploywdongtai
