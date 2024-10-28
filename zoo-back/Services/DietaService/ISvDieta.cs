using Entities;
using Services.DietaService.Dto;
using Services.genericResponse;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.DietaService
{
    public interface ISvDieta
    {
        Task<BaseResponse<List<VwDietum>>> GetAll();
        Task<BaseResponse<VwDietum>> GetById(int id);
        Task<BaseResponse<Dietum>> Create(DietaCreateDto dietaCreateDto, int cedulaCreador);
        Task<BaseResponse<Dietum>> Update(int id, DietaUpdateDto dietaUpdateDto, int cedulaCreador);
        Task<BaseResponse<Dietum>> Delete(int id, int cedulaCreador);
    }
}
