# Caso de Estudio: Zoológico "Mundo Animal"

## Descripción de la Organización

"Mundo Animal S.A." es un zoológico ubicado en una gran ciudad, dedicado a la conservación de la fauna y la educación ambiental. El zoológico alberga una variedad de especies animales, desde mamíferos hasta aves y reptiles, y ofrece actividades educativas, visitas guiadas y programas de conservación. El objetivo principal del zoológico es proporcionar un ambiente seguro y enriquecedor para los animales, al mismo tiempo que educa al público sobre la vida salvaje y la conservación.

## Situación Actual

Actualmente, "Mundo Animal S.A." gestiona sus operaciones utilizando sistemas dispersos para el seguimiento de animales, gestión de entradas y ventas, y mantenimiento de instalaciones. Esta metodología presenta varios desafíos:

- **Registro Manual de Animales y Sus Habitaciones:** La información sobre los animales, incluyendo su salud, dieta y movimientos, se maneja manualmente, lo que puede llevar a errores y dificultades para acceder a datos históricos.
- **Gestión Ineficiente de Entradas y Ventas:** El sistema actual para la venta de entradas y el seguimiento de visitantes es básico, lo que limita la capacidad para analizar las tendencias de visitantes y las ventas.
- **Falta de Información para la Toma de Decisiones:** La ausencia de un sistema integrado dificulta el análisis de datos sobre el desempeño del zoológico, la ocupación de espacios y la satisfacción del visitante.
- **Dificultades en la Planificación de Mantenimiento y Recursos:** La falta de datos precisos hace difícil planificar el mantenimiento de instalaciones y la asignación de personal para el cuidado de los animales.

El Comité Ejecutivo de "Mundo Animal S.A." ha decidido implementar una solución integral para mejorar la gestión del zoológico y requiere de la colaboración de profesionales en la rama de la informática.

## Objetivos Principales

1. **Registrar y Gestionar Información de Animales:** Desarrollar una aplicación para registrar y gestionar toda la información relacionada con los animales, incluyendo su salud, dieta, movimientos y estado de las instalaciones.
2. **Optimizar la Gestión de Entradas y Ventas:** Implementar un sistema para controlar la venta de entradas, el seguimiento de visitantes y la generación de reportes sobre el flujo de visitantes y las ventas.
3. **Analizar el Desempeño del Zoológico:** Crear un sistema que genere reportes sobre el desempeño del zoológico, incluyendo la ocupación de espacios, la satisfacción del visitante y la eficiencia en el cuidado de los animales.
4. **Facilitar la Planificación de Mantenimiento y Recursos:** Utilizar datos para planificar de manera efectiva el mantenimiento de instalaciones y la asignación de personal para el cuidado de los animales.
5. **Integración con un Data Warehouse:** Conectar la base de datos con un Data Warehouse para realizar análisis avanzados y generar reportes detallados sobre el funcionamiento del zoológico.

## Beneficios Esperados

- **Mejora en la Gestión de Animales:** Un sistema integrado permitirá un manejo más eficiente de la información sobre los animales, mejorando el cuidado y la salud de los mismos.
- **Optimización de Ventas y Entradas:** Un mejor control del sistema de entradas y ventas permitirá aumentar la eficiencia y proporcionar datos valiosos para estrategias de marketing.
- **Datos Precisos para la Toma de Decisiones:** Acceso a información detallada permitirá tomar decisiones más informadas sobre el manejo del zoológico y las operaciones diarias.
- **Planificación Efectiva de Mantenimiento:** La planificación basada en datos ayudará a mejorar la eficiencia en el mantenimiento de instalaciones y la asignación de personal.

## Enfoque del Proyecto

El proyecto se dividirá en dos componentes principales:

1. **Desarrollo de la Aplicación:** Para gestionar la información de los animales, entradas y ventas, y para generar reportes estadísticos.
2. **Desarrollo de la Base de Datos:** Para almacenar la información de manera segura y eficiente, con integración al Data Warehouse para análisis avanzado.

