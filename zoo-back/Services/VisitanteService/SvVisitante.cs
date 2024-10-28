using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.MetodoPagoService.Dto;
using Services.VisitanteService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VisitanteService
{
    public class SvVisitante : ISvVisitante
    {

        private readonly ZooMaContext myDbContext;

        public SvVisitante(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Visitante>> Create(VisitanteCreateDto visitanteCreateDto, int cedulaCreador)
        {
            try
            {
                var IdVisitantes = new SqlParameter("@IdVisitantes", visitanteCreateDto.IdVisitantes);
                var NombreVist = new SqlParameter("@NombreVist", visitanteCreateDto.NombreVist);
                var Apell1Vist = new SqlParameter("@Apell1Vist", visitanteCreateDto.Apell1Vist);
                var Apell2Vist = new SqlParameter("@Apell2Vist", visitanteCreateDto.Apell2Vist);
                var Correo = new SqlParameter("@Correo", visitanteCreateDto.CorreoElectronico);
                var TELEFONO = new SqlParameter("@TELEFONO", visitanteCreateDto.Telefono);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_VISITANTE @IdVisitantes, @NombreVist, @Apell1Vist, @Apell2Vist, @Correo, @TELEFONO, @Cedula",
                    IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, Correo, TELEFONO, cedula
                );

                return new BaseResponse<Visitante>(default, true, "Visitante creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Visitante>(default, false, err.Message);
            }
           
        }

        public async Task<BaseResponse<Visitante>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdVisitantes = new SqlParameter("@IdVisitantes", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Visitante @IdVisitantes, @Cedula",
                    IdVisitantes, cedula
                );

                return new BaseResponse<Visitante>(default, true, "Visitante eliminado exitosamente");

            }catch (Exception err)
            {
                return new BaseResponse<Visitante>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVisitante>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwVisitantes.ToListAsync();

                return new BaseResponse<List<VwVisitante>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVisitante>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwVisitante>> GetById(int id)
        {
            try
            {
                var data =  myDbContext.VwVisitantes.FirstOrDefault(x=> x.IdVisitantes == id);

                return new BaseResponse<VwVisitante>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwVisitante>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Visitante>> Update(int id, VisitanteUpdateDto visitanteUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdVisitantes = new SqlParameter("@IdVisitantes", id);
                var NombreVist = new SqlParameter("@NombreVist", visitanteUpdateDto.NombreVist);
                var Apell1Vist = new SqlParameter("@Apell1Vist", visitanteUpdateDto.Apell1Vist);
                var Apell2Vist = new SqlParameter("@Apell2Vist", visitanteUpdateDto.Apell2Vist);
                var Correo = new SqlParameter("@Correo", visitanteUpdateDto.CorreoElectronico);
                var TELEFONO = new SqlParameter("@TELEFONO", visitanteUpdateDto.Telefono);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_Visitante @IdVisitantes, @NombreVist, @Apell1Vist, @Apell2Vist, @Correo, @TELEFONO, @Cedula ",
                    IdVisitantes, NombreVist, Apell1Vist, Apell2Vist, Correo, TELEFONO, cedula
                );

                return new BaseResponse<Visitante>(default, true, "Visitante editado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Visitante>(default, false, err.Message);
            }
        }
    }
}
