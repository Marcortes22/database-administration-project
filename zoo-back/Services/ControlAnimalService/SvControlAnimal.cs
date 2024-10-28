using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.AnimalService.Dto;
using Services.ControlAnimalService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ControlAnimalService
{
    public class SvControlAnimal : ISvControlAnimal
    {
        private readonly ZooMaContext myDbContext;

        public SvControlAnimal(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<ControlAnimal>> newControlAnimalTask(CreateControlAnimalDto controlAnimalDto, int cedulaCreador)
        {
            try
            {
                var @IdEmpleado = new SqlParameter("@IdEmpleado", controlAnimalDto.IdEmpleado);
                var IdAnimales = new SqlParameter("@IdAnimales", controlAnimalDto.IdAnimales);
                var Nombre = new SqlParameter("@Nombre", controlAnimalDto.NombreTarea);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_AGREGAR_TAREA_CONTROL_ANIMAL @IdEmpleado,@IdAnimales,@Nombre ,@Cedula ",
                    IdEmpleado, IdAnimales, Nombre, cedula
                );

                return new BaseResponse<ControlAnimal>(default, true, "Tarea creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<ControlAnimal>(default, false, err.Message);
            }
        }
    }
}
