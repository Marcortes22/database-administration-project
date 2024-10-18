using Entities;
using Services.EmpleadoService.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EmpleadoService
{
    public class SvEmpleado : ISvEmpleado
    {
        public Task<BaseResponse<Empleado>> Create(EmpleadoCreateDto CreateEmpleado)
        {
            throw new NotImplementedException();
        }

        public Task<BaseResponse<Empleado>> Delete(int id)
        {
            throw new NotImplementedException();
        }

        public Task<BaseResponse<List<Empleado>>> GetAll()
        {
            throw new NotImplementedException();
        }

        public Task<BaseResponse<Empleado>> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public Task<BaseResponse<Empleado>> Update(int id, EmpleadoUpdateDto UpdateEmpleado)
        {
            throw new NotImplementedException();
        }
    }
}
