USE ZooMA
GO
DECLARE @CedulaCreador VARCHAR(20) = '504420108';

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

-- Insertar un registro en la tabla ZOO
EXEC SP_INGRESAR_ZOO 
    @NombreZoo = 'Zoo Maravillas', 
    @Direccion = 'Avenida de los Animales 123', 
    @DescripcionZoo = 'Un zoológico dedicado a la conservación de la fauna', 
    @Cedula = @CedulaCreador;

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




-- Llamadas para registrar habitaciones con nombres creativos y direcciones comprensibles
EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Reinos de los Felinos', 
    @Direccion = '100 m al sur de la recepción', 
    @Capacidad = 2, 
    @IdTipoHabitacion = 1, -- Jaula Terrestre
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Mar de Colores', 
    @Direccion = 'Frente a la entrada del acuario', 
    @Capacidad = 50, 
    @IdTipoHabitacion = 2, -- Acuario
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Mundo Reptil', 
    @Direccion = '50 m a la izquierda del sendero principal', 
    @Capacidad = 5, 
    @IdTipoHabitacion = 3, -- Terrario
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Aves del Paraíso', 
    @Direccion = 'Detrás de la tienda de souvenirs', 
    @Capacidad = 20, 
    @IdTipoHabitacion = 4, -- Recinto de Aves
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Safari Soñado', 
    @Direccion = 'A 200 m del zoológico, en la ruta del safari', 
    @Capacidad = 3, 
    @IdTipoHabitacion = 5, -- Zona de Safari
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Granja Encantada', 
    @Direccion = 'Cerca del parque infantil, a la derecha', 
    @Capacidad = 4, 
    @IdTipoHabitacion = 6, -- Establo de Animales de Granja
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Pequeños Exploradores', 
    @Direccion = '100 m al este del área de reptiles', 
    @Capacidad = 10, 
    @IdTipoHabitacion = 8, -- Recinto de Animales Pequeños
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Refugio de la Esperanza', 
    @Direccion = 'A la izquierda de la entrada principal, junto al estanque', 
    @Capacidad = 5, 
    @IdTipoHabitacion = 9, -- Estación de Rehabilitación
    @Cedula = @CedulaCreador;

EXEC SP_INGRESAR_HABITACION 
    @NombreHab = 'Caza del Tigre', 
    @Direccion = 'A 150 m al norte del área de mamíferos grandes', 
    @Capacidad = 2, 
    @IdTipoHabitacion = 10, -- Jaula de Caza
    @Cedula = @CedulaCreador;



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



    -- Declaración de la cédula creador
DECLARE @CedulaCreador VARCHAR(20) = '504420108';

-- Llamadas para registrar tipos de entrada
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Adulto', @Precio = 15.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Niño', @Precio = 10.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Estudiante', @Precio = 12.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Tercera Edad', @Precio = 8.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Tarifa Especial', @Precio = 20.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Visita Nocturna', @Precio = 18.00, @Cedula = @CedulaCreador;
EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt = 'Entrada de Cuidado Animal', @Precio = 25.00, @Cedula = @CedulaCreador;




