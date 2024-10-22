using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Services.genericResponse;
using Services.PuestoService.Dto;
using Services.ZooService.Dto;

namespace Services.ZooService
{
    public interface ISvZoo
    {

        Task<BaseResponse<Zoo>> GetById(int id);
        Task<BaseResponse<Zoo>> Create(ZooCreateDto zooCreateDto, int cedulaCreador);
        Task<BaseResponse<Zoo>> Update(int id, ZooUpdateDto zooUpdateDto, int cedulaCreador);
        Task<BaseResponse<Zoo>> Delete(int id, int cedulaCreador);
    }
}
