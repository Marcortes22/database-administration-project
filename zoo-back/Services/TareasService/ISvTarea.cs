using Entities;
using Services.genericResponse;
using Services.TareasService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TareasService
{
    public interface ISvTarea
    {
        Task<BaseResponse<List<VwTareasControlAnimal>>> GetAllControlAnimal();
        Task<BaseResponse<List<VwTareasMantenimiento>>> GetAllMantenimiento();
        Task<BaseResponse<List<VwTareasMantenimiento>>> GetTasksControlAnimalByEmpleadoId(int id);
        Task<BaseResponse<List<VwTareasControlAnimal>>> GetTasksMantenimientoByEmpleadoId(int id);
        Task<BaseResponse<Tarea>> AtualizarEstado(ChangeTaskStateDto cambiarEstadoTareaDto,int cedulaCreador);


    }
}
