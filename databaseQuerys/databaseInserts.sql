USE ZooMA
GO
DECLARE @CedulaCreador VARCHAR(20) = '504420108';


-- Insertar un registro en la tabla ZOO
EXEC SP_INGRESAR_ZOO 
    @NombreZoo = 'Zoo Maravillas', 
    @Direccion = 'Avenida de los Animales 123', 
    @DescripcionZoo = 'Un zoológico dedicado a la conservación de la fauna', 
    @Cedula = @CedulaCreador;

-- Insertar registros en la tabla Puesto
EXEC SP_INGRESAR_PUESTO @Nombre = 'Veterinario', @Salario = 2000.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Cuidador de Habitaciones', @Salario = 1200.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Secretaria', @Salario = 1100.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Guía de Zoológico', @Salario = 1300.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Encargado de Alimentación', @Salario = 1250.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Veterinario Asistente', @Salario = 1500.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Técnico en Manejo Animal', @Salario = 1400.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Investigador de Fauna', @Salario = 1600.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Coordinador de Actividades', @Salario = 1350.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_PUESTO @Nombre = 'Asistente de Veterinario', @Salario = 1550.00, @Cedula = @CedulaCreador;

-- Insertar registros en la tabla Rol
EXEC SP_INGRESAR_ROL @nombre = 'ADMIN', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ROL @nombre = 'USER', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ROL @nombre = 'SELLER', @Cedula = @CedulaCreador;


-- Ingresar empleados utilizando el procedimiento almacenado SP_REGISTER

-- Registro 1 - ADMIN
EXEC SP_REGISTER 
    @IdEmpleado = '504420108', 
    @Nombre = 'Marco', 
    @Apellido1 = 'Cortes', 
    @Apellido2 = 'Castillo', 
    @Correo = 'marcortes.stiven@gmail.com', 
    @IdPuesto = 1, 
    @Contraseña = 'cortes10', 
    @IdRol = 1, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;

-- Registro 2 - ADMIN
EXEC SP_REGISTER 
    @IdEmpleado = '504420109', 
    @Nombre = 'Laura', 
    @Apellido1 = 'Fernández', 
    @Apellido2 = 'Martínez', 
    @Correo = 'laura.fernandez@gmail.com', 
    @IdPuesto = 2, 
    @Contraseña = 'laura123', 
    @IdRol = 1, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador; 

-- Registro 3 - USER
EXEC SP_REGISTER 
    @IdEmpleado = '504420110', 
    @Nombre = 'Luis', 
    @Apellido1 = 'Pérez', 
    @Apellido2 = 'García', 
    @Correo = 'luis.perez@gmail.com', 
    @IdPuesto = 3,
    @Contraseña = 'luis123', 
    @IdRol = 2, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;  

-- Registro 4 - SELLER
EXEC SP_REGISTER 
    @IdEmpleado = '504420111', 
    @Nombre = 'Ana', 
    @Apellido1 = 'Sánchez', 
    @Apellido2 = 'Moreno', 
    @Correo = 'ana.sanchez@gmail.com', 
    @IdPuesto = 4,
    @Contraseña = 'ana123', 
    @IdRol = 3, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;  

-- Registro 5 - USER
EXEC SP_REGISTER 
    @IdEmpleado = '504420112', 
    @Nombre = 'Carlos', 
    @Apellido1 = 'Ramírez', 
    @Apellido2 = 'Soto', 
    @Correo = 'carlos.ramirez@gmail.com', 
    @IdPuesto = 5, 
    @Contraseña = 'carlos123', 
    @IdRol = 2, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador; 

-- Registro 6 - SELLER
EXEC SP_REGISTER 
    @IdEmpleado = '504420113', 
    @Nombre = 'Sofia', 
    @Apellido1 = 'López', 
    @Apellido2 = 'Jiménez', 
    @Correo = 'sofia.lopez@gmail.com', 
    @IdPuesto = 6, 
    @Contraseña = 'sofia123', 
    @IdRol = 3, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = null, 
    @Cedula = @CedulaCreador; 

-- Registro 7 - ADMIN
EXEC SP_REGISTER 
    @IdEmpleado = '504420114', 
    @Nombre = 'Pedro', 
    @Apellido1 = 'Hernández', 
    @Apellido2 = 'Rivas', 
    @Correo = 'pedro.hernandez@gmail.com', 
    @IdPuesto = 1, 
    @Contraseña = 'pedro123', 
    @IdRol = 1, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;

