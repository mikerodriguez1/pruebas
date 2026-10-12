#!/bin/bash

echo "Iniciando TeleStream para verificar cambios..."

# Iniciar la aplicación en segundo plano
python3 app.py &
SERVER_PID=$!

# Esperar 2 segundos a que el servidor levante
sleep 2

# Abrir el navegador en la dirección local
xdg-open http://127.0.0.1:5000

echo "¡Listo! El navegador debería haberse abierto."
echo "Para cerrar el servidor, presiona Ctrl+C en esta terminal cuando termines."

# Mantener el script activo para poder cerrar el servidor con Ctrl+C
wait $SERVER_PID
