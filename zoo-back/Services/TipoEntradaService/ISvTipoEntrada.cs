using Entities;
using Services.genericResponse;
using Services.TipoEntradaService.Dto;
using Services.VisitanteService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoEntradaService
{
    public interface ISvTipoEntrada
    {
        Task<BaseResponse<List<VwTipoEntradum>>> GetAll();
        Task<BaseResponse<VwTipoEntradum>> GetById(int id);
        Task<BaseResponse<TipoEntradum>> Create(TipoEntradaCreateDto tipoEntradaCreateDto, int cedulaCreador);
        Task<BaseResponse<TipoEntradum>> Update(int id, TipoEntradaUpdateDto tipoEntradaUpdateDto, int cedulaCreador);
        Task<BaseResponse<TipoEntradum>> Delete(int id, int cedulaCreador);
    }
}