-- Registro 8 - USER
EXEC SP_REGISTER 
    @IdEmpleado = '504420115', 
    @Nombre = 'Jorge', 
    @Apellido1 = 'González', 
    @Apellido2 = 'López', 
    @Correo = 'jorge.gonzalez@gmail.com', 
    @IdPuesto = 2, 
    @Contraseña = 'jorge123', 
    @IdRol = 2, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador; 

-- Registro 9 - SELLER
EXEC SP_REGISTER 
    @IdEmpleado = '504420116', 
    @Nombre = 'Elena', 
    @Apellido1 = 'Vega', 
    @Apellido2 = 'Mora', 
    @Correo = 'elena.vega@gmail.com', 
    @IdPuesto = 3,
    @Contraseña = 'elena123', 
    @IdRol = 3, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;  

-- Registro 10 - USER
EXEC SP_REGISTER 
    @IdEmpleado = '504420117', 
    @Nombre = 'Natalia', 
    @Apellido1 = 'Salas', 
    @Apellido2 = 'Pérez', 
    @Correo = 'natalia.salas@gmail.com', 
    @IdPuesto = 4, 
    @Contraseña = 'natalia123', 
    @IdRol = 2, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador; 

-- Registro 11 - ADMIN
EXEC SP_REGISTER 
    @IdEmpleado = '504420118', 
    @Nombre = 'Ricardo', 
    @Apellido1 = 'Mendez', 
    @Apellido2 = 'Reyes', 
    @Correo = 'ricardo.mendez@gmail.com', 
    @IdPuesto = 5, 
    @Contraseña = 'ricardo123', 
    @IdRol = 1, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;

-- Registro 12 - SELLER
EXEC SP_REGISTER 
    @IdEmpleado = '504420119', 
    @Nombre = 'Gabriel', 
    @Apellido1 = 'Cáceres', 
    @Apellido2 = 'González', 
    @Correo = 'gabriel.caceres@gmail.com', 
    @IdPuesto = 6, 
    @Contraseña = 'gabriel123', 
    @IdRol = 3, 
    @RolFechaInicio = '2024-01-01', 
    @RolFechaFin = '2024-12-31', 
    @Cedula = @CedulaCreador;  



-- Llamadas para registrar tipos de habitación
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Jaula Terrestre', @Cedula = @CedulaCreador; -- Para mamíferos terrestres
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Acuario', @Cedula = @CedulaCreador; -- Para animales acuáticos
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Terrario', @Cedula = @CedulaCreador; -- Para reptiles y anfibios
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Recinto de Aves', @Cedula = @CedulaCreador; -- Para aves
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Zona de Safari', @Cedula = @CedulaCreador; -- Para grandes herbívoros en un entorno natural
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Establo de Animales de Granja', @Cedula = @CedulaCreador; -- Para animales de granja
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Acuario de Aves', @Cedula = @CedulaCreador; -- Para aves acuáticas
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Recinto de Animales Pequeños', @Cedula = @CedulaCreador; -- Para pequeños mamíferos
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Estación de Rehabilitación', @Cedula = @CedulaCreador; -- Para animales en recuperación
EXEC SP_INGRESAR_TIPOHABITACION @NombreTH = 'Jaula de Caza', @Cedula = @CedulaCreador; -- Para depredadores





EXEC SP_INGRESAR_ESTADOHABITACION 
    @Estado = 'Buena',
    @Cedula = @CedulaCreador;

-- Estado de estructura: Regular
EXEC SP_INGRESAR_ESTADOHABITACION 
    @Estado = 'Regular',
    @Cedula = @CedulaCreador;

-- Estado de estructura: Deteriorada
EXEC SP_INGRESAR_ESTADOHABITACION 
    @Estado = 'Deteriorada',
    @Cedula = @CedulaCreador;



EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Reinos de los Felinos', 
    @Direccion = '100 m al sur de la recepción', 
    @Capacidad = 7, 
    @IdTipoHabitacion = 1, -- Jaula Terrestre
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 1; -- Buena

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Mar de Colores', 
    @Direccion = 'Frente a la entrada del acuario', 
    @Capacidad = 50, 
    @IdTipoHabitacion = 2, -- Acuario
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 2; -- Regular

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Mundo Reptil', 
    @Direccion = '50 m a la izquierda del sendero principal', 
    @Capacidad = 10, 
    @IdTipoHabitacion = 3, -- Terrario
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 1; -- Buena

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Aves del Paraíso', 
    @Direccion = 'Detrás de la tienda de souvenirs', 
    @Capacidad = 20, 
    @IdTipoHabitacion = 4, -- Recinto de Aves
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 3; -- Deteriorada

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Safari Soñado', 
    @Direccion = 'A 200 m del zoológico, en la ruta del safari', 
    @Capacidad = 6, 
    @IdTipoHabitacion = 5, -- Zona de Safari
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 1; -- Buena

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Granja Encantada', 
    @Direccion = 'Cerca del parque infantil, a la derecha', 
    @Capacidad = 8, 
    @IdTipoHabitacion = 6, -- Establo de Animales de Granja
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 2; -- Regular

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Pequeños Exploradores', 
    @Direccion = '100 m al este del área de reptiles', 
    @Capacidad = 10, 
    @IdTipoHabitacion = 8, -- Recinto de Animales Pequeños
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 1; -- Buena

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Refugio de la Esperanza', 
    @Direccion = 'A la izquierda de la entrada principal, junto al estanque', 
    @Capacidad = 5, 
    @IdTipoHabitacion = 9, -- Estación de Rehabilitación
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 3; -- Deteriorada

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Caza del Tigre', 
    @Direccion = 'A 150 m al norte del área de mamíferos grandes', 
    @Capacidad = 2, 
    @IdTipoHabitacion = 10, -- Jaula de Caza
    @Cedula = @CedulaCreador,
    @IdEstadoHabitacion = 2; -- Regular




EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Efectivo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Tarjeta Débito', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Tarjeta Crédito', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Transferencia Bancaria', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Pago Móvil', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'Cheque', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_METODO_PAGO @Metodopago = 'PayPal', @Cedula = @CedulaCreador;



EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420101, 
    @NombreVist = 'Juan', 
    @Apell1Vist = 'Pérez', 
    @Apell2Vist = 'García', 
    @Correo = 'juan.perez@example.com', 
    @TELEFONO = 12345678, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420102, 
    @NombreVist = 'María', 
    @Apell1Vist = 'Gómez', 
    @Apell2Vist = 'López', 
    @Correo = 'maria.gomez@example.com', 
    @TELEFONO = 87654321, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420103, 
    @NombreVist = 'Carlos', 
    @Apell1Vist = 'Rodríguez', 
    @Apell2Vist = 'Martínez', 
    @Correo = 'carlos.rodriguez@example.com', 
    @TELEFONO = 12349876, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420104, 
    @NombreVist = 'Ana', 
    @Apell1Vist = 'Fernández', 
    @Apell2Vist = 'Ruiz', 
    @Correo = 'ana.fernandez@example.com', 
    @TELEFONO = 87651234, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420105, 
    @NombreVist = 'José', 
    @Apell1Vist = 'Sánchez', 
    @Apell2Vist = 'Díaz', 
    @Correo = 'jose.sanchez@example.com', 
    @TELEFONO = 43219876, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420106, 
    @NombreVist = 'Lucía', 
    @Apell1Vist = 'Méndez', 
    @Apell2Vist = 'Rojas', 
    @Correo = 'lucia.mendez@example.com', 
    @TELEFONO = 56781234, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420107, 
    @NombreVist = 'Pedro', 
    @Apell1Vist = 'Torres', 
    @Apell2Vist = 'Jiménez', 
    @Correo = 'pedro.torres@example.com', 
    @TELEFONO = 67891234, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420108, 
    @NombreVist = 'Elena', 
    @Apell1Vist = 'Castillo', 
    @Apell2Vist = 'Morales', 
    @Correo = 'elena.castillo@example.com', 
    @TELEFONO = 78901234, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420109, 
    @NombreVist = 'Raúl', 
    @Apell1Vist = 'Navarro', 
    @Apell2Vist = 'Vargas', 
    @Correo = 'raul.navarro@example.com', 
    @TELEFONO = 89012345, 
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_VISITANTE 
    @IdVisitantes = 504420110, 
    @NombreVist = 'Sofía', 
    @Apell1Vist = 'Mora', 
    @Apell2Vist = 'Pérez', 
    @Correo = 'sofia.mora@example.com', 
    @TELEFONO = 90123456, 
    @Cedula = @CedulaCreador;



