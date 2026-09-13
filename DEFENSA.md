# Defensa técnica — Laboratorio 1

## 1. Estado y ubicación

El estado de asistencia vive exclusivamente en `_AttendanceScreenState`, el `State` de `AttendanceScreen`. La lista privada `_attendance` guarda un `bool` por cada elemento de `initialStudents`; además, `_presentCount` se deriva de esa lista. Las acciones individuales, **Todos presentes** y **Restablecer** cambian ese estado mediante `setState`.

Está allí porque el encabezado, las acciones globales y todas las filas necesitan la misma fuente de verdad. `StudentAttendanceTile` no conserva ni modifica estado propio: recibe el estudiante, el valor actual y un callback por constructor. Si cada fila tuviera su propio estado, el contador y las acciones globales no tendrían una fuente única para actualizar todas las filas de forma consistente; por ejemplo, restablecer el grupo requeriría coordinar estados aislados.

## 2. Reconstrucción de widgets

Al cambiar un registro, `setState` programa una nueva ejecución de `build` de `_AttendanceScreenState`. Por ello se reconstruyen las descripciones de widgets que crea esa pantalla: el encabezado, las acciones y el `ListView.builder`. Flutter reconcilia esas descripciones con los elementos ya montados; las filas activas reciben el valor correspondiente de `_attendance`, por lo que la fila modificada refleja el nuevo `Switch` y el contador muestra el nuevo total. `ListView.builder` crea bajo demanda las filas visibles, en vez de construir las 12 por adelantado si no están en pantalla.

No se afirma que solo se reconstruye la fila: esta implementación no usa un estado independiente por fila ni una optimización adicional para aislarla. Como los datos son pequeños y locales, reconstruir la pantalla declarativa es sencillo y apropiado; Flutter reutiliza los elementos renderizados compatibles durante la reconciliación.

## 3. Extracción de componente

Se extrajo `StudentAttendanceTile`, una clase `StatelessWidget` en `lib/student_attendance_tile.dart`. Su responsabilidad es presentar una fila: nombre, carné, etiqueta de estado y `Switch`. Recibe mediante constructor un `Student`, `isPresent` y `onChanged`; no conoce `_attendance` ni accede al estado privado de `AttendanceScreen`.

Se usó una clase de widget porque esta responsabilidad tiene una interfaz explícita, es reutilizable, testeable y mantiene `AttendanceScreen` centrada en el estado y las acciones del grupo. Un método privado podría producir el mismo aspecto visual, pero no ofrecería un componente con identidad e interfaz propia; la pantalla principal acumularía detalles de presentación y sería menos claro separar qué recibe una fila de cómo se administra el estado global.
