using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Entities;
namespace Services;

public partial class ZooMaContext : DbContext
{
    public ZooMaContext()
    {
    }

    public ZooMaContext(DbContextOptions<ZooMaContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Alimento> Alimentos { get; set; }

    public virtual DbSet<Animale> Animales { get; set; }

    public virtual DbSet<AuditAlimento> AuditAlimentos { get; set; }

    public virtual DbSet<AuditAnimale> AuditAnimales { get; set; }

    public virtual DbSet<AuditCalificacionRecorrido> AuditCalificacionRecorridos { get; set; }

    public virtual DbSet<AuditCalificacionServicioAlCliente> AuditCalificacionServicioAlClientes { get; set; }

    public virtual DbSet<AuditCalificacionVisitum> AuditCalificacionVisita { get; set; }

    public virtual DbSet<AuditDietum> AuditDieta { get; set; }

    public virtual DbSet<AuditEmpleado> AuditEmpleados { get; set; }

    public virtual DbSet<AuditEspecie> AuditEspecies { get; set; }

    public virtual DbSet<AuditEstadoHabitacion> AuditEstadoHabitacions { get; set; }

    public virtual DbSet<AuditEstadoSalud> AuditEstadoSaluds { get; set; }

    public virtual DbSet<AuditEstadoTarea> AuditEstadoTareas { get; set; }

    public virtual DbSet<AuditHabitacion> AuditHabitacions { get; set; }

    public virtual DbSet<AuditMetodoPago> AuditMetodoPagos { get; set; }

    public virtual DbSet<AuditPuesto> AuditPuestos { get; set; }

    public virtual DbSet<AuditRol> AuditRols { get; set; }

    public virtual DbSet<AuditTarea> AuditTareas { get; set; }

    public virtual DbSet<AuditTipoEntradum> AuditTipoEntrada { get; set; }

    public virtual DbSet<AuditTipoHabitacion> AuditTipoHabitacions { get; set; }

    public virtual DbSet<AuditUsuario> AuditUsuarios { get; set; }

    public virtual DbSet<AuditVentaEntradum> AuditVentaEntrada { get; set; }

    public virtual DbSet<AuditVisitante> AuditVisitantes { get; set; }

    public virtual DbSet<AuditZoo> AuditZoos { get; set; }

    public virtual DbSet<CalificacionRecorrido> CalificacionRecorridos { get; set; }

    public virtual DbSet<CalificacionServicioAlCliente> CalificacionServicioAlClientes { get; set; }

    public virtual DbSet<CalificacionVisitum> CalificacionVisita { get; set; }

    public virtual DbSet<ControlAnimal> ControlAnimals { get; set; }

    public virtual DbSet<DetalleVentum> DetalleVenta { get; set; }

    public virtual DbSet<DietaAlimento> DietaAlimentos { get; set; }

    public virtual DbSet<Dietum> Dieta { get; set; }

    public virtual DbSet<Empleado> Empleados { get; set; }

    public virtual DbSet<Entradum> Entrada { get; set; }

    public virtual DbSet<Especie> Especies { get; set; }

    public virtual DbSet<EstadoHabitacion> EstadoHabitacions { get; set; }

    public virtual DbSet<EstadoSalud> EstadoSaluds { get; set; }

    public virtual DbSet<EstadoTarea> EstadoTareas { get; set; }

    public virtual DbSet<Habitacion> Habitacions { get; set; }

    public virtual DbSet<HistorialEstadoTarea> HistorialEstadoTareas { get; set; }

    public virtual DbSet<HistorialMovimiento> HistorialMovimientos { get; set; }

    public virtual DbSet<MantenimientoHabitacion> MantenimientoHabitacions { get; set; }

    public virtual DbSet<MetodoPago> MetodoPagos { get; set; }

    public virtual DbSet<Puesto> Puestos { get; set; }

    public virtual DbSet<Rol> Rols { get; set; }

    public virtual DbSet<RolUsuario> RolUsuarios { get; set; }

    public virtual DbSet<Tarea> Tareas { get; set; }

    public virtual DbSet<TipoEntradum> TipoEntrada { get; set; }

    public virtual DbSet<TipoHabitacion> TipoHabitacions { get; set; }

    public virtual DbSet<TipoTarea> TipoTareas { get; set; }

    public virtual DbSet<UnidadMedidum> UnidadMedida { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    public virtual DbSet<VentaEntradum> VentaEntrada { get; set; }

    public virtual DbSet<Visitante> Visitantes { get; set; }

    public virtual DbSet<VwAlimento> VwAlimentos { get; set; }

    public virtual DbSet<VwAlimentosMasUtilizado> VwAlimentosMasUtilizados { get; set; }

    public virtual DbSet<VwAnimale> VwAnimales { get; set; }

    public virtual DbSet<VwAnimalesConMasMovimiento> VwAnimalesConMasMovimientos { get; set; }

    public virtual DbSet<VwCalificacionVisitum> VwCalificacionVisita { get; set; }

    public virtual DbSet<VwCalificacionesPorFecha> VwCalificacionesPorFechas { get; set; }

    public virtual DbSet<VwCantidadAlimentosPorTipoDietum> VwCantidadAlimentosPorTipoDieta { get; set; }

    public virtual DbSet<VwControlAnimal> VwControlAnimals { get; set; }

    public virtual DbSet<VwDetalleVentum> VwDetalleVenta { get; set; }

    public virtual DbSet<VwDietaAlimento> VwDietaAlimentos { get; set; }

    public virtual DbSet<VwDietum> VwDieta { get; set; }

    public virtual DbSet<VwDistribucionAlimentosPorUnidadMedidum> VwDistribucionAlimentosPorUnidadMedida { get; set; }

    public virtual DbSet<VwDistribucionCalificacionRecorrido> VwDistribucionCalificacionRecorridos { get; set; }

    public virtual DbSet<VwDistribucionTareasPorTipoYempleado> VwDistribucionTareasPorTipoYempleados { get; set; }

    public virtual DbSet<VwEmpleado> VwEmpleados { get; set; }

    public virtual DbSet<VwEmpleadoLogin> VwEmpleadoLogins { get; set; }

    public virtual DbSet<VwEmpleadoRolesActivo> VwEmpleadoRolesActivos { get; set; }

    public virtual DbSet<VwEmpleadosTareasCompletada> VwEmpleadosTareasCompletadas { get; set; }

    public virtual DbSet<VwEmpleadosTareasPendiente> VwEmpleadosTareasPendientes { get; set; }

    public virtual DbSet<VwEntradasActiva> VwEntradasActivas { get; set; }

    public virtual DbSet<VwEspecy> VwEspecies { get; set; }

    public virtual DbSet<VwEstadoHabitacion> VwEstadoHabitacions { get; set; }

    public virtual DbSet<VwEstadoSalud> VwEstadoSaluds { get; set; }

    public virtual DbSet<VwEstadoTarea> VwEstadoTareas { get; set; }

    public virtual DbSet<VwHabitacion> VwHabitacions { get; set; }

    public virtual DbSet<VwHistorialMovimiento> VwHistorialMovimientos { get; set; }

    public virtual DbSet<VwHistorialMovimientosPorAnimal> VwHistorialMovimientosPorAnimals { get; set; }

    public virtual DbSet<VwMantenimientoHabitacion> VwMantenimientoHabitacions { get; set; }

    public virtual DbSet<VwMetodoPago> VwMetodoPagos { get; set; }

    public virtual DbSet<VwPorcentajeDietasPorAlimento> VwPorcentajeDietasPorAlimentos { get; set; }

    public virtual DbSet<VwPorcentajeTareasCompletadasPorTipo> VwPorcentajeTareasCompletadasPorTipos { get; set; }

    public virtual DbSet<VwPromedioCalificacione> VwPromedioCalificaciones { get; set; }

    public virtual DbSet<VwPromedioCantidadAlimentosPorDietum> VwPromedioCantidadAlimentosPorDieta { get; set; }

    public virtual DbSet<VwPromedioNotaFinalPorMe> VwPromedioNotaFinalPorMes { get; set; }

    public virtual DbSet<VwPuesto> VwPuestos { get; set; }

    public virtual DbSet<VwResumenTareasPorEstado> VwResumenTareasPorEstados { get; set; }

    public virtual DbSet<VwRole> VwRoles { get; set; }

    public virtual DbSet<VwTarea> VwTareas { get; set; }

    public virtual DbSet<VwTipoEntradum> VwTipoEntrada { get; set; }

    public virtual DbSet<VwTipoHabitacion> VwTipoHabitacions { get; set; }

    public virtual DbSet<VwTipoTarea> VwTipoTareas { get; set; }

    public virtual DbSet<VwTopDiasConMasVenta> VwTopDiasConMasVentas { get; set; }

    public virtual DbSet<VwTotalAlimentosPorDietum> VwTotalAlimentosPorDieta { get; set; }

    public virtual DbSet<VwTotalEntradasVendida> VwTotalEntradasVendidas { get; set; }

    public virtual DbSet<VwTotalVenta> VwTotalVentas { get; set; }

    public virtual DbSet<VwVentaEntradum> VwVentaEntrada { get; set; }

    public virtual DbSet<VwVentasPorDium> VwVentasPorDia { get; set; }

    public virtual DbSet<VwVentasPorEmpleado> VwVentasPorEmpleados { get; set; }

    public virtual DbSet<VwVentasPorEntradaYtipo> VwVentasPorEntradaYtipos { get; set; }

    public virtual DbSet<VwVentasPorMetodoPago> VwVentasPorMetodoPagos { get; set; }

    public virtual DbSet<VwVentasPorTipoEntradum> VwVentasPorTipoEntrada { get; set; }

    public virtual DbSet<VwVentasPorVisitante> VwVentasPorVisitantes { get; set; }

    public virtual DbSet<VwVisitante> VwVisitantes { get; set; }

    public virtual DbSet<Zoo> Zoos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=ZooMA;Integrated Security=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Alimento>(entity =>
        {
            entity.HasKey(e => e.IdAlimentos).HasName("PK_Alimentos_IdAlimentos");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdUnidadMedidaNavigation).WithMany(p => p.Alimentos)
                .HasForeignKey(d => d.IdUnidadMedida)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Alimentos_IdUnidadMedida");
        });

        modelBuilder.Entity<Animale>(entity =>
        {
            entity.HasKey(e => e.IdAnimales);

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_Animales"));

            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.NombreAni)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdDietaNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdDieta)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdDieta");

            entity.HasOne(d => d.IdEspecieNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdEspecie)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdEspecies");

            entity.HasOne(d => d.IdEstadoSaludNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdEstadoSalud)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdEstadoSalud_IdEstadoSalud");

            entity.HasOne(d => d.IdHabitacionNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdHabitacion");

            entity.HasOne(d => d.IdZooNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdZoo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdZoo");
        });

        modelBuilder.Entity<AuditAlimento>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Al__C87E13DD19A342FE");

            entity.ToTable("Audit_Alimentos");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditAnimale>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_An__C87E13DDF588B524");

            entity.ToTable("Audit_Animales");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreAni)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditCalificacionRecorrido>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD325C3F00");

