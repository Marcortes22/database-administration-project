using Entities;
using Services.genericResponse;
using Services.MetodoPagoService.Dto;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.MetodoPagoService
{
    public interface ISvMetodoPago
    {
        Task<BaseResponse<List<VwMetodoPago>>> GetAll();
        //Task<BaseResponse<MetodoPago>> GetById(int id);
        Task<BaseResponse<MetodoPago>> Create(MetodoPagoCreateDto  metodoPagoCreateDto, int cedulaCreador);
        Task<BaseResponse<MetodoPago>> Update(int id, MetodoPagoUpdateDto metodoPagoUpdateDto, int cedulaCreador);
        Task<BaseResponse<MetodoPago>> Delete(int id, int cedulaCreador);
    }
}
