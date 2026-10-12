# TeleStream v20

Biblioteca local de videos de Telegram con streaming por rangos, catálogo de series y organización automática de temporadas/episodios.

## Novedades v20 (diseño más "épico", estilo Netflix)

- **Flechas ‹ › en TODAS las filas**, no solo en Series: ahora cada grupo/chat de tu biblioteca y cada fila de resultados de búsqueda tiene botones para moverse a los episodios siguientes/anteriores, además de poder arrastrar con el mouse o el trackpad. Las flechas se ocultan solas cuando no hacen falta (fila corta) y se deshabilitan al llegar al final.
- El botón **"Ver todos"** para expandir un grupo entero en cuadrícula se mantiene igual que antes (no se tocó nada de esa lógica).
- **Banner principal dinámico**: en vez del texto genérico fijo, ahora el banner de arriba muestra una portada real de tu biblioteca (si subiste alguna `Nombre Serie.jpg/png` a Telegram) con botones **▶ Reproducir** y **ℹ Más información** que abren esa serie directamente. Si todavía no tienes portadas, se ve el banner genérico de siempre.
- **Fila "Continuar viendo" en Inicio**: igual que Netflix, lo que dejaste a medias aparece arriba de todo, antes que Series y los grupos.
- **Numeración tipo "Top 10"** sobre las primeras 10 portadas de la fila Series, con un acabado más "de plataforma de streaming".
- Las filas aparecen con una pequeña animación al hacer scroll, los títulos de fila llevan un acento de color, y las tarjetas tienen un efecto de zoom/elevación más marcado al pasar el mouse.
- Se corrigió una fuga de memoria menor: antes, cada carrusel escuchaba el evento `resize` de toda la ventana para siempre; ahora usa `ResizeObserver` por fila, así que sesiones largas con muchos grupos no acumulan listeners de más.
- Se agregó limpieza automática de cachés antiguos del Service Worker al actualizar, para que los cambios visuales se vean de inmediato sin tener que borrar caché a mano.

## Novedades v19

- **Catálogo de Series:** en Inicio aparece una tarjeta por serie, no una tarjeta por cada episodio.
- **Portadas personalizadas:** si subes una imagen a Telegram llamada, por ejemplo, `Los Simpson.jpg`, `Los Simpson portada.jpg` o `Los Simpson poster.png`, TeleStream la relaciona con la serie y la muestra como portada.
- La portada se sirve directamente desde Telegram en memoria; no se guarda permanentemente en el teléfono/PC.
- **Temporadas automáticas:** reconoce `Temporada 1`, `Season 1`, `S01E01`, `T1E01`, `1x01`, etc.
- Al abrir una serie aparece un selector de temporadas y una lista compacta de episodios.
- La lista de episodios no usa tarjetas grandes, por lo que una temporada larga es mucho más fácil de recorrer.
- Al tocar un episodio se abre la vista previa y desde ahí se inicia la reproducción.
- La pantalla conserva favoritos y progreso de reproducción.
- El streaming continúa usando rangos HTTP y no descarga el video completo al almacenamiento.
- Miniaturas y portadas ya no dependen de Pillow para funcionar en Android/Termux.
- **Streaming corregido:** se mantiene un solo iterador de Telegram durante cada respuesta Range, evitando respuestas `206` sin bytes o incompletas en Android/Termux.
- **Carrusel de series:** flechas para desplazarte por las series en Inicio y botón **Ver todas** para cambiar a una cuadrícula completa.
- **Portada personalizada funcional:** las imágenes de Telegram usadas como `Los Simpson.jpg` ahora tienen un endpoint propio para poder mostrarse realmente en las tarjetas y en el detalle.
- Corregido el cargador de episodios de series para que la comparación de nombres funcione correctamente.

## Cómo preparar una serie en Telegram

Ejemplo:

```text
Los Simpson.jpg
Los Simpson Temporada 1 Capitulo 1.mp4
Los Simpson Temporada 1 Capitulo 2.mp4
Los Simpson Temporada 1 Capitulo 3.mp4
Los Simpson Temporada 2 Capitulo 1.mp4
Los Simpson Temporada 2 Capitulo 2.mp4
```

La imagen `Los Simpson.jpg` se usa como portada y TeleStream mostrará:

```text
Series
┌───────────────┐
│   PORTADA     │
│  LOS SIMPSON  │
└───────────────┘
   Los Simpson

Al entrar:
Temporada 1 ▼

▶ 01  Episodio 1
▶ 02  Episodio 2
▶ 03  Episodio 3
```

## Linux Mint: instalación nueva

1. Extrae el ZIP.
2. Entra a la carpeta extraída.
3. Ejecuta `Instalar_TeleStream.sh`.
4. Abre **TeleStream** desde el menú de aplicaciones o el acceso directo del Escritorio.

## Linux Mint: actualizar una instalación existente

Si ya tienes `~/TeleStream` con tu sesión de Telegram, `.env` y ajustes:

1. Extrae este ZIP.
2. Ejecuta `Actualizar_TeleStream.sh`.
3. Abre TeleStream normalmente.

El actualizador **no borra ni reemplaza intencionalmente** `.env`, `sessions/`, `settings.json` ni `.venv/` de tu instalación existente.

## Android / Termux

El backend puede ejecutarse en Termux con la pila compatible de Python que ya utilizaste. No vuelvas a instalar el `requirements.txt` moderno del ZIP si tu Termux ya está usando las versiones antiguas compatibles.

Para actualizar manualmente una instalación existente, copia solamente el contenido de `telestream_v13/` sobre:

```text
~/TeleStream/telestream_v13/
```

o sobre la carpeta donde tengas `app.py`, `static/`, etc.

Conserva siempre:

```text
.env
sessions/
settings.json
.venv/
```

Después reinicia `python app.py`.
