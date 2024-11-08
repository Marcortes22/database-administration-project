using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.MantenimientoHabService.Dto;
using Services.TareasService.Dto;
using System;
using System.Collections.Generic;
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

        public async Task<BaseResponse<List<Tarea>>> GetAll()
        {
            try
            {

                var data = myDbContext.Tareas
                   .Include(t => t.IdEmpleadoNavigation)  // Cargar empleado relacionado
        .Include(t => t.IdTipoTareaNavigation)  // Cargar tipo de tarea
        .Include(t => t.ControlAnimals)  // Cargar lista de ControlAnimal
        .Include(t => t.MantenimientoHabitacions)  // Cargar lista de MantenimientoHabitacion
        .Include(t => t.IdEstadoTareaNavigation)  // Cargar el estado de la tarea (1:1 opcional)
        .ToList();

                return new BaseResponse<List<Tarea>>(data, true, "");
            }
            catch (Exception ex)
            {
                return new BaseResponse<List<Tarea>>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<List<Tarea>>> GetTasksByEmpleadoId(int id)
        {
            try
            {
                var data = myDbContext.Tareas
           .Include(t => t.IdEmpleadoNavigation)  // Cargar empleado relacionado
           .Include(t => t.IdTipoTareaNavigation)  // Cargar tipo de tarea
           .Include(t => t.ControlAnimals)  // Cargar lista de ControlAnimal
           .Include(t => t.MantenimientoHabitacions)  // Cargar lista de MantenimientoHabitacion
           .Include(t => t.IdEstadoTareaNavigation)  // Cargar el estado de la tarea (1:1 opcional)
           .Where(t => t.IdEmpleado == id)
           .ToList();

                return new BaseResponse<List<Tarea>>(data, true, "");
            }
            catch (Exception ex)
            {
                return new BaseResponse<List<Tarea>>(default, false, ex.Message);
            }


        }
    }
}
