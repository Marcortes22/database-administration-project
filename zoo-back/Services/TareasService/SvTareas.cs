using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.MantenimientoHabService.Dto;
using Services.TareasService.Dto;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TareasService
{
    public class SvTareas : ISvTarea
    {

        private readonly ZooMaContext myDbContext;

        public SvTareas(ZooMaContext context)
        {
            myDbContext = context;
        }

        public async Task<BaseResponse<Tarea>> AtualizarEstado(ChangeTaskStateDto cambiarEstadoTareaDto, int cedulaCreador)
        {
            try
            {
                var IdEstadoTarea = new SqlParameter("@IdEstadoTarea", cambiarEstadoTareaDto.IdEstadoTarea);
                var IdTarea = new SqlParameter("@IdTarea", cambiarEstadoTareaDto.IdTarea);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_ESTADO_TAREA @IdEstadoTarea,@IdTarea,@Cedula ",
                    IdEstadoTarea, IdTarea, cedula
                );

                return new BaseResponse<Tarea>(default, true, "Tarea actualizada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Tarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTareasControlAnimal>>> GetAllControlAnimal()
        {
            try
            {
                var data = myDbContext.VwTareasControlAnimals.ToList();

                return new BaseResponse<List<VwTareasControlAnimal>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTareasControlAnimal>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTareasMantenimiento>>> GetAllMantenimiento()
        {
            try
            {
                var data = myDbContext.VwTareasMantenimientos.ToList();

                return new BaseResponse<List<VwTareasMantenimiento>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTareasMantenimiento>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTareasMantenimiento>>> GetTasksControlAnimalByEmpleadoId(int id)
        {
            try
            {
                var data = myDbContext.VwTareasMantenimientos.Where(x => x.IdEmpleado == id).ToList();

                return new BaseResponse<List<VwTareasMantenimiento>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTareasMantenimiento>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTareasControlAnimal>>> GetTasksMantenimientoByEmpleadoId(int id)
        {
            try
            {
                var data = myDbContext.VwTareasControlAnimals.Where(x=>x.IdEmpleado == id).ToList();

                return new BaseResponse<List<VwTareasControlAnimal>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTareasControlAnimal>>(default, false, err.Message);
            }
        }
    }
}
