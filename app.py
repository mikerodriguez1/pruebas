from flask import Flask, jsonify, render_template

app = Flask(__name__)

# Aquí continúan tus demás funciones (como @app.route...)
import re

@app.route('/api/continuar-viendo')
def continuar_viendo():
    """Filtra el historial para que cada serie o película aparezca una sola vez con su último avance."""
    # Tu historial bruto de reproducción
    historial_bruto = [] # (Aquí va tu lista actual de historial)
    
    vistos_unicos = {}
    for item in historial_bruto:
        # Limpiamos el nombre para detectar la serie base (ej: "Rick y Morty")
        nombre_raw = item.get('nombre', '')
        nombre_base = re.sub(r'(temporada\s*\d+|temp\s*\d+|s\d+e\d+|capitulo\s*\d+|episodio\s*\d+).*', '', nombre_raw, flags=re.IGNORECASE).strip()
        if not nombre_base:
            nombre_base = nombre_raw
            
        # Mantiene únicamente el registro más reciente de esa serie/película
        vistos_unicos[nombre_base] = item
        
    return jsonify(list(vistos_unicos.values()))

# ---- Clasificación de categorías estilo Netflix ----
import re as _re_categorias

SUFIJO_CATEGORIA = {
    "K": "K-Dramas",
    "A": "Animación",
    "I": "Infantil",
    "AN": "Anime",
}

def detectar_categoria(nombre_serie: str, grupo: str) -> str:
    if grupo == "peliculas":
        return "Películas"
    m = _re_categorias.search(r"\s([A-Z]{1,2})$", nombre_serie.strip())
    if m and m.group(1) in SUFIJO_CATEGORIA:
        return SUFIJO_CATEGORIA[m.group(1)]
    return "Series"
import os

if __ name__ == '__main__':
    port = int(os.environ.get("PORT", 8787))
    app.run(host="0.0.0.0", port=port)
