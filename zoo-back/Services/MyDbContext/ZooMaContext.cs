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

    public virtual DbSet<EstadoSalud> EstadoSalud { get; set; }

    public virtual DbSet<EstadoTarea> EstadoTareas { get; set; }

    public virtual DbSet<Habitacion> Habitacion { get; set; }

    public virtual DbSet<HabitacionEstadoHabitacion> HabitacionEstadoHabitacion { get; set; }

    public virtual DbSet<HistorialMovimiento> HistorialMovimientos { get; set; }

    public virtual DbSet<MantenimientoHabitacion> MantenimientoHabitacion { get; set; }

    public virtual DbSet<MetodoPago> MetodoPagos { get; set; }

    public virtual DbSet<Puesto> Puestos { get; set; }

    public virtual DbSet<Rol> Rols { get; set; }

    public virtual DbSet<RolUsario> RolUsarios { get; set; }

    public virtual DbSet<Tarea> Tareas { get; set; }

    public virtual DbSet<TareasEstadoTarea> TareasEstadoTareas { get; set; }

    public virtual DbSet<TipoEntradum> TipoEntrada { get; set; }

    public virtual DbSet<TipoHabitacion> TipoHabitacion { get; set; }

    public virtual DbSet<TipoTarea> TipoTareas { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    public virtual DbSet<VentaEntradum> VentaEntrada { get; set; }

    public virtual DbSet<Visitante> Visitantes { get; set; }

    public virtual DbSet<Zoo> Zoos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=ZooMA;User ID=test;Password=1234;TrustServerCertificate=True;");


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Alimento>(entity =>
        {
            entity.HasKey(e => e.IdAlimentos).HasName("PK__Alimento__9882C1B152FC5AA4");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Animale>(entity =>
        {
            entity.HasKey(e => e.IdAnimales).HasName("PK__Animales__D29EC56E01465E05");

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
                .HasConstraintName("FK_Animales_IdEstadoSalud");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Al__C87E13DD0B79A852");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_An__C87E13DD6B7AC227");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD2E140877");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD2254785C");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DDADBD7FB1");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Di__C87E13DD506D5EBB");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Em__C87E13DD443C564F");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD588A4E20");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD3518A88C");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD971DDE0B");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DDCCC6DE82");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ha__C87E13DD59B810E6");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Me__C87E13DD6AE1AF23");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Pu__C87E13DD3D779369");

            entity.ToTable("Audit_Puesto");

            entity.Property(e => e.DescripcionTareas)
                .HasMaxLength(255)
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

        modelBuilder.Entity<AuditRol>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ro__C87E13DD8E4319A7");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ta__C87E13DD3AA8667E");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DD57A6FDD4");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DD5D5CC623");

            entity.ToTable("Audit_TipoHabitacion");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.NombreTh)
                .HasMaxLength(20)
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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Us__C87E13DD7DEAB05E");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ve__C87E13DDF4CC0D2A");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Vi__C87E13DDA8FE94A2");

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
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_ZO__C87E13DDE49D711B");

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
            entity.HasKey(e => e.IdCalificacionRecorrido).HasName("PK__Califica__5731B49202B2F425");

            entity.ToTable("CalificacionRecorrido");

            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CalificacionServicioAlCliente>(entity =>
        {
            entity.HasKey(e => e.IdCalificacionServicioAlCliente).HasName("PK__Califica__D7CC7198ACD62C9A");

            entity.ToTable("CalificacionServicioAlCliente");

            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<CalificacionVisitum>(entity =>
        {
            entity.HasKey(e => e.IdCalificacionVisita).HasName("PK__Califica__815EB052FD8CFBF3");

            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdCalificacionRecorridoNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdCalificacionRecorrido)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_IdCalificacionRecorrido");

            entity.HasOne(d => d.IdCalificacionServicioAlClienteNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdCalificacionServicioAlCliente)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_IdCalificacionServicioAlCliente");

            entity.HasOne(d => d.IdVisitantesNavigation).WithMany(p => p.CalificacionVisita)
                .HasForeignKey(d => d.IdVisitantes)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CalificacionVisita_IdVisitantes");
        });

        modelBuilder.Entity<ControlAnimal>(entity =>
        {
            entity.HasKey(e => e.IdControl).HasName("PK__ControlA__2537521FD91F6536");

            entity.ToTable("ControlAnimal");

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
            entity.HasKey(e => e.IdDetalleVenta).HasName("PK__DetalleV__AAA5CEC21089BD92");

            entity.HasOne(d => d.IdEntradaNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdEntrada");

            entity.HasOne(d => d.IdTipoEntradaNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdTipoEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdTipoEntrada");
        });

        modelBuilder.Entity<DietaAlimento>(entity =>
        {
            entity.HasKey(e => e.IdDietaAlimentos).HasName("PK__DietaAli__0ACB1C4B8706B389");

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
            entity.HasKey(e => e.IdDieta).HasName("PK__Dieta__5F4BB815F9B3EC05");

            entity.Property(e => e.NombreDiet)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Empleado>(entity =>
        {
            entity.HasKey(e => e.IdEmpleado).HasName("PK__Empleado__CE6D8B9ED9490E39");

            entity.ToTable("Empleado");

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
            entity.HasKey(e => e.IdEntrada).HasName("PK__Entrada__BB164DEAF06A75A2");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdTipoEntradaNavigation).WithMany(p => p.Entrada)
                .HasForeignKey(d => d.IdTipoEntrada)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Entrada_IdTipoEntrada");
        });

        modelBuilder.Entity<Especie>(entity =>
        {
            entity.HasKey(e => e.IdEspecie).HasName("PK__Especie__08BEEA3E406B1FEC");

            entity.ToTable("Especie");

            entity.Property(e => e.NombreEsp)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdEstadoHabitacion).HasName("PK__EstadoHa__EBF610CE5FEFD53D");

            entity.ToTable("EstadoHabitacion");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Estado)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EstadoSalud>(entity =>
        {
            entity.HasKey(e => e.IdEstadoSalud).HasName("PK__EstadoSa__01EAFF25465BB83F");

            entity.ToTable("EstadoSalud");

            entity.Property(e => e.EstadoSalud1)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("EstadoSalud");
        });

        modelBuilder.Entity<EstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdEstadoTarea).HasName("PK__EstadoTa__09BBFBF40C1E9132");

            entity.ToTable("EstadoTarea");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Habitacion>(entity =>
        {
            entity.HasKey(e => e.IdHabitacion).HasName("PK__Habitaci__8BBBF90155FE5705");

            entity.ToTable("Habitacion");

            entity.Property(e => e.Direccion)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.NombreHab)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdTipoHabitacionNavigation).WithMany(p => p.Habitacions)
                .HasForeignKey(d => d.IdTipoHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Habitacion_IdTipoHabitacion");
        });

        modelBuilder.Entity<HabitacionEstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdHabitacionEstadoHabitacion).HasName("PK__Habitaci__7E4231BB342A980C");

            entity.ToTable("HabitacionEstadoHabitacion");

            entity.HasOne(d => d.IdEstadoHabitacionNavigation).WithMany(p => p.HabitacionEstadoHabitacions)
                .HasForeignKey(d => d.IdEstadoHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HabitacionEstadoHabitacion_IdEstadoHabitacion");

            entity.HasOne(d => d.IdHabitacionNavigation).WithMany(p => p.HabitacionEstadoHabitacions)
                .HasForeignKey(d => d.IdHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HabitacionEstadoHabitacion_IdHabitacion");
        });

        modelBuilder.Entity<HistorialMovimiento>(entity =>
        {
            entity.HasKey(e => e.IdHistorialMovimientos).HasName("PK__Historia__DB40A18DE15865EF");

            entity.Property(e => e.Motivo)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdAnimalesNavigation).WithMany(p => p.HistorialMovimientos)
                .HasForeignKey(d => d.IdAnimales)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistorialMovimientos_IdAnimales");
        });

        modelBuilder.Entity<MantenimientoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdMantenimientoHabitacion).HasName("PK__Mantenim__C724A79C07608DF4");

            entity.ToTable("MantenimientoHabitacion");

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
            entity.HasKey(e => e.IdMetodoPago).HasName("PK__MetodoPa__6F49A9BEE3FFBBC9");

            entity.ToTable("MetodoPago");

            entity.Property(e => e.Metodopago1)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("Metodopago");
        });

        modelBuilder.Entity<Puesto>(entity =>
        {
            entity.HasKey(e => e.IdPuesto).HasName("PK__Puesto__ADAC6B9C18BC6578");

            entity.ToTable("Puesto");

            entity.Property(e => e.DescripcionTareas)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Rol>(entity =>
        {
            entity.HasKey(e => e.IdRol).HasName("PK__Rol__2A49584C8AF11B33");

            entity.ToTable("Rol");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<RolUsario>(entity =>
        {
            entity.HasKey(e => e.IdRolUsario).HasName("PK__RolUsari__F11979EA2F69CCDE");

            entity.ToTable("RolUsario");

            entity.HasOne(d => d.IdRolNavigation).WithMany(p => p.RolUsarios)
                .HasForeignKey(d => d.IdRol)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsario_IdRol");

            entity.HasOne(d => d.IdUsuarioNavigation).WithMany(p => p.RolUsarios)
                .HasForeignKey(d => d.IdUsuario)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsario_IdUsuario");
        });

        modelBuilder.Entity<Tarea>(entity =>
        {
            entity.HasKey(e => e.IdTareas).HasName("PK__Tareas__61D0EF21E630067D");

            entity.Property(e => e.Nombre)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Tareas_IdEmpleado");

            entity.HasOne(d => d.IdTipoTareaNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdTipoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Tareas_IdTipoTarea");
        });

        modelBuilder.Entity<TareasEstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdTareas).HasName("PK__TareasEs__61D0EF210C79B75E");

            entity.Property(e => e.IdTareas).ValueGeneratedOnAdd();

            entity.HasOne(d => d.IdHabitacionNavigation).WithMany(p => p.TareasEstadoTareas)
                .HasForeignKey(d => d.IdHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasEstadoTareas_IdHabitacion");

            entity.HasOne(d => d.IdTareasNavigation).WithOne(p => p.TareasEstadoTarea)
                .HasForeignKey<TareasEstadoTarea>(d => d.IdTareas)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasEstadoTareas_IdTareas");
        });

        modelBuilder.Entity<TipoEntradum>(entity =>
        {
            entity.HasKey(e => e.IdTipoEntrada).HasName("PK__TipoEntr__00A2A1DE8E6FC444");

            entity.Property(e => e.NombreEnt)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Precio).HasColumnType("money");
        });

        modelBuilder.Entity<TipoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdTipoHabitacion).HasName("PK__TipoHabi__AB75E87CF4DA8AB8");

            entity.ToTable("TipoHabitacion");

            entity.Property(e => e.NombreTh)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
        });

        modelBuilder.Entity<TipoTarea>(entity =>
        {
            entity.HasKey(e => e.IdTipoTarea).HasName("PK__TipoTare__A623D65FEBC9A9E6");

            entity.ToTable("TipoTarea");

            entity.Property(e => e.NombreTt)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("NombreTT");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.IdUsuario).HasName("PK__Usuario__5B65BF970A6238AC");

            entity.ToTable("Usuario");

            entity.Property(e => e.Contraseña)
                .HasMaxLength(20)
                .IsUnicode(false);

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.Usuarios)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Usuario_IdEmpleado");
        });

        modelBuilder.Entity<VentaEntradum>(entity =>
        {
            entity.HasKey(e => e.IdVentaEntrada).HasName("PK__VentaEnt__5D1C3EAA32747FA7");

            entity.HasOne(d => d.IdMetodoPagoNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdMetodoPago)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdMetodoPago");

            entity.HasOne(d => d.IdVisitantesNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdVisitantes)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdVisitantes");

            entity.HasOne(d => d.IdZooNavigation).WithMany(p => p.VentaEntrada)
                .HasForeignKey(d => d.IdZoo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_VentaEntrada_IdZoo");
        });

        modelBuilder.Entity<Visitante>(entity =>
        {
            entity.HasKey(e => e.IdVisitantes).HasName("PK__Visitant__AB57AD45CA570B3D");

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
            entity.Property(e => e.Telefono).HasColumnName("TELEFONO");
        });

        modelBuilder.Entity<Zoo>(entity =>
        {
            entity.HasKey(e => e.IdZoo).HasName("PK__ZOO__283998DBAF4AAF8C");

            entity.ToTable("ZOO");

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
