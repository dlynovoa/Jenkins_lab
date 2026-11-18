#!/usr/bin/env bash
echo "Verificando integridad de los archivos de app..."
if [ ! -f app/index.html ]; then
    echo "FAIL: No se encontro app/index.html"
    exit 1
fi

if ! grep -q "<h1>" app/index.html; then
    echo "FAIL: app/index.html no contiene una etiqueta <h1>"
    exit 1
fi

echo "PASS: Validacion exitosa."
exit 0
