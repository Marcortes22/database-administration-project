using Entities;
using Services.genericResponse;
using Services.PuestoService.Dto;
using Services.VisitanteService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VisitanteService
{
    public interface ISvVisitante
    {
        Task<BaseResponse<List<VwVisitante>>> GetAll();
        Task<BaseResponse<VwVisitante>> GetById(int id);
        Task<BaseResponse<Visitante>> Create(VisitanteCreateDto visitanteCreateDto, int cedulaCreador);
        Task<BaseResponse<Visitante>> Update(int id, VisitanteUpdateDto visitanteUpdateDto, int cedulaCreador);
        Task<BaseResponse<Visitante>> Delete(int id, int cedulaCreador);
    }
}