-- Llamadas para registrar tipos de entrada
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Adulto', @Precio = 12.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Niño', @Precio = 8.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Estudiante', @Precio = 10.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Tercera Edad', @Precio = 7.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Tarifa Especial', @Precio = 15.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Visita Nocturna', @Precio = 14.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Entrada de Cuidado Animal', @Precio = 20.00, @Cedula = @CedulaCreador;




EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-12-31', @descuento = 10, @IdTipoEntrada = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-11-15', @descuento = 5, @IdTipoEntrada = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-10-30', @descuento = 0, @IdTipoEntrada = 2, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-11-01', @descuento = 15, @IdTipoEntrada = 3, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-12-01', @descuento = 20, @IdTipoEntrada = 4, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-11-20', @descuento = 25, @IdTipoEntrada = 5, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-10-28', @descuento = 10, @IdTipoEntrada = 6, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-11-25', @descuento = 30, @IdTipoEntrada = 7, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-12-05', @descuento = 5, @IdTipoEntrada = 2, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ENTRADA @fechaVencimiento = '2024-11-12', @descuento = 15, @IdTipoEntrada = 3, @Cedula = @CedulaCreador;



DECLARE @Detalles DetalleVentaTableType;



-- Venta 1
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (3, 2);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420101, 
    @IdMetodoPago = 1, -- Efectivo
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 2
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (2, 1);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420102, 
    @IdMetodoPago = 2, -- Tarjeta Débito
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 3
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (3, 3);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420103, 
    @IdMetodoPago = 3, -- Tarjeta Crédito
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 4
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (4, 1);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420104, 
    @IdMetodoPago = 4, -- Transferencia Bancaria
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 5
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (5, 2);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420105, 
    @IdMetodoPago = 5, -- Pago Móvil
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 6
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (6, 1);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420106, 
    @IdMetodoPago = 6, -- Cheque
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 7
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (7, 2);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420107, 
    @IdMetodoPago = 7, -- PayPal
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 8
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (5, 1);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420108, 
    @IdMetodoPago = 1, -- Efectivo
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 9
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (2, 3);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420109, 
    @IdMetodoPago = 2, -- Tarjeta Débito
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;

-- Venta 10
DELETE FROM @Detalles;
INSERT INTO @Detalles (IdEntrada, Cantidad) VALUES (3, 1);
EXEC SP_EJECUTAR_VENTA 
    @IdVisitantes = 504420110, 
    @IdMetodoPago = 3, -- Tarjeta Crédito
    @Cedula = @CedulaCreador, 
    @Detalles = @Detalles;



EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'Saludable', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'Enfermo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'Bajo observación', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'En cuarentena', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'Herido', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud = 'Recuperación', @Cedula = @CedulaCreador;



-- Alimentos específicos para dietas de animales en el zoológico
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Carne de venado', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Carne de cerdo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Carne de conejo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Carne de codorniz', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Larvas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Gusanos de seda', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Saltamontes', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Grillos', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Miel de flores', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Plátanos', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Papayas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Mangos', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Manzanas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Peras', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Sandías', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Melones', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Zanahorias', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Calabazas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Betabel', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Pepinos', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Tomates', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Brotes de alfalfa', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Raíces comestibles', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Heno fresco', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Pasto', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Piensos para aves', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Semillas de girasol', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Semillas de sésamo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Maíz', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Arroz integral', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Avena', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Nueces mixtas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Avellanas', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Almendras', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Alimento para peces', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Huevos de codorniz', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Huevos de gallina', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ALIMENTOS @Nombre = 'Polen', @Cedula = @CedulaCreador;



DECLARE @Alimentos AlimentosDeDietaTableType;

-- Dieta 1: Dieta Carnívora
INSERT INTO @Alimentos (IdAlimentos) VALUES (2), (3), (4), (5); -- Carne de venado, cerdo, conejo, codorniz
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Carnívora', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 2: Dieta Insectívora
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (6), (7), (8); -- Larvas, Gusanos de seda, Saltamontes
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Insectívora', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 3: Dieta Frutal
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (11), (12), (13), (14), (15); -- Plátanos, Papayas, Mangos, Manzanas, Peras
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Frutal', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 4: Dieta Mixta
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (10), (11), (25), (27); -- Miel de flores, Plátanos, Heno fresco, Piensos para aves
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Mixta', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 5: Dieta Herbívora
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (18), (19), (20), (21); -- Zanahorias, Calabazas, Betabel, Pepinos
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Herbívora', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 6: Dieta para Aves
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (28), (29), (30); -- Semillas de girasol, Semillas de sésamo, Maíz
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta para Aves', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 7: Dieta para Peces
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (36), (37); -- Alimento para peces, Huevos de codorniz
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta para Peces', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 8: Dieta de Semillas
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (28), (29), (31), (33); -- Semillas de girasol, Semillas de sésamo, Arroz integral, Nueces mixtas
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta de Semillas', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 9: Dieta de Verduras
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (18), (21), (22), (24); -- Zanahorias, Pepinos, Tomates, Raíces comestibles
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta de Verduras', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;

