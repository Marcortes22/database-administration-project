using Entities;
using Services.EmpleadoService.Dto;
using Services.EntradaService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EntradaService
{
    public interface ISvEntrada
    {
        Task<BaseResponse<List<VwEntradasActiva>>> GetAll();
        Task<BaseResponse<VwEntradasActiva>> GetById(int id);
        Task<BaseResponse<Entradum>> Create(EntradaCreateDto entradaCreateDto, int cedulaCreador);
        Task<BaseResponse<Entradum>> Update(int id, EntradaUpdateDto entradaUpdateDto, int cedulaCreador);
        Task<BaseResponse<Entradum>> Delete(int id, int cedulaCreador);
    }
}
