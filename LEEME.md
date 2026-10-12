# Mi Despensa — versión preparada

Aplicación web progresiva (PWA) en español para el inventario y la lista de compra. Incluye modo local, caducidades, categorías, exportación JSON, búsqueda de códigos de barras con Open Food Facts y conexión opcional a Supabase.

## Importante antes de usarla en familia

Esta carpeta es el proyecto preparado, no una web publicada. El modo local guarda los datos solo en el navegador actual. Para compartir inventario entre varios móviles hay que completar los pasos de configuración de abajo. La vía más sencilla de esta versión es crear **una única cuenta familiar de Supabase y usar ese mismo inicio de sesión en los móviles de casa**. No compartas esa cuenta fuera de la familia; quien tenga acceso a ella podrá ver y modificar los datos.

## Paso 1 — Crear la base de datos gratuita

1. Entra en https://supabase.com y crea una cuenta/proyecto con el plan gratuito.
2. Abre el proyecto y entra en **SQL Editor**.
3. Crea una consulta nueva, copia todo el contenido de `supabase/schema.sql`, ejecútalo y comprueba que termina sin errores.
4. Ve a **Project Settings → API** (o la sección equivalente de API Keys) y copia la Project URL y la clave pública `anon`/publishable.
5. Duplica `config.example.js` y llama a la copia `config.js`. Dentro, sustituye `https://TU-PROYECTO.supabase.co` y `TU_CLAVE_PUBLICA_ANON` por tus valores reales. No uses nunca la clave `service_role`.

La URL y la clave pública están diseñadas para usarse en el navegador; la seguridad de los datos depende de las políticas RLS incluidas en el SQL. No desactives RLS ni habilites políticas de acceso anónimo.

## Paso 2 — Publicar gratis

La opción guiada es GitHub Pages:

1. En https://github.com crea una cuenta o inicia sesión y crea un repositorio nuevo, por ejemplo `mi-despensa`.
2. Sube el contenido de esta carpeta al repositorio. **Incluye `config.js`** solo si el repositorio es privado. Si el repositorio es público, la URL y clave `anon` son públicas por diseño, pero por prudencia no publiques la configuración de tu proyecto sin entenderlo. Si prefieres, crea el repositorio privado o usa un alojamiento con variables de configuración; el archivo `config.js` no contiene claves administrativas.
3. En el repositorio abre **Settings → Pages**, selecciona **Deploy from a branch**, la rama `main` y la carpeta `/ (root)`, y guarda.
4. GitHub te mostrará una dirección HTTPS. Ábrela en los móviles de la familia.
5. En cada móvil inicia sesión con la cuenta familiar. En iPhone usa Safari → Compartir → Añadir a pantalla de inicio; en Android usa el menú del navegador → Instalar/Añadir a pantalla de inicio.

GitHub Pages y Supabase ofrecen niveles gratuitos sujetos a sus límites y condiciones vigentes. No puedo publicar por ti en tus cuentas ni generar la URL final hasta que exista el repositorio y el proyecto Supabase.

## Paso 3 — Crear la cuenta familiar

1. Abre la web publicada.
2. En “Crear cuenta familiar”, registra un correo que controle la familia y una contraseña robusta.
3. Si Supabase pide confirmar el correo, abre el correo de confirmación.
4. Inicia sesión y usa esas mismas credenciales en los demás móviles.

En Supabase Authentication, configura las URL de redirección permitidas para incluir la URL HTTPS que te asigne el alojamiento. Para que el registro sea más sencillo, revisa la configuración de confirmación de correo; por seguridad, es recomendable mantenerla activada.

## Uso

- Añadir alimentos, cantidades, categorías y fechas de caducidad.
- Buscar y filtrar el inventario.
- Añadir productos a la lista y marcarlos como comprados para copiarlos al inventario.
- Buscar un código manualmente o escanearlo cuando el navegador soporte `BarcodeDetector`.
- Exportar una copia de seguridad JSON.

## Limitaciones conocidas

- La sincronización solo funciona después de configurar Supabase, iniciar sesión y publicar la web.
- Esta edición utiliza una cuenta familiar compartida; no incluye invitaciones ni cuentas separadas por miembro.
- La lectura de cámara depende del navegador, permiso de cámara y HTTPS. Si no está disponible, escribe el código manualmente.
- Open Food Facts puede no tener todos los productos o tener datos incompletos.
- El modo local y el modo cloud son almacenamientos separados; no migres datos importantes sin exportarlos y revisarlos.
