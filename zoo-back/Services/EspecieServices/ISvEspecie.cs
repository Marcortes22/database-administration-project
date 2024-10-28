using Entities;
using Services.EspecieServices.Dto;
using Services.genericResponse;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EspecieServices
{
    public interface ISvEspecie
    {

        Task<BaseResponse<List<VwEspecy>>> GetAll();
        Task<BaseResponse<VwEspecy>> GetById(int id);
        Task<BaseResponse<Especie>> Create(EspecieCreateDto especieCreateDto, int cedulaCreador);
        Task<BaseResponse<Especie>> Update(int id, EspecieUpdateDto EspecieUpdateDto, int cedulaCreador);
        Task<BaseResponse<Especie>> Delete(int id, int cedulaCreador);
    }
}
