using Entities;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using Services.TipoTareaService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoTareaService
{
    public interface ISvTipoTarea
    {
        Task<BaseResponse<List<VwTipoTarea>>> GetAll();
        Task<BaseResponse<VwTipoTarea>> GetById(int id);
        Task<BaseResponse<TipoTarea>> Create(TipoTareaCreateDto tipoTareaCreateDto, int cedulaCreador);
        Task<BaseResponse<TipoTarea>> Update(int id, TipoTareaUpdateDto tipoTareaUpdateDto, int cedulaCreador);
        Task<BaseResponse<TipoTarea>> Delete(int id, int cedulaCreador);
    }
}
