using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.CalificacionVisitaService.Dto;
using Services.genericResponse;
using Services.MetodoPagoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.CalificacionVisitaService
{
    public class SvCalificacionVisita : ISvCalificacionVisita
    {
        private readonly ZooMaContext myDbContext;

        public SvCalificacionVisita(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<CalificacionVisitum>> Create(CalificacionVisitaCreateDto calificacionVisitaCreateDto, int cedulaCreador)
        {
            try
            {
                Console.WriteLine(calificacionVisitaCreateDto.IdVentaEntrada);
                var IdVentaEntrada = new SqlParameter("@IdVentaEntrada", calificacionVisitaCreateDto.IdVentaEntrada);
                var NotaRecorrido = new SqlParameter("@NotaRecorrido", calificacionVisitaCreateDto.NotaRecorrido);
                var SugerenciaMejoraRecorrido = new SqlParameter("@SugerenciaMejoraRecorrido", calificacionVisitaCreateDto.SugerenciaMejoraRecorrido);
                var NotaServicioAlCliente = new SqlParameter("@NotaServicioAlCliente", calificacionVisitaCreateDto.NotaServicioAlCliente);
                var SugerenciaMejoraServicioAlCliente = new SqlParameter("@SugerenciaMejoraServicioAlCliente", calificacionVisitaCreateDto.SugerenciaMejoraServicioAlCliente);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_CREAR_CALIFICACION_VISITA @NotaRecorrido,@IdVentaEntrada,@SugerenciaMejoraRecorrido,@NotaServicioAlCliente,@SugerenciaMejoraServicioAlCliente ,@Cedula ",
                    IdVentaEntrada, NotaRecorrido, SugerenciaMejoraRecorrido, NotaServicioAlCliente, SugerenciaMejoraServicioAlCliente, cedula
                );

                return new BaseResponse<CalificacionVisitum>(default, true, "Calificacion visita creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<CalificacionVisitum>(default, false, err.Message);
            }
        }
    }
}
