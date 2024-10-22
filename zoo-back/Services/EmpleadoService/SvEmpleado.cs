﻿using Entities;
using Microsoft.Data.SqlClient;
using Services.EmpleadoService.Dto;
using Services.genericResponse;
using Services.TipoHabitacionService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Services.EmpleadoService
{
    public class SvEmpleado : ISvEmpleado
    {
        private ZooMaContext myDbContext;

        public SvEmpleado(ZooMaContext context)
        {
            myDbContext = context;
        }
        public async Task<BaseResponse<Empleado>> Create(EmpleadoCreateDto CreateEmpleado)
        {

            var id = new SqlParameter("@EmpleadoId", CreateEmpleado.IdEmpleado);
            var nombre = new SqlParameter("@Nombre", CreateEmpleado.Nombre);
            var apell1 = new SqlParameter("@Apellido1", CreateEmpleado.Apellido1);
            var apell2 = new SqlParameter("@Apellido2", CreateEmpleado.Apellido2);
            var idPuesto = new SqlParameter("@@IdPuesto", CreateEmpleado.IdPuesto);
            var cedula = new SqlParameter("@Cedula", "504420108");
 
            return new BaseResponse<Empleado>(default, true, "Empleado creado exitosamente");
        }

        public async Task<BaseResponse<Empleado>> Delete(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<BaseResponse<List<VwEmpleado>>> GetAll()
        {
            throw new NotImplementedException();
        }

        public async Task<BaseResponse<Empleado>> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<BaseResponse<Empleado>> Update(int id, EmpleadoUpdateDto UpdateEmpleado)
        {
            throw new NotImplementedException();
        }
    }
}