## Requisitos del Proyecto

### Requisitos Funcionales

- **R1: Gestión de Animales**

  - **Descripción:** Registro y actualización de la información de los animales.
  - **Datos Requeridos:** ID del animal, especie, edad, historial médico, dieta, movimientos, ubicación en el zoológico.
  - **Objetivo:** Facilitar el seguimiento de la salud y el bienestar de los animales, así como la gestión de sus espacios.

- **R2: Gestión de Entradas y Ventas**

  - **Descripción:** Control de la venta de entradas y seguimiento de los visitantes.
  - **Datos Requeridos:** ID de la venta, fecha y hora, tipo de entrada (adulto, niño, grupo), número de visitantes, ingresos generados.
  - **Objetivo:** Mejorar la eficiencia en la venta de entradas y proporcionar datos para el análisis del flujo de visitantes.

- **R3: Análisis del Desempeño del Zoológico**

  - **Descripción:** Generación de reportes sobre el desempeño del zoológico.
  - **Datos Requeridos:** Ocupación de espacios, satisfacción del visitante, eficiencia en el cuidado de los animales, ingresos generados.
  - **Objetivo:** Evaluar el rendimiento del zoológico y la calidad de las operaciones.

- **R4: Planificación de Mantenimiento y Recursos**

  - **Descripción:** Utilización de datos para planificar el mantenimiento de instalaciones y la asignación de personal.
  - **Datos Requeridos:** Historial de mantenimiento, programación de tareas, disponibilidad de personal, estado de las instalaciones.
  - **Objetivo:** Mejorar la planificación del mantenimiento y la eficiencia en la asignación de recursos.

- **R5: Integración con un Data Warehouse**

  - **Descripción:** La base de datos debe permitir la transferencia de datos a un Data Warehouse para análisis avanzado.
  - **Mecanismo:** Usar herramientas de transferencia de datos como ETL (Extract, Transform, Load).
  - **Objetivo:** Facilitar el análisis de datos y la generación de reportes detallados sobre el funcionamiento del zoológico.

- **R6: Gestión del Registro de Acciones**

  - **Descripción:** Registro de las acciones realizadas por los usuarios en el sistema.
  - **Objetivo:** Permitir auditorías y seguimiento de cambios en el sistema.

- **R7: Mecanismos para el Testeo de la Base de Datos**

  - **Descripción:** Implementar pruebas para asegurar que la base de datos funcione correctamente.
  - **Objetivo:** Verificar que la base de datos cumpla con los requisitos y funcione adecuadamente.

- **R8: Plan de Mantenimiento de Bases de Datos**
  - **Descripción:** Establecer procedimientos para el mantenimiento y actualización de la base de datos.
  - **Objetivo:** Garantizar la continuidad operativa y la integridad de los datos.

## Historial y Reportes Estadísticos de Interés

La Dirección General de "Mundo Animal S.A." desea mantener un historial completo de la información para generar reportes que faciliten la toma de decisiones. Entre los reportes y consultas de interés se incluyen:

- **Ocupación de Espacios y Estado de las Instalaciones:** Identificar la ocupación de espacios y el estado de las instalaciones para planificar el mantenimiento y las mejoras.
- **Número de Visitantes y Ventas de Entradas:** Analizar el número de visitantes y las ventas de entradas para ajustar las estrategias de marketing y promoción.
- **Estado de Salud de los Animales:** Revisar el historial médico y el estado de salud de los animales para mejorar el cuidado y la gestión de recursos.
- **Satisfacción del Visitante:** Medir la satisfacción del visitante para identificar áreas de mejora en la experiencia del zoológico.
- **Tendencias en la Demanda de Servicios:** Analizar las tendencias en la demanda de servicios y actividades del zoológico para optimizar la planificación y los recursos.
- **Y otras consultas relacionadas con la gestión del zoológico:** Generar otros reportes específicos según las necesidades y objetivos del zoológico.