-- Dieta 10: Dieta Energética
DELETE FROM @Alimentos;
INSERT INTO @Alimentos (IdAlimentos) VALUES (30), (31), (32), (33); -- Maíz, Arroz integral, Avena, Nueces mixtas
EXEC SP_INGRESAR_DIETA 
    @NombreDiet = 'Dieta Energética', 
    @Cedula = @CedulaCreador, 
    @Alimentos = @Alimentos;


-- Llamada para la tarea de atención de salud de los animales
EXEC SP_INGRESAR_TIPO_TAREA 
    @NombreTT = 'Atención de Salud',
    @Cedula = @CedulaCreador;

-- Llamada para la tarea de limpieza de habitaciones de los animales
EXEC SP_INGRESAR_TIPO_TAREA 
    @NombreTT = 'Limpieza de Habitaciones',
    @Cedula = @CedulaCreador;



EXEC SP_INGRESAR_ESTADO_TAREA 
    @Nombre = 'Pendiente',
    @Cedula = @CedulaCreador;

-- Estado de tarea: En Proceso
EXEC SP_INGRESAR_ESTADO_TAREA 
    @Nombre = 'En Proceso',
    @Cedula = @CedulaCreador;

-- Estado de tarea: Completada
EXEC SP_INGRESAR_ESTADO_TAREA 
    @Nombre = 'Completada',
    @Cedula = @CedulaCreador;









-- Llamadas al procedimiento SP_INGRESAR_ESPECIE para agregar especies
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'León', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Tigre', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Elefante', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Jirafa', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Cebra', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Gorila', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Pingüino', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Cocodrilo', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Canguro', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Panda', @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Búfalo', @Cedula = @CedulaCreador;  -- Búfalo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Hiena', @Cedula = @CedulaCreador;  -- Hiena
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Hipopótamo', @Cedula = @CedulaCreador;  -- Hipopótamo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Rinoceronte', @Cedula = @CedulaCreador;  -- Rinoceronte
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Orangután', @Cedula = @CedulaCreador;  -- Orangután
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Tortuga', @Cedula = @CedulaCreador;  -- Tortuga
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Lemur', @Cedula = @CedulaCreador;  -- Lemur
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Babuino', @Cedula = @CedulaCreador;  -- Babuino
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Cangrejo', @Cedula = @CedulaCreador;  -- Cangrejo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Pájaro Loro', @Cedula = @CedulaCreador;  -- Loro
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Puma', @Cedula = @CedulaCreador;  -- Puma
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Zorro', @Cedula = @CedulaCreador;  -- Zorro
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Alce', @Cedula = @CedulaCreador;  -- Alce
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Foca', @Cedula = @CedulaCreador;  -- Foca
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Nutria', @Cedula = @CedulaCreador;  -- Nutria
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Koala', @Cedula = @CedulaCreador;  -- Koala
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Lince', @Cedula = @CedulaCreador;  -- Lince
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Zarigüeya', @Cedula = @CedulaCreador;  -- Zarigüeya
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Pájaro Carpintero', @Cedula = @CedulaCreador;  -- Carpintero
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Serpiente', @Cedula = @CedulaCreador;  -- Serpiente
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Chimpancé', @Cedula = @CedulaCreador;  -- Chimpancé
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Rana', @Cedula = @CedulaCreador;  -- Rana
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Gato montés', @Cedula = @CedulaCreador;  -- Gato montés
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Oso Panda Rojo', @Cedula = @CedulaCreador;  -- Panda Rojo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Cisne', @Cedula = @CedulaCreador;  -- Cisne
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Halcon', @Cedula = @CedulaCreador;  -- Halcón
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Gallo', @Cedula = @CedulaCreador;  -- Gallo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Pececito', @Cedula = @CedulaCreador;  -- Pez
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Serpiente de cascabel', @Cedula = @CedulaCreador;  -- Serpiente de cascabel
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Escamoso', @Cedula = @CedulaCreador;  -- Escamoso
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Gato salvaje', @Cedula = @CedulaCreador;  -- Gato salvaje
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Lobo', @Cedula = @CedulaCreador;  -- Lobo
EXEC SP_INGRESAR_ESPECIE @NombreEsp = 'Gato doméstico', @Cedula = @CedulaCreador;  -- Gato doméstico





EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Simba', @EdadAni = 5, @IdDieta = 1, @IdHabitacion = 1, @IdEspecie = 1, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Tigger', @EdadAni = 3, @IdDieta = 1, @IdHabitacion = 2, @IdEspecie = 2, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Dumbo', @EdadAni = 10, @IdDieta = 5, @IdHabitacion = 3, @IdEspecie = 3, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Gigi', @EdadAni = 4, @IdDieta = 3, @IdHabitacion = 4, @IdEspecie = 4, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Leo', @EdadAni = 2, @IdDieta = 4, @IdHabitacion = 5, @IdEspecie = 5, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Nemo', @EdadAni = 1, @IdDieta = 7, @IdHabitacion = 2, @IdEspecie = 6, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Winnie', @EdadAni = 6, @IdDieta = 8, @IdHabitacion = 3, @IdEspecie = 7, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Bambi', @EdadAni = 4, @IdDieta = 9, @IdHabitacion = 4, @IdEspecie = 8, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Kiki', @EdadAni = 5, @IdDieta = 6, @IdHabitacion = 1, @IdEspecie = 9, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Milo', @EdadAni = 3, @IdDieta = 10, @IdHabitacion = 2, @IdEspecie = 10, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Lola', @EdadAni = 2, @IdDieta = 5, @IdHabitacion = 3, @IdEspecie = 11, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Coco', @EdadAni = 1, @IdDieta = 4, @IdHabitacion = 4, @IdEspecie = 12, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Paco', @EdadAni = 7, @IdDieta = 3, @IdHabitacion = 1, @IdEspecie = 13, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Tina', @EdadAni = 8, @IdDieta = 2, @IdHabitacion = 2, @IdEspecie = 14, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Roxy', @EdadAni = 4, @IdDieta = 6, @IdHabitacion = 3, @IdEspecie = 15, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Nina', @EdadAni = 5, @IdDieta = 1, @IdHabitacion = 4, @IdEspecie = 16, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Bobby', @EdadAni = 2, @IdDieta = 9, @IdHabitacion = 1, @IdEspecie = 17, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Simba', @EdadAni = 5, @IdDieta = 1, @IdHabitacion = 1, @IdEspecie = 1, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Tigger', @EdadAni = 3, @IdDieta = 1, @IdHabitacion = 2, @IdEspecie = 2, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Dumbo', @EdadAni = 10, @IdDieta = 5, @IdHabitacion = 3, @IdEspecie = 3, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Gigi', @EdadAni = 4, @IdDieta = 3, @IdHabitacion = 4, @IdEspecie = 4, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Leo', @EdadAni = 2, @IdDieta = 4, @IdHabitacion = 5, @IdEspecie = 5, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Nemo', @EdadAni = 1, @IdDieta = 7, @IdHabitacion = 2, @IdEspecie = 6, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Winnie', @EdadAni = 6, @IdDieta = 8, @IdHabitacion = 3, @IdEspecie = 7, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Bambi', @EdadAni = 4, @IdDieta = 9, @IdHabitacion = 4, @IdEspecie = 8, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Kiki', @EdadAni = 5, @IdDieta = 6, @IdHabitacion = 1, @IdEspecie = 9, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Milo', @EdadAni = 3, @IdDieta = 10, @IdHabitacion = 2, @IdEspecie = 10, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Lola', @EdadAni = 2, @IdDieta = 5, @IdHabitacion = 3, @IdEspecie = 11, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Coco', @EdadAni = 1, @IdDieta = 4, @IdHabitacion = 4, @IdEspecie = 12, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Paco', @EdadAni = 7, @IdDieta = 3, @IdHabitacion = 1, @IdEspecie = 13, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Tina', @EdadAni = 8, @IdDieta = 2, @IdHabitacion = 2, @IdEspecie = 14, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Roxy', @EdadAni = 4, @IdDieta = 6, @IdHabitacion = 3, @IdEspecie = 15, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Nina', @EdadAni = 5, @IdDieta = 1, @IdHabitacion = 4, @IdEspecie = 16, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Bobby', @EdadAni = 2, @IdDieta = 9, @IdHabitacion = 1, @IdEspecie = 17, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Daisy', @EdadAni = 3, @IdDieta = 8, @IdHabitacion = 2, @IdEspecie = 18, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Fluffy', @EdadAni = 6, @IdDieta = 4, @IdHabitacion = 3, @IdEspecie = 19, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Rocky', @EdadAni = 5, @IdDieta = 5, @IdHabitacion = 4, @IdEspecie = 20, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Chester', @EdadAni = 7, @IdDieta = 1, @IdHabitacion = 1, @IdEspecie = 21, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Bella', @EdadAni = 2, @IdDieta = 2, @IdHabitacion = 2, @IdEspecie = 22, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Piper', @EdadAni = 4, @IdDieta = 3, @IdHabitacion = 3, @IdEspecie = 23, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Ziggy', @EdadAni = 1, @IdDieta = 4, @IdHabitacion = 4, @IdEspecie = 24, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Maverick', @EdadAni = 8, @IdDieta = 5, @IdHabitacion = 5, @IdEspecie = 25, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Oreo', @EdadAni = 6, @IdDieta = 6, @IdHabitacion = 1, @IdEspecie = 26, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Cleo', @EdadAni = 3, @IdDieta = 7, @IdHabitacion = 2, @IdEspecie = 27, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Shadow', @EdadAni = 4, @IdDieta = 8, @IdHabitacion = 3, @IdEspecie = 28, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Duke', @EdadAni = 5, @IdDieta = 9, @IdHabitacion = 4, @IdEspecie = 29, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Lucy', @EdadAni = 7, @IdDieta = 10, @IdHabitacion = 5, @IdEspecie = 30, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Oscar', @EdadAni = 2, @IdDieta = 6, @IdHabitacion = 1, @IdEspecie = 31, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Peanut', @EdadAni = 4, @IdDieta = 7, @IdHabitacion = 2, @IdEspecie = 32, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Chloe', @EdadAni = 3, @IdDieta = 8, @IdHabitacion = 3, @IdEspecie = 33, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Finn', @EdadAni = 1, @IdDieta = 9, @IdHabitacion = 4, @IdEspecie = 34, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Misty', @EdadAni = 8, @IdDieta = 10, @IdHabitacion = 5, @IdEspecie = 35, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Toby', @EdadAni = 5, @IdDieta = 1, @IdHabitacion = 1, @IdEspecie = 36, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Sasha', @EdadAni = 2, @IdDieta = 2, @IdHabitacion = 2, @IdEspecie = 37, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Rusty', @EdadAni = 4, @IdDieta = 3, @IdHabitacion = 3, @IdEspecie = 38, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Ellie', @EdadAni = 6, @IdDieta = 4, @IdHabitacion = 4, @IdEspecie = 39, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Tina', @EdadAni = 5, @IdDieta = 5, @IdHabitacion = 5, @IdEspecie = 40, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Sandy', @EdadAni = 3, @IdDieta = 6, @IdHabitacion = 1, @IdEspecie = 41, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Smokey', @EdadAni = 4, @IdDieta = 7, @IdHabitacion = 2, @IdEspecie = 42, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Zara', @EdadAni = 6, @IdDieta = 8, @IdHabitacion = 3, @IdEspecie = 43, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Cody', @EdadAni = 2, @IdDieta = 9, @IdHabitacion = 4, @IdEspecie = 44, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Luna', @EdadAni = 3, @IdDieta = 10, @IdHabitacion = 5, @IdEspecie = 45, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Jasper', @EdadAni = 1, @IdDieta = 1, @IdHabitacion = 1, @IdEspecie = 46, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Nala', @EdadAni = 8, @IdDieta = 2, @IdHabitacion = 2, @IdEspecie = 47, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Teddy', @EdadAni = 7, @IdDieta = 3, @IdHabitacion = 3, @IdEspecie = 48, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Chester', @EdadAni = 4, @IdDieta = 4, @IdHabitacion = 4, @IdEspecie = 49, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_ANIMAL @NombreAni = 'Flora', @EdadAni = 5, @IdDieta = 5, @IdHabitacion = 5, @IdEspecie = 50, @IdEstadoSalud = 1, @Cedula = @CedulaCreador;


