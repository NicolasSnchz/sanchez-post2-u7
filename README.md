# GeoSense - Ubicación, Mapas y Sensores

Aplicación Flutter desarrollada para la Unidad 7 de Aplicaciones Móviles.

La app integra permisos de ubicación, lectura de ubicación actual, visualización de mapa con google_maps_flutter, lectura del acelerómetro con sensors_plus y geofencing visual básico.

## Funcionalidades implementadas

- Solicitud de permiso de ubicación en tiempo de ejecución.
- Obtención de ubicación actual del dispositivo.
- Visualización de contenedor de mapa con Google Maps.
- Marcador de posición actual.
- Círculo de geofencing de 200 metros.
- Lectura del acelerómetro en tiempo real.
- Detección básica de movimiento/agitación.
- Manejo de streams y cancelación en dispose().

## Paquetes utilizados

- geolocator
- permission_handler
- google_maps_flutter
- sensors_plus

## Estructura del proyecto

lib/
- main.dart
- location_service.dart
- map_view.dart
- accelerometer_widget.dart

## Evidencias

Las capturas se encuentran en la carpeta evidencias/.

- 01_permiso_ubicacion.png
- 02_mapa_sin_api_y_acelerometro.png
- 03_sensor_acelerometro.png

## Configuración de Google Maps API Key

Para que el mapa muestre calles reales, se debe crear una API Key en Google Cloud Platform y habilitar Maps SDK for Android.

Luego se debe pegar la clave en:

android/app/src/main/AndroidManifest.xml

Durante la prueba local se omitió la activación completa de Google Cloud porque Google solicita verificación de forma de pago. Por esa razón, el mapa puede verse en color beige, aunque la app ejecuta correctamente permisos, mapa base y sensores.

## Ejecución

flutter pub get
flutter run

## Análisis del proyecto

flutter analyze

## Estado del proyecto

El proyecto compila y ejecuta correctamente en emulador Android.

La funcionalidad de ubicación, permisos y acelerómetro está implementada. El mapa requiere una API Key real de Google Maps para mostrar calles y datos completos.
