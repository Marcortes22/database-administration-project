


using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Services;
using Services.HabitacionService;
using Services.PuestoService;
using Services.RolService;
using Services.TipoHabitacionService;
using Services.ZooService;
using System.Text;
using Services.Auth;
using Microsoft.OpenApi.Models;
using Services.MetodoPagoService;
using Services.VisitanteService;
using Services.TipoEntradaService;
using Services.EmpleadoService;
using Services.EntradaService;
using Services.VentaEntradaService;
using Services.EspecieServices;
using Services.EstadoSaludService;
using Services.AlimentosService;
using Services.DietaService;
using Services.EstadoTareaServices;
using Services.TipoTareaService;
using Services.EstadoHabitacionService;
using Services.AnimalService;
using Services.ControlAnimalService;
using Services.MantenimientoHabService;
using Services.TareasService;
using Services.CalificacionVisitaService;
using Services.ReportesServices;
using Services.VentasReportesService;
using Services.CalificacionVisitaReportes;
using Services.AlimentoReportesService;



var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers().AddNewtonsoftJson(x =>
 x.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);

builder.Services.AddDbContext<ZooMaContext>(options =>
            options.UseSqlServer("Data Source=localhost;Initial Catalog=ZooMA;Integrated Security=True;TrustServerCertificate=True;"));


builder.Services.AddScoped<ISvHabitacion, SvHabitacion>();
builder.Services.AddScoped<ISvPuesto, SvPuesto>();
builder.Services.AddScoped<ISvTipoHabitacion, SvTipoHabitacion>();
builder.Services.AddScoped<ISvZoo, SvZoo>();
builder.Services.AddScoped<ISvRole, SvRole>();
builder.Services.AddScoped<ISvAuth, SvAuth>();
builder.Services.AddScoped<ISvMetodoPago, SvMetodoPago>();
builder.Services.AddScoped<ISvVisitante, SvVisitante>();
builder.Services.AddScoped<ISvTipoEntrada, SvTipoEntrada>();
builder.Services.AddScoped<ISvEmpleado, SvEmpleado>();
builder.Services.AddScoped<ISvEntrada, SvEntrada>();
builder.Services.AddScoped<ISvVentaEntrada, SvVentaEntrada>();
builder.Services.AddScoped<ISvEspecie, SvEspecie>();
builder.Services.AddScoped<ISvEstadoSalud, SvEstadoSalud>();
builder.Services.AddScoped<ISvAlimentos, SvAlimentos>();
builder.Services.AddScoped<ISvDieta, SvDieta>();
builder.Services.AddScoped<ISvEstadoTarea, SvEstadoTarea>();
builder.Services.AddScoped<ISvTipoTarea, SvTipoTarea>();
builder.Services.AddScoped<ISvEstadoHabitacion, SvEstadoHabitacion>();
builder.Services.AddScoped<ISvAnimal, SvAnimal>();
builder.Services.AddScoped<ISvControlAnimal, SvControlAnimal>();
builder.Services.AddScoped<ISvMantenimientoHab, SvMantenimientoHab>();
builder.Services.AddScoped<ISvTarea, SvTareas>();
builder.Services.AddScoped<ISvCalificacionVisita, SvCalificacionVisita>();
builder.Services.AddScoped<ISvTareasReportes, SvTareasReportes>();
builder.Services.AddScoped<ISvVentasReportes, SvVentaReportes>();
builder.Services.AddScoped<ISvCalificacionReporte, SvCalificacionReporte>();
builder.Services.AddScoped<ISvAlimentoReporte, SvAlimentoReporte>();

builder.Services.AddCors(options => {
    options.AddPolicy("ReactApp", policyBuilder =>
    {
        policyBuilder.AllowAnyOrigin();  // Permite cualquier origen temporalmente para depuración
        policyBuilder.AllowAnyHeader();
        policyBuilder.AllowAnyMethod();
    });
});


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Demo API", Version = "v1" });
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
    });
});


builder.Services.AddAuthentication(cfg => {
    cfg.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    cfg.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    cfg.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(x => {
    x.RequireHttpsMetadata = false;
    x.SaveToken = false;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(
            Encoding.UTF8
            .GetBytes(builder.Configuration.GetSection("ApplicationSettings:JWT_Secret").Value)
        ),
        ValidateIssuer = false,
        ValidateAudience = false,
        ClockSkew = TimeSpan.Zero,
        NameClaimType = "Name",
        RoleClaimType = "Role",
        
        
    };
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    //app.UseAuthentication(); 
    //app.UseAuthorization();  
}

app.UseCors("ReactApp");
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
