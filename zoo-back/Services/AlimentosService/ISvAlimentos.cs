using Entities;
using Services.AlimentosService.Dto;
using Services.EstadoSaludService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AlimentosService
{
    public interface ISvAlimentos
    {
        Task<BaseResponse<List<VwAlimento>>> GetAll();
        Task<BaseResponse<VwAlimento>> GetById(int id);
        Task<BaseResponse<Alimento>> Create(AlimentosCreateDto alimentosCreateDto, int cedulaCreador);
        Task<BaseResponse<Alimento>> Update(int id, AlimentosUpdateDto alimentosUpdateDto, int cedulaCreador);
        Task<BaseResponse<Alimento>> Delete(int id, int cedulaCreador);
    }
}
