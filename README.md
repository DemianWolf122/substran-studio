# Substran Studio

Traductor de subtítulos + reproductor de video, todo en un único archivo HTML.
Pensado para anime y series: cargás un `.mkv` (o cualquier video), extrae los
subtítulos embebidos automáticamente, los traduce con Claude, los renderiza
sobre el video en vivo, y los descargás como `.srt`.

![Substran Studio](./screenshot.png)

## Features

- 🎬 **Reproductor de video estilo Substran** — controles custom (sin chrome
  nativo de HTML5), modo cine, fullscreen, auto-hide chrome, atajos de
  teclado completos.
- 📦 **Extracción de subs embebidos de MKV** — pure JS, parsea EBML/Matroska
  y exporta tracks de subtítulos embebidos (S_TEXT/UTF8 y S_TEXT/ASS) como
  SRT automáticamente. Sin servidor, sin ffmpeg.
- 🚀 **Traducción con Claude Opus 4.7** — copy-paste workflow contra
  [Claude.ai](https://claude.ai). 1 sola llamada al LLM por episodio entero
  (compatible con cuota Max sin gastar API).
- 📚 **Glosario per-show persistente** — los nombres propios y términos
  inventados (Returners, Starvation, Senpai, etc.) se guardan en
  `localStorage` y se reutilizan entre episodios para mantener
  consistencia.
- 🎨 **Estilo de subtítulos configurable** — tamaño, color, opacidad de
  fondo, posición vertical, sincronización (offset ±5s).
- ✏️ **Editor inline de cues** — click una cue para saltar el video ahí,
  doble click para editarla.
- 🌍 **10+ idiomas** — Inglés, japonés, coreano, chino, francés, alemán,
  portugués, italiano + 4 variantes de español (neutro LatAm,
  rioplatense voseo, mexicano, peninsular España).
- 🎭 **8 presets de tono** — neutro, anime fansub, formal, casual,
  literario, técnico, humor sarcástico, drama serio.
- 🔒 **100% local** — sin servidores, sin tracking, sin telemetría. Tu
  video nunca sale de tu PC. Sólo el texto de los subtítulos viaja a
  Claude.ai durante la traducción.

## Cómo usar (más rápido posible)

1. Bajá `Substran-Studio.html` de las
   [releases](https://github.com/DemianWolf122/substran-studio/releases) o
   directo desde este repo.
2. **Doble click** → se abre en tu browser default (Chrome / Edge / Firefox).
3. **Arrastrá** un `.mkv` (o `.mp4`, `.webm`) a la ventana. Si el video
   tiene subs embebidos, Substran los extrae automático y los carga.
4. Click **🚀 Traducir** → te abre un modal con un prompt grande copiado a
   tu portapapeles + un campo para pegar la respuesta de Claude.
5. Click **🔗 Abrir Claude.ai** → pegás (`Ctrl+V`) → Claude responde con un
   JSON con todas las traducciones.
6. Copiás la respuesta de Claude → la pegás en el campo del modal de
   Substran → click **✅ Aplicar traducción**.
7. Los subtítulos traducidos aparecen sobre el video al instante.
8. **💾 Descargar .srt** cuando termines.

## Atajos de teclado

| Tecla | Acción |
|-------|--------|
| `Space` / `K` | Play/pause |
| `←` / `→` | Seek ±10s |
| `↑` / `↓` | Volumen ±5% |
| `M` | Mute |
| `F` | Pantalla completa |
| `C` | Modo cine (oculta sidebar) |
| `S` | Ciclar subs (Traducido → Original → Bilingüe → Off) |
| `0-9` | Seek a 0%, 10%, ..., 90% del video |

## Pinear a la barra de tareas (Windows)

Para que se vea como una app nativa con ícono morado:

1. **Edge** → cargar `Substran-Studio.html`
2. Menú (3 puntos) → Aplicaciones → **"Instalar este sitio como una aplicación"**
3. ✅ Anclar a la barra de tareas
4. Si la opción está grisada (Edge bloquea instalación de archivos `file://`),
   usar el `Substran-Studio-Server.bat` incluido que sirve el HTML como
   `http://localhost:8765`. Esto desbloquea la opción Install.

## Limitaciones

- **MKV con subs en formato imagen (PGS, VobSub)** no se extraen. Sólo
  S_TEXT/UTF8 (SRT) y S_TEXT/ASS son soportados.
- **Archivos enormes (>2GB)** pueden agotar memoria del browser durante la
  extracción. Para MKV de hasta ~1.5GB funciona bien en Chrome moderno.
- **Codec del MKV** — el reproductor depende de qué codecs soporte tu
  browser. H.264 + AAC funciona en todos. HEVC (H.265) sólo en algunos.
  AV1 es soportado por Chrome/Edge modernos.
- **Para usar Claude desde el navegador necesitás tener Claude.ai abierto
  en otra pestaña**. La traducción es manual copy-paste — el HTML no
  contiene API keys ni hace requests a Anthropic directamente.

## Stack técnico

- **HTML5 + vanilla JS** (sin frameworks, sin build step)
- **Pure JS EBML/Matroska parser** para extracción de subs MKV
- **`<video>` HTML5** con overlay custom para subtítulos
- **`URL.createObjectURL`** para cargar archivos locales sin upload
- **`localStorage`** para persistencia de glosario y preferencias

## Licencia

MIT. Ver [LICENSE](./LICENSE).

## Autor

[Demian Wolf](https://github.com/DemianWolf122) — armado en colaboración con
Claude (Anthropic).
