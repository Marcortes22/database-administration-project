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
        Task<BaseResponse<List<Tarea>>> GetAll();
        Task<BaseResponse<Tarea>> GetTasksByEmpleadoId(int id);
        Task<BaseResponse<Tarea>> AtualizarEstado(ChangeTaskStateDto cambiarEstadoTareaDto,int cedulaCreador);


    }
}
