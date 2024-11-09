using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.DietaService.Dto;
using Services.EspecieServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.DietaService
{
    public class SvDieta : ISvDieta
    {

        private readonly ZooMaContext myDbContext;

        public SvDieta(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Dietum>> Create(DietaCreateDto dietaCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreDiet = new SqlParameter("@NombreDiet", dietaCreateDto.NombreDiet);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                DataTable alimentosTable = new DataTable();
                alimentosTable.Columns.Add("IdAlimento", typeof(int)); //
                alimentosTable.Columns.Add("Cantidad", typeof(Decimal)); //


                foreach (var alimento in dietaCreateDto.Alimentos)
                {
                    alimentosTable.Rows.Add(alimento.IdAlimento, alimento.Cantidad);
             
                }

                var AlimentosTableType = new SqlParameter("@Alimentos", alimentosTable);
                AlimentosTableType.TypeName = "dbo.AlimentosDeDietaTableType";
                AlimentosTableType.SqlDbType = SqlDbType.Structured;

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_DIETA @NombreDiet,@Cedula, @Alimentos ",
                    NombreDiet, cedula, AlimentosTableType
                );

                return new BaseResponse<Dietum>(default, true, "Dieta creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Dietum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Dietum>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdDieta = new SqlParameter("@IdDieta", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Dieta @IdDieta, @Cedula",
                    IdDieta, cedula
                );

                return new BaseResponse<Dietum>(default, true, "Dieta eliminada exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Dietum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwDietum>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwDieta.ToListAsync();

                return new BaseResponse<List<VwDietum>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwDietum>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwDietum>> GetById(int id)
        {
            try
            {
                var data = await  myDbContext.VwDieta.FirstOrDefaultAsync(x => x.IdDieta == id);

                return new BaseResponse<VwDietum>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwDietum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Dietum>> Update(int id, DietaUpdateDto dietaUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdDieta = new SqlParameter("@IdDieta", id);
                var NombreDiet = new SqlParameter("@NombreDiet", dietaUpdateDto.NombreDiet);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_Dieta @IdDieta, @NombreDiet,@Cedula ",
                    IdDieta, NombreDiet, cedula
                );

                return new BaseResponse<Dietum>(default, true, "Dieta actualizada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Dietum>(default, false, err.Message);
            }
        }
    }
}
