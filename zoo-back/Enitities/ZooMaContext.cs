using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

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

    public virtual DbSet<Animale> Animales { get; set; }

    public virtual DbSet<AuditAlimento> AuditAlimentos { get; set; }

    public virtual DbSet<AuditAnimale> AuditAnimales { get; set; }

    public virtual DbSet<AuditCalificacionVisitum> AuditCalificacionVisita { get; set; }

    public virtual DbSet<AuditDietaAlimento> AuditDietaAlimentos { get; set; }

    public virtual DbSet<AuditDietum> AuditDieta { get; set; }

    public virtual DbSet<AuditEmpleado> AuditEmpleados { get; set; }

    public virtual DbSet<AuditEspecy> AuditEspecies { get; set; }

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

    public virtual DbSet<DetalleVentum> DetalleVenta { get; set; }

    public virtual DbSet<Dietum> Dieta { get; set; }

    public virtual DbSet<Empleado> Empleados { get; set; }

    public virtual DbSet<Especy> Especies { get; set; }

    public virtual DbSet<EstadoHabitacion> EstadoHabitacions { get; set; }

    public virtual DbSet<EstadoSalud> EstadoSaluds { get; set; }

    public virtual DbSet<EstadoTarea> EstadoTareas { get; set; }

    public virtual DbSet<Habitacion> Habitacions { get; set; }

    public virtual DbSet<HabitacionEstadoHabitacion> HabitacionEstadoHabitacions { get; set; }

    public virtual DbSet<HistorialMovimiento> HistorialMovimientos { get; set; }

    public virtual DbSet<MantenimientoHabitacion> MantenimientoHabitacions { get; set; }

    public virtual DbSet<Puesto> Puestos { get; set; }

    public virtual DbSet<Rol> Rols { get; set; }

    public virtual DbSet<RolUsario> RolUsarios { get; set; }

    public virtual DbSet<Tarea> Tareas { get; set; }

    public virtual DbSet<TareasEstadosTarea> TareasEstadosTareas { get; set; }

    public virtual DbSet<TipoHabitacion> TipoHabitacions { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }

    public virtual DbSet<Venta> Ventas { get; set; }

    public virtual DbSet<Visitante> Visitantes { get; set; }

    public virtual DbSet<Zoo> Zoos { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=ZooMA;Integrated Security=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Animale>(entity =>
        {
            entity.HasKey(e => e.IdAnimales).HasName("PK__Animales__D29EC56E0616C9AA");

            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.NombreAni)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdDietaNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdDieta)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Animales_IdDieta");

            entity.HasOne(d => d.IdEspeciesNavigation).WithMany(p => p.Animales)
                .HasForeignKey(d => d.IdEspecies)
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
                .HasConstraintName("FK_Animales_IdZoo");
        });

        modelBuilder.Entity<AuditAlimento>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Al__C87E13DD00979936");

            entity.ToTable("Audit_Alimentos");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreAli)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditAnimale>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_An__C87E13DD62C1B40A");

            entity.ToTable("Audit_Animales");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.NombreAni)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditCalificacionVisitum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ca__C87E13DD89003A93");

            entity.ToTable("Audit_CalificacionVisita");

            entity.Property(e => e.Fecha).HasColumnName("fecha");
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
            entity.Property(e => e.SugerenciaMejora)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<AuditDietaAlimento>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Di__C87E13DD4815BC28");

            entity.ToTable("Audit_DietaAlimentos");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditDietum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Di__C87E13DD40B73DF3");

            entity.ToTable("Audit_Dieta");

            entity.Property(e => e.DescripcionDiet)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreDiet)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditEmpleado>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Em__C87E13DD79C29F78");

            entity.ToTable("Audit_Empleado");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditEspecy>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD12A60376");

            entity.ToTable("Audit_Especies");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreEsp)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditEstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD0C1A1C00");

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
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditEstadoSalud>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DD66929AAF");

            entity.ToTable("Audit_EstadoSalud");

            entity.Property(e => e.EstadoSalud)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditEstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Es__C87E13DDCEAD4B03");

            entity.ToTable("Audit_EstadoTarea");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ha__C87E13DDD844C02E");

            entity.ToTable("Audit_Habitacion");

            entity.Property(e => e.Direccion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreHab)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditMetodoPago>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Me__C87E13DDC30379D2");

            entity.ToTable("Audit_MetodoPago");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.MetodoPago)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditPuesto>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Pu__C87E13DD860CC688");

            entity.ToTable("Audit_Puesto");

            entity.Property(e => e.DescripcionTareas)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditRol>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ro__C87E13DD9EC576BB");

            entity.ToTable("Audit_Rol");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditTarea>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ta__C87E13DDED53E039");

            entity.ToTable("Audit_Tareas");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditTipoEntradum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DDF126A8B4");

            entity.ToTable("Audit_TipoEntrada");

            entity.Property(e => e.DescripcionEnt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreEnt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.Precio).HasColumnType("money");
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditTipoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ti__C87E13DDFEEE2F27");

            entity.ToTable("Audit_TipoHabitacion");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.NombreTh)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditUsuario>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Us__C87E13DD675040D6");

            entity.ToTable("Audit_Usuario");

            entity.Property(e => e.Contraseña)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditVentaEntradum>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Ve__C87E13DDA30CA907");

            entity.ToTable("Audit_VentaEntrada");

            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Fechaventa).HasColumnName("fechaventa");
            entity.Property(e => e.Horaventa).HasColumnName("horaventa");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditVisitante>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_Vi__C87E13DDA2A6EC09");

            entity.ToTable("Audit_Visitantes");

            entity.Property(e => e.Apell1Vist)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Apell2Vist)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.NombreTabla).HasMaxLength(100);
            entity.Property(e => e.NombreVist)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Operacion).HasMaxLength(10);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<AuditZoo>(entity =>
        {
            entity.HasKey(e => e.IdAudit).HasName("PK__Audit_ZO__C87E13DD412EB4FF");

            entity.ToTable("Audit_ZOO");

            entity.Property(e => e.DescripcionZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Direccion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FechaDeEjecucion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.NombreTabla)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.NombreZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Operacion)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.RealizadoPor).HasMaxLength(128);
        });

        modelBuilder.Entity<DetalleVentum>(entity =>
        {
            entity.HasKey(e => e.IdDetalleVenta).HasName("PK__DetalleV__AAA5CEC2B11774CF");

            entity.HasOne(d => d.IdAnimalesNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdAnimales)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdAnimales");

            entity.HasOne(d => d.IdVentaNavigation).WithMany(p => p.DetalleVenta)
                .HasForeignKey(d => d.IdVenta)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_DetalleVenta_IdVenta");
        });

        modelBuilder.Entity<Dietum>(entity =>
        {
            entity.HasKey(e => e.IdDieta).HasName("PK__Dieta__5F4BB815D8AA3D18");

            entity.Property(e => e.DescripcionDiet)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreDiet)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Empleado>(entity =>
        {
            entity.HasKey(e => e.IdEmpleado).HasName("PK__Empleado__CE6D8B9E7380539D");

            entity.ToTable("Empleado");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.IdZoo).HasDefaultValue(1);
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdPuestoNavigation).WithMany(p => p.Empleados)
                .HasForeignKey(d => d.IdPuesto)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Empleado_IdPuesto");

            entity.HasOne(d => d.IdZooNavigation).WithMany(p => p.Empleados)
                .HasForeignKey(d => d.IdZoo)
                .HasConstraintName("FK_Empleado_IdZoo");
        });

        modelBuilder.Entity<Especy>(entity =>
        {
            entity.HasKey(e => e.IdEspecie).HasName("PK__Especies__08BEEA3EEB8D8549");

            entity.Property(e => e.NombreEsp)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<EstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdEstadoHabitacion).HasName("PK__EstadoHa__EBF610CE75B0BE0F");

            entity.ToTable("EstadoHabitacion");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("descripcion");
            entity.Property(e => e.Estado)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("estado");
        });

        modelBuilder.Entity<EstadoSalud>(entity =>
        {
            entity.HasKey(e => e.IdEstadoSalud).HasName("PK__EstadoSa__01EAFF254CECE58F");

            entity.ToTable("EstadoSalud");

            entity.Property(e => e.EstadoSalud1)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("estadoSalud");
        });

        modelBuilder.Entity<EstadoTarea>(entity =>
        {
            entity.HasKey(e => e.IdEstadoTarea).HasName("PK__EstadoTa__09BBFBF4BED0AC88");

            entity.ToTable("EstadoTarea");

            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Habitacion>(entity =>
        {
            entity.HasKey(e => e.IdHabitacion).HasName("PK__Habitaci__8BBBF901BF18834B");

            entity.ToTable("Habitacion");

            entity.Property(e => e.Direccion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreHab)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdTipoHabitacionNavigation).WithMany(p => p.Habitacions)
                .HasForeignKey(d => d.IdTipoHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Habitacion_IdTipoHabitacion");
        });

        modelBuilder.Entity<HabitacionEstadoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdHabitacionEstadoHabitacion).HasName("PK__Habitaci__7E4231BB17811845");

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
            entity.HasKey(e => e.IdHistorialMovimientos).HasName("PK__Historia__DB40A18DC698A4EA");

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
            entity.HasKey(e => e.IdMantenimientoHabitacion).HasName("PK__Mantenim__C724A79C66D5F993");

            entity.ToTable("MantenimientoHabitacion");

            entity.Property(e => e.Reporte)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("reporte");

            entity.HasOne(d => d.IdHabitacionNavigation).WithMany(p => p.MantenimientoHabitacions)
                .HasForeignKey(d => d.IdHabitacion)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_MantenimientoHabitacion_IdHabitacion");
        });

        modelBuilder.Entity<Puesto>(entity =>
        {
            entity.HasKey(e => e.IdPuesto).HasName("PK__Puesto__ADAC6B9CCDC4785D");

            entity.ToTable("Puesto");

            entity.Property(e => e.DescripcionTareas)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Rol>(entity =>
        {
            entity.HasKey(e => e.IdRol).HasName("PK__Rol__2A49584CA11DB2EF");

            entity.ToTable("Rol");

            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("nombre");
        });

        modelBuilder.Entity<RolUsario>(entity =>
        {
            entity.HasKey(e => e.IdRolUsario).HasName("PK__RolUsari__F11979EA41CDC187");

            entity.ToTable("RolUsario");

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.RolUsarios)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsario_IdEmpleado");

            entity.HasOne(d => d.IdRolNavigation).WithMany(p => p.RolUsarios)
                .HasForeignKey(d => d.IdRol)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolUsario_IdRol");
        });

        modelBuilder.Entity<Tarea>(entity =>
        {
            entity.HasKey(e => e.IdTareas).HasName("PK__Tareas__61D0EF21D628C580");

            entity.Property(e => e.Descripcion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.Tareas)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Tareas_IdEmpleado");
        });

        modelBuilder.Entity<TareasEstadosTarea>(entity =>
        {
            entity.HasKey(e => e.IdTareasEstadosTareas).HasName("PK__TareasEs__71C977B54DBAC1FD");

            entity.HasOne(d => d.IdEstadoTareaNavigation).WithMany(p => p.TareasEstadosTareas)
                .HasForeignKey(d => d.IdEstadoTarea)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasEstadosTareas_IdEstadoTarea");

            entity.HasOne(d => d.IdTareasNavigation).WithMany(p => p.TareasEstadosTareas)
                .HasForeignKey(d => d.IdTareas)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_TareasEstadosTareas_IdTareas");
        });

        modelBuilder.Entity<TipoHabitacion>(entity =>
        {
            entity.HasKey(e => e.IdTipoHabitacion).HasName("PK__TipoHabi__AB75E87C022C20D0");

            entity.ToTable("TipoHabitacion");

            entity.Property(e => e.NombreTh)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("NombreTH");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.HasKey(e => e.IdUsuario).HasName("PK__Usuario__5B65BF97C64A6F60");

            entity.ToTable("Usuario");

            entity.Property(e => e.Contraseña)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.IdEmpleadoNavigation).WithMany(p => p.Usuarios)
                .HasForeignKey(d => d.IdEmpleado)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Usuario_IdEmpleado");
        });

        modelBuilder.Entity<Venta>(entity =>
        {
            entity.HasKey(e => e.IdVenta).HasName("PK__Ventas__BC1240BDBEC045BE");

            entity.HasOne(d => d.IdVisitanteNavigation).WithMany(p => p.Venta)
                .HasForeignKey(d => d.IdVisitante)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Ventas_IdVisitante");
        });

        modelBuilder.Entity<Visitante>(entity =>
        {
            entity.HasKey(e => e.IdVisitante).HasName("PK__Visitant__696F3E9F7F31A267");

            entity.ToTable("Visitante");

            entity.Property(e => e.Apellido1)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Apellido2)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Nombre)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Tipo)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Zoo>(entity =>
        {
            entity.HasKey(e => e.IdZoo).HasName("PK__ZOO__283998DB4675896C");

            entity.ToTable("ZOO");

            entity.Property(e => e.DescripcionZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Direccion)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.NombreZoo)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
