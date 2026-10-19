#!/usr/bin/env bash
echo "Verificando integridad de los archivos de app..."
if [ -f app/index.html ]; then
    echo "PASS: El archivo app/index.html existe."
    exit 0
else
    echo "FAIL: No se encontro app/index.html"
    exit 1
fi
