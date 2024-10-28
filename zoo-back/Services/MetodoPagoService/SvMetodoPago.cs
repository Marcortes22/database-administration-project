using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
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
    public class SvMetodoPago : ISvMetodoPago
    {
        private readonly ZooMaContext myDbContext;

        public SvMetodoPago(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<MetodoPago>> Create(MetodoPagoCreateDto metodoPagoCreateDto, int cedulaCreador)
        {
            try
            {
                var metodoPago = new SqlParameter("@Metodopago", metodoPagoCreateDto.Metodopago);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_METODO_PAGO @Metodopago,@Cedula ",
                    metodoPago, cedula
                );

                return new BaseResponse<MetodoPago>(default, true, "Metodo de pago creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<MetodoPago>(default, false, err.Message);
            }
            
        }

        public async Task<BaseResponse<MetodoPago>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdMetodoPago = new SqlParameter("@IdMetodoPago", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_METODO_PAGO @IdMetodoPago, @Cedula",
                    IdMetodoPago, cedula
                );

                return new BaseResponse<MetodoPago>(default, true, "Metodo de pago eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<MetodoPago>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwMetodoPago>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwMetodoPagos.ToListAsync();

                return new BaseResponse<List<VwMetodoPago>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwMetodoPago>>(default, false, err.Message);
            }
        }

       

        public async Task<BaseResponse<MetodoPago>> Update(int id, MetodoPagoUpdateDto metodoPagoUpdateDto, int cedulaCreador)
        {

            try
            {
                var IdMetodoPago = new SqlParameter("@IdMetodoPago", id);
                var Metodopago = new SqlParameter("@Metodopago", metodoPagoUpdateDto.Metodopago);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);



                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_METODO_PAGO @IdMetodoPago, @Metodopago, @Cedula",
                    IdMetodoPago, Metodopago, cedula
                );

                return new BaseResponse<MetodoPago>(default, true, "Metodo de pago actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<MetodoPago>(default, false, err.Message);
            }
        }
    }
}
