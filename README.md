# 🌐 Aplicación Web de Apoyo para PYMES

## 📝 Descripción

Este proyecto es una aplicación web diseñada como apoyo para pequeñas y medianas empresas (PYMES) afectadas durante la pandemia del COVID-19. Su objetivo principal es ofrecer herramientas para la gestión económica mediante la implementación de operaciones **CRUD**, reportes parametrizados y una conexión con una base de datos en la nube.

La aplicación fue desarrollada utilizando:
- **Java** para la lógica del backend.
- **Apache Tomcat** como servidor web.
- **Oracle Database** para la gestión de datos en la nube.

---

## 📋 Características principales

- **Pantalla de autenticación**:
  - Validación de usuario y contraseña almacenados en la base de datos.
- **Operaciones CRUD**:
  - Gestión completa sobre una entidad fuerte y una tabla transaccional.
- **Reportes parametrizados**:
  - Reporte 1: Cantidad de artículos vendidos por mes/cliente utilizando **INNER JOINs**.
  - Reporte 2: Montos vendidos con combinación de **INNER JOIN** y **OUTER JOIN**.
- **Trigger de auditoría**:
  - Implementación de bitácora para rastrear cambios realizados en columnas clave.
- **Arquitectura en capas**:
  - Separación en al menos 3 capas (presentación, lógica de negocio y acceso a datos).
- **Procedimientos y funciones**:
  - Uso de paquetes para consultas y modificaciones con manejo de excepciones.

---

## 🚀 Instalación y Configuración

### Requisitos previos
- **Apache Tomcat** instalado y configurado.
- **Java Development Kit (JDK)**.
- **Oracle Database** con conexión activa.

### Pasos para instalar
1. Clona este repositorio:
   ```bash
   git clone https://github.com/Nash232305/Farmacia.git
   ```
2. Configura Apache Tomcat para desplegar la aplicación:
   - Copia el archivo `.war` generado en el directorio de despliegue de Tomcat.
3. Conecta la aplicación con la base de datos:
   - Configura el archivo `persistence.xml` con tus credenciales y URL de conexión a Oracle Database.
4. Inicia Apache Tomcat y accede a la aplicación desde tu navegador.

## 📂 Estructura del Proyecto
- `proyecto/`: Contiene el código fuente de la aplicación.
- `CRUDS/`: Scripts SQL para operaciones CRUD en la base de datos.
- `db_wallets.rar`: Copia de seguridad de la base de datos para pruebas locales y la wallet de la base de datos en ORACLE.
- `README.md`: Este archivo.

## 📊 Modelo de Datos
Diagrama Entidad-Relación (3FN) con al menos 4 entidades fuertes.

### Tablas incluidas:
- **Entidad fuerte**: Gestión principal.
- **Tabla transaccional**: Registro de operaciones y auditoría.

## 🌟 Funcionalidades clave
- **Gestión de usuarios**:
  - Inicio de sesión seguro con validación contra la base de datos.
- **Auditoría**:
  - Registro de cambios realizados en columnas clave mediante triggers.
- **Reportes empresariales**:
  - Información relevante como ventas mensuales o por cliente.

## 💡 Mejoras futuras
- Integrar gráficos dinámicos para los reportes utilizando librerías como Chart.js.
- Optimizar la interfaz de usuario para dispositivos móviles.
- Implementar autenticación basada en tokens para mayor seguridad.

## 🧑‍💻 Créditos
Este proyecto fue desarrollado como parte del curso Base de Datos I en el Instituto Tecnológico de Costa Rica. 
Supervisado por el Prof. Alberto Shum Chan.

---

¡Gracias por visitar este repositorio! Si tienes sugerencias o encuentras errores, no dudes en abrir un issue o contactarme.