            entity.ToTable("Audit_CalificacionRecorrido");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Nota)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditCalificacionServicioAlCliente>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD44442B31");

            entity.ToTable("Audit_CalificacionServicioAlCliente");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Nota)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditCalificacionVisitum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD407B02B4");

            entity.ToTable("Audit_CalificacionVisita");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditDietum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Di__C87E13DDC9999B94");

            entity.ToTable("Audit_Dieta");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreDiet)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditEmpleado>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Em__C87E13DD8213F50E");

            entity.ToTable("Audit_Empleado");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Correo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditEspecie>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD6544FE42");

            entity.ToTable("Audit_Especie");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreEsp)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditEstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD872066E4");

            entity.ToTable("Audit_EstadoHabitacion");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Estado)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditEstadoSalud>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DDFDA93D8D");

            entity.ToTable("Audit_EstadoSalud");

            entity.Property(e => e.EstadoSalud)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditEstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DDB5FB65FD");

            entity.ToTable("Audit_EstadoTarea");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ha__C87E13DD68E62B9A");

            entity.ToTable("Audit_Habitacion");

            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreHab)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditMetodoPago>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Me__C87E13DD8C08E74A");

            entity.ToTable("Audit_MetodoPago");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.MetodoPago)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditPuesto>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Pu__C87E13DDA52CF59C");

            entity.ToTable("Audit_Puesto");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditRol>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ro__C87E13DD83B2C7A1");

            entity.ToTable("Audit_Rol");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditTarea>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ta__C87E13DD1D5FD053");

            entity.ToTable("Audit_Tareas");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditTipoEntradum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DD94F244F1");

            entity.ToTable("Audit_TipoEntrada");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreEnt)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Precio).HasColumnType("money");
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditTipoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DD2FF8382B");

            entity.ToTable("Audit_TipoHabitacion");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTh)
                .HasMaxLength(75)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditUsuario>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Us__C87E13DDF16FDD4E");

            entity.ToTable("Audit_Usuario");

            entity.Property(e => e.Contraseña)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditVentaEntradum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ve__C87E13DD152BF015");

            entity.ToTable("Audit_VentaEntrada");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditVisitante>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Vi__C87E13DD3A508D3C");

            entity.ToTable("Audit_Visitantes");

            entity.Property(e => e.Apell1Vist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apell2Vist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.CorreoElectronico)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreVist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditZoo>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_ZO__C87E13DDCC85A249");

            entity.ToTable("Audit_ZOO");

            entity.Property(e => e.DescripcionZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreZoo)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CalificacionRecorrido>(entity =>
        {
            entity.HasKey(e => e.IdCalificacionRecorrido).HasName("PK_CalificacionRecorrido_IdCalificacionRecorrido");

            entity.ToTable("CalificacionRecorrido");

            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CalificacionServicioAlCliente>(entity =>
        {
            entity.HasKey(e => e.IdCalificacionServicioAlCliente).HasName("PK_CalificacionServicioAlCliente_IdCalificacionServicioAlCliente");

            entity.ToTable("CalificacionServicioAlCliente");

            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CalificacionVisitum>(entity =>
        {
            entity.HasKey(e => e.IdCalificacionVisita).HasName("PK_CalificacionVisita_IdCalificacionVisita");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_CalificacionVisita"));

            entity.HasOne(d => d.IdCalificacionRecorridoNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdCalificacionRecorrido)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_IdCalificacionRecorrido");

            entity.HasOne(d => d.IdCalificacionServicioAlClienteNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdCalificacionServicioAlCliente)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_IdCalificacionServicioAlCliente");

            entity.HasOne(d => d.IdVentaEntradaNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdVentaEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_VentaEntrada");
        });

        modelBuilder.Entity<ControlAnimal>(entity =>
        {
            entity.HasKey(e => e.IdControl).HasName("PK_ControlAnimal_IdControl");

            entity.ToTable("ControlAnimal");

            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Reporte)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdAnimalesNavigation).WithMany(p => p.ControlAnimals)
                .HasForeignKey(d => d.IdAnimales)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ControlAnimal_IdAnimales");

            entity.HasOne(d => d.IdTareasNavigation).WithMany(p => p.ControlAnimals)
                .HasForeignKey(d => d.IdTareas)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ControlAnimal_IdTareas");
        });

        modelBuilder.Entity<DetalleVentum>(entity =>
        {
            entity.HasKey(e => e.IdDetalleVenta).HasName("PK__DetalleV__AAA5CEC2841C7DF5");

            entity.Property(e => e.Precio).HasColumnType("money");

            entity.HasOne(d => d.IdEntradaNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdEntrada");

            entity.HasOne(d => d.IdVentaEntradaNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdVentaEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdVentaEntrada");
        });

        modelBuilder.Entity<DietaAlimento>(entity =>
        {
            entity.HasKey(e => e.IdDietaAlimentos).HasName("PK_DietaAlimentos_IdDietaAlimentos");

            entity.Property(e => e.Cantidad).HasColumnType("decimal(10, 2)");

            entity.HasOne(d => d.IdAlimentosNavigation).WithMany(p => p.DietaAlimentos)
                .HasForeignKey(d => d.IdAlimentos)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DietaAlimentos_IdAlimentos");

            entity.HasOne(d => d.IdDietaNavigation).WithMany(p => p.DietaAlimentos)
                .HasForeignKey(d => d.IdDieta)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DietaAlimentos_IdDieta");
        });

        modelBuilder.Entity<Dietum>(entity =>
        {
            entity.HasKey(e => e.IdDieta).HasName("PK_Dieta_IdDieta");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_Dieta"));

            entity.Property(e => e.NombreDiet)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Empleado>(entity =>
        {
            entity.HasKey(e => e.IdEmpleado).HasName("PK_Empleado_IdEmpleado");

            entity.ToTable("Empleado", tb => tb.HasTrigger("trg_Audit_Empleado"));

            entity.Property(e => e.IdEmpleado).ValueGeneratedNever();
            entity.Property(e => e.Apellido1)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Correo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdPuestoNavigation).WithMany(p => p.Empleados)
                .HasForeignKey(d => d.IdPuesto)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Empleado_IdPuesto");

            entity.HasOne(d => d.IdZooNavigation).WithMany(p => p.Empleados)
                .HasForeignKey(d => d.IdZoo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Empleado_IdZoo");
        });

        modelBuilder.Entity<Entradum>(entity =>
        {
            entity.HasKey(e => e.IdEntrada).HasName("PK_Entrada_IdEntrada");

            entity.Property(e => e.Descuento).HasColumnName("descuento");
            entity.Property(e => e.FechaVencimiento).HasColumnName("fechaVencimiento");

            entity.HasOne(d => d.IdTipoEntradaNavigation).WithMany(p => p.Entrada)
                .HasForeignKey(d => d.IdTipoEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Entrada_IdTipoEntrada");
        });

        modelBuilder.Entity<Especie>(entity =>
        {
            entity.HasKey(e => e.IdEspecie).HasName("PK_Especie_IdEspecie");

            entity.ToTable("Especie", tb => tb.HasTrigger("trg_Audit_Especies"));

            entity.Property(e => e.NombreEsp)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdEstadoHabitacion).HasName("PK_EstadoHabitacion_IdEstadoHabitacion");

            entity.ToTable("EstadoHabitacion", tb => tb.HasTrigger("trg_Audit_EstadoHabitacion"));

            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EstadoSalud>(entity =>
        {
            entity.HasKey(e => e.IdEstadoSalud).HasName("PK_EstadoSalud_IdEstadoSalud");

            entity.ToTable("EstadoSalud", tb => tb.HasTrigger("trg_Audit_EstadoSalud"));

            entity.Property(e => e.EstadoSalud1)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("EstadoSalud");
        });

        modelBuilder.Entity<EstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdEstadoTarea).HasName("PK_EstadoTarea_IdEstadoTarea");

            entity.ToTable("EstadoTarea", tb => tb.HasTrigger("trg_Audit_EstadoTarea"));

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Habitacion>(entity =>
        {
            entity.HasKey(e => e.IdHabitacion).HasName("PK_Habitacion_IdHabitacion");

            entity.ToTable("Habitacion", tb => tb.HasTrigger("trg_Audit_Habitacion"));

            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.NombreHab)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdEstadoHabitacionNavigation).WithMany(p => p.Habitacions)
                .HasForeignKey(d => d.IdEstadoHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HabitacionEstadoHabitacion");

            entity.HasOne(d => d.IdTipoHabitacionNavigation).WithMany(p => p.Habitacions)
                .HasForeignKey(d => d.IdTipoHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Habitacion_IdTipoHabitacion");
        });

        modelBuilder.Entity<HistorialEstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdHistorialEstadoTarea).HasName("PK__Historia__FF5429C7FE0098D6");

            entity.ToTable("HistorialEstadoTarea");

            entity.Property(e => e.Fecha)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.HistorialEstadoTareas)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialEstadoTarea_Empleado");

            entity.HasOne(d => d.IdEstadoTareaNavigation).WithMany(p => p.HistorialEstadoTareas)
                .HasForeignKey(d => d.IdEstadoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialEstadoTarea_EstadoTarea");

            entity.HasOne(d => d.IdTareaNavigation).WithMany(p => p.HistorialEstadoTareas)
                .HasForeignKey(d => d.IdTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialEstadoTarea_Tarea");

            entity.HasOne(d => d.IdTipoTareaNavigation).WithMany(p => p.HistorialEstadoTareas)
                .HasForeignKey(d => d.IdTipoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialEstadoTarea_TipoTarea");
        });

        modelBuilder.Entity<HistorialMovimiento>(entity =>
        {
            entity.HasKey(e => e.IdHistorialMovimientos).HasName("PK_HistorialMovimientos_IdHistorialMovimientos");

            entity.Property(e => e.FechaMovimiento).HasColumnType("datetime");
            entity.Property(e => e.Motivo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor).HasColumnName("realizadoPor");

            entity.HasOne(d => d.IdAnimalesNavigation).WithMany(p => p.HistorialMovimientos)
                .HasForeignKey(d => d.IdAnimales)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialMovimientos_IdAnimales");

            entity.HasOne(d => d.IdHabitacionActualNavigation).WithMany(p => p.HistorialMovimientoIdHabitacionActualNavigations)
                .HasForeignKey(d => d.IdHabitacionActual)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialMovimientos_IdHabitacionActual");

            entity.HasOne(d => d.IdHabitacionAnteriorNavigation).WithMany(p => p.HistorialMovimientoIdHabitacionAnteriorNavigations)
                .HasForeignKey(d => d.IdHabitacionAnterior)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialMovimientos_IdHabitacionAnterior");
        });

        modelBuilder.Entity<MantenimientoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdMantenimientoHabitacion).HasName("PK_MantenimientoHabitacion_IdMantenimientoHabitacion");

            entity.ToTable("MantenimientoHabitacion");

            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Reporte)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdHabitacionNavigation).WithMany(p => p.MantenimientoHabitacions)
                .HasForeignKey(d => d.IdHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_MantenimientoHabitacion_IdHabitacion");

            entity.HasOne(d => d.IdTareasNavigation).WithMany(p => p.MantenimientoHabitacions)
                .HasForeignKey(d => d.IdTareas)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_MantenimientoHabitacion_IdTareas");
        });

        modelBuilder.Entity<MetodoPago>(entity =>
        {
            entity.HasKey(e => e.IdMetodoPago).HasName("PK_MetodoPago_IdMetodoPago");

            entity.ToTable("MetodoPago", tb => tb.HasTrigger("trg_Audit_MetodoPago"));

            entity.Property(e => e.Metodopago1)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("Metodopago");
        });

        modelBuilder.Entity<Puesto>(entity =>
        {
            entity.HasKey(e => e.IdPuesto).HasName("PK_Puesto_IdPuesto");

            entity.ToTable("Puesto", tb => tb.HasTrigger("trg_Audit_Puesto"));

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Rol>(entity =>
        {
            entity.HasKey(e => e.IdRol).HasName("PK_Rol_IdRol");

            entity.ToTable("Rol", tb => tb.HasTrigger("trg_Audit_Rol"));

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<RolUsuario>(entity =>
        {
            entity.HasKey(e => e.IdRolUsuario).HasName("PK_RolUsuario_IdRolUsuario");

            entity.ToTable("RolUsuario");

            entity.HasOne(d => d.IdRolNavigation).WithMany(p => p.RolUsuarios)
                .HasForeignKey(d => d.IdRol)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsuario_IdRol");

            entity.HasOne(d => d.IdUsuarioNavigation).WithMany(p => p.RolUsuarios)
                .HasForeignKey(d => d.IdUsuario)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsuario_IdUsuario");
        });

        modelBuilder.Entity<Tarea>(entity =>
        {
            entity.HasKey(e => e.IdTareas).HasName("PK_Tareas_IdTareas");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_Tareas"));

            entity.Property(e => e.Fecha)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Tareas_IdEmpleado");

            entity.HasOne(d => d.IdEstadoTareaNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdEstadoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasEstadoTareas_IdEstadoTarea");

            entity.HasOne(d => d.IdTipoTareaNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdTipoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasTipoTarea_IdTipoTarea");
        });

        modelBuilder.Entity<TipoEntradum>(entity =>
        {
            entity.HasKey(e => e.IdTipoEntrada).HasName("PK_TipoEntrada_IdTipoEntrada");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_TipoEntrada"));

            entity.Property(e => e.NombreEnt)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Precio).HasColumnType("money");
        });

        modelBuilder.Entity<TipoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdTipoHabitacion).HasName("PK_TipoHabitacion_IdTipoHabitacion");

            entity.ToTable("TipoHabitacion", tb => tb.HasTrigger("trg_Audit_TipoHabitacion"));

            entity.Property(e => e.NombreTh)
                .HasMaxLength(75)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
        });

        modelBuilder.Entity<TipoTarea>(entity =>
        {
            entity.HasKey(e => e.IdTipoTarea).HasName("PK__TipoTare__A623D65F16B18A67");

            entity.ToTable("TipoTarea");

            entity.Property(e => e.NombreTt)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NombreTT");
        });

        modelBuilder.Entity<UnidadMedidum>(entity =>
        {
            entity.HasKey(e => e.IdUnidadMedida).HasName("PK__UnidadMe__18F83A9313FC2AF6");

            entity.Property(e => e.Nombre)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.IdUsuario).HasName("PK_Usuario_IdUsuario");

            entity.ToTable("Usuario", tb => tb.HasTrigger("trg_Audit_Usuario"));

            entity.Property(e => e.IdUsuario).ValueGeneratedNever();
            entity.Property(e => e.Contraseña)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Estado).HasDefaultValue(true);

            entity.HasOne(d => d.IdUsuarioNavigation).WithOne(p => p.Usuario)
                .HasForeignKey<Usuario>(d => d.IdUsuario)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Usuario_IdEmpleado");
        });

        modelBuilder.Entity<VentaEntradum>(entity =>
        {
            entity.HasKey(e => e.IdVentaEntrada).HasName("PK_VentaEntrada_IdVentaEntrada");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_VentaEntrada"));

            entity.Property(e => e.Fechaventa).HasColumnType("datetime");
            entity.Property(e => e.Iva)
                .HasDefaultValueSql("((0.13))")
                .HasColumnType("money")
                .HasColumnName("IVA");

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdEmpleado");

            entity.HasOne(d => d.IdMetodoPagoNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdMetodoPago)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdMetodoPago");

            entity.HasOne(d => d.IdVisitantesNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdVisitantes)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdVisitantes");
        });

        modelBuilder.Entity<Visitante>(entity =>
        {
            entity.HasKey(e => e.IdVisitantes).HasName("PK_Visitantes_IdVisitantes");

            entity.ToTable(tb => tb.HasTrigger("trg_Audit_Visitantes"));

            entity.Property(e => e.IdVisitantes).ValueGeneratedNever();
            entity.Property(e => e.Apell1Vist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apell2Vist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.CorreoElectronico)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.NombreVist)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Telefono)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwAlimento>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Alimentos");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.UnidadMedida)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwAlimentosMasUtilizado>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_AlimentosMasUtilizados");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.CantidadTotal).HasColumnType("decimal(38, 2)");
            entity.Property(e => e.UnidadMedida)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwAnimale>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Animales");

            entity.Property(e => e.IdAnimales).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreAni)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombreAni");
        });

        modelBuilder.Entity<VwAnimalesConMasMovimiento>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_AnimalesConMasMovimientos");

            entity.Property(e => e.NombreAnimal)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwCalificacionVisitum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_CalificacionVisita");

            entity.Property(e => e.Fecha).HasColumnName("fecha");
            entity.Property(e => e.IdCalificacionVisita).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwCalificacionesPorFecha>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_CalificacionesPorFecha");

            entity.Property(e => e.PromedioNotaFinal).HasColumnType("decimal(38, 6)");
        });

        modelBuilder.Entity<VwCantidadAlimentosPorTipoDietum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_CantidadAlimentosPorTipoDieta");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.CantidadTotal).HasColumnType("decimal(38, 2)");
            entity.Property(e => e.TipoDieta)
                .HasMaxLength(62)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwControlAnimal>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_ControlAnimal");

            entity.Property(e => e.IdControl).ValueGeneratedOnAdd();
            entity.Property(e => e.Reporte)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("reporte");
        });

        modelBuilder.Entity<VwDetalleVentum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_DetalleVenta");

            entity.Property(e => e.IdDetalleVenta).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwDietaAlimento>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_DietaAlimentos");

            entity.Property(e => e.IdDietaAlimentos).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwDietum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Dieta");

            entity.Property(e => e.IdDieta).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreDiet)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwDistribucionAlimentosPorUnidadMedidum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_DistribucionAlimentosPorUnidadMedida");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.CantidadTotal).HasColumnType("decimal(38, 2)");
            entity.Property(e => e.UnidadMedida)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwDistribucionCalificacionRecorrido>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_DistribucionCalificacionRecorrido");
        });

        modelBuilder.Entity<VwDistribucionTareasPorTipoYempleado>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_DistribucionTareasPorTipoYEmpleado");

            entity.Property(e => e.NombreCompleto).HasMaxLength(62);
            entity.Property(e => e.TipoTarea)
                .HasMaxLength(70)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwEmpleado>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Empleado");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Puesto)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Roles)
                .HasMaxLength(8000)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwEmpleadoLogin>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Empleado_Login");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Correo)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwEmpleadoRolesActivo>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Empleado_Roles_Activos");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<VwEmpleadosTareasCompletada>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Empleados_TareasCompletadas");

            entity.Property(e => e.NombreCompleto).HasMaxLength(62);
            entity.Property(e => e.Puesto)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.TareasCompletadas).HasColumnName("Tareas Completadas");
        });

        modelBuilder.Entity<VwEmpleadosTareasPendiente>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Empleados_TareasPendientes");

            entity.Property(e => e.NombreCompleto).HasMaxLength(62);
        });

        modelBuilder.Entity<VwEntradasActiva>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Entradas_Activas");

            entity.Property(e => e.Descuento).HasColumnName("descuento");
            entity.Property(e => e.FechaVencimiento).HasColumnName("fechaVencimiento");
            entity.Property(e => e.PrecioTipoEntrada)
                .HasColumnType("money")
                .HasColumnName("Precio tipo entrada");
            entity.Property(e => e.PrecioTotal)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("Precio total");
            entity.Property(e => e.TipoEntrada)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("Tipo entrada");
        });

        modelBuilder.Entity<VwEspecy>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Especies");

            entity.Property(e => e.IdEspecie).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreEsp)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwEstadoHabitacion>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_EstadoHabitacion");

            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("estado");
            entity.Property(e => e.IdEstadoHabitacion).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwEstadoSalud>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_EstadoSalud");

            entity.Property(e => e.EstadoSalud)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("estadoSalud");
            entity.Property(e => e.IdEstadoSalud).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwEstadoTarea>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_EstadoTarea");

            entity.Property(e => e.IdEstadoTarea).ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwHabitacion>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Habitacion");

            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.IdHabitacion).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreHab)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwHistorialMovimiento>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_HistorialMovimientos");

            entity.Property(e => e.FechaMovimiento).HasColumnType("datetime");
            entity.Property(e => e.IdHistorialMovimientos).ValueGeneratedOnAdd();
            entity.Property(e => e.Motivo)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwHistorialMovimientosPorAnimal>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_HistorialMovimientosPorAnimal");

            entity.Property(e => e.Fecha)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.HabitacionActual)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.HabitacionAnterior)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Motivo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreAnimal)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwMantenimientoHabitacion>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_MantenimientoHabitacion");

            entity.Property(e => e.IdMantenimientoHabitacion).ValueGeneratedOnAdd();
            entity.Property(e => e.Reporte)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("reporte");
        });

        modelBuilder.Entity<VwMetodoPago>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_MetodoPago");

            entity.Property(e => e.IdMetodoPago).ValueGeneratedOnAdd();
            entity.Property(e => e.Metodopago)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("metodopago");
        });

        modelBuilder.Entity<VwPorcentajeDietasPorAlimento>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_PorcentajeDietasPorAlimento");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.PorcentajeDietas).HasColumnType("decimal(5, 2)");
        });

        modelBuilder.Entity<VwPorcentajeTareasCompletadasPorTipo>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_PorcentajeTareasCompletadasPorTipo");

            entity.Property(e => e.PorcentajeCompletado).HasColumnType("decimal(5, 2)");
            entity.Property(e => e.TipoTarea)
                .HasMaxLength(70)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwPromedioCalificacione>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_PromedioCalificaciones");

            entity.Property(e => e.PromedioNotaFinal).HasColumnType("decimal(38, 6)");
        });

        modelBuilder.Entity<VwPromedioCantidadAlimentosPorDietum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_PromedioCantidadAlimentosPorDieta");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.PromedioCantidad).HasColumnType("decimal(38, 6)");
        });

        modelBuilder.Entity<VwPromedioNotaFinalPorMe>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_PromedioNotaFinalPorMes");

            entity.Property(e => e.PromedioNotaFinal).HasColumnType("decimal(38, 6)");
        });

        modelBuilder.Entity<VwPuesto>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Puesto");

            entity.Property(e => e.IdPuesto).ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwResumenTareasPorEstado>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_ResumenTareasPorEstado");

            entity.Property(e => e.EstadoTarea)
                .HasMaxLength(70)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwRole>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Roles");

            entity.Property(e => e.IdRol).ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwTarea>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Tareas");

            entity.Property(e => e.IdTareas).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwTipoEntradum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TipoEntrada");

            entity.Property(e => e.IdTipoEntrada).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreEnt)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombreEnt");
            entity.Property(e => e.Precio).HasColumnType("money");
        });

        modelBuilder.Entity<VwTipoHabitacion>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TipoHabitacion");

            entity.Property(e => e.IdTipoHabitacion).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreTh)
                .HasMaxLength(75)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
        });

        modelBuilder.Entity<VwTipoTarea>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TipoTarea");

            entity.Property(e => e.IdTipoTarea).ValueGeneratedOnAdd();
            entity.Property(e => e.NombreTt)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NombreTT");
        });

        modelBuilder.Entity<VwTopDiasConMasVenta>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TopDiasConMasVentas");

            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwTotalAlimentosPorDietum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TotalAlimentosPorDieta");

            entity.Property(e => e.Alimento)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.CantidadTotal).HasColumnType("decimal(38, 2)");
            entity.Property(e => e.Dieta)
                .HasMaxLength(62)
                .IsUnicode(false);
            entity.Property(e => e.UnidadMedida)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwTotalEntradasVendida>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TotalEntradasVendidas");

            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwTotalVenta>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_TotalVentas");

            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwVentaEntradum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentaEntrada");

            entity.Property(e => e.Fechaventa)
                .HasColumnType("datetime")
                .HasColumnName("fechaventa");
            entity.Property(e => e.IdVentaEntrada).ValueGeneratedOnAdd();
        });

        modelBuilder.Entity<VwVentasPorDium>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorDia");

            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwVentasPorEmpleado>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorEmpleado");

            entity.Property(e => e.Empleado).HasMaxLength(62);
            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwVentasPorEntradaYtipo>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorEntradaYTipo");

            entity.Property(e => e.MontoTotal).HasColumnType("money");
            entity.Property(e => e.TipoEntrada)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwVentasPorMetodoPago>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorMetodoPago");

            entity.Property(e => e.MetodoPago)
                .HasMaxLength(70)
                .IsUnicode(false);
            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
        });

        modelBuilder.Entity<VwVentasPorTipoEntradum>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorTipoEntrada");

            entity.Property(e => e.MontoTotalVentas).HasColumnType("money");
            entity.Property(e => e.TipoEntrada)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwVentasPorVisitante>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_VentasPorVisitante");

            entity.Property(e => e.GastoTotal).HasColumnType("money");
            entity.Property(e => e.Visitante)
                .HasMaxLength(64)
                .IsUnicode(false);
        });

        modelBuilder.Entity<VwVisitante>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Vw_Visitantes");

            entity.Property(e => e.Apell1Vist)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("apell1Vist");
            entity.Property(e => e.Apell2Vist)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("apell2Vist");
            entity.Property(e => e.NombreVist)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombreVist");
        });

        modelBuilder.Entity<Zoo>(entity =>
        {
            entity.HasKey(e => e.IdZoo).HasName("PK_ZOO_IdZoo");

            entity.ToTable("ZOO", tb => tb.HasTrigger("trg_Audit_ZOO"));

            entity.Property(e => e.DescripcionZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.NombreZoo)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
