using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Services.genericResponse;
using Services.PuestoService.Dto;


namespace Services.PuestoService
{
    public interface ISvPuesto
    {
        Task<BaseResponse<List<VwPuesto>>> GetAll();
        Task<BaseResponse<Puesto>> GetById(int id);
        Task<BaseResponse<Puesto>> Create(PuestoCreateDto puestoCreateDto, int cedulaCreador);
        Task<BaseResponse<Puesto>> Update(int id, PuestoUpdateDto puestoUpdateDto, int cedulaCreador);
        Task<BaseResponse<Puesto>> Delete(int id, int cedulaCreador);

    }
}
