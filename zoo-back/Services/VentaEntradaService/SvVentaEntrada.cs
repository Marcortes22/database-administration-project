using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EntradaService.Dto;
using Services.genericResponse;
using Services.VentaEntradaService.Dto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VentaEntradaService
{
    public class SvVentaEntrada: ISvVentaEntrada
    {

        private readonly ZooMaContext myDbContext;

        public SvVentaEntrada(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<VentaEntradum>> Create(VentaCreateDto ventaCreateDto, int cedulaCreador)
        {
            try
            {
                var IdVisitantes = new SqlParameter("@IdVisitantes", ventaCreateDto.IdVisitantes);
                var IdMetodoPago = new SqlParameter("@IdMetodoPago", ventaCreateDto.IdMetodoPago);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                //var DetalleVentaTableType = new SqlParameter("@DetalleVentaTableType", ventaCreateDto.Detalles);

                //DetalleVentaTableType.SqlDbType = SqlDbType.Structured;


                // Crear el DataTable para los detalles de venta
                DataTable detalleVentaTable = new DataTable();
                detalleVentaTable.Columns.Add("IdEntrada", typeof(int)); // Columna para IdEntrada
                detalleVentaTable.Columns.Add("Cantidad", typeof(int));  // Columna para Cantidad

                // Llenar el DataTable con los detalles
                foreach (var detalle in ventaCreateDto.Detalles)
                {
                    detalleVentaTable.Rows.Add(detalle.IdEntrada, detalle.Cantidad);
                }

                // Crear el parámetro para el tipo de tabla
                var DetalleVentaTableType = new SqlParameter("@DetalleVentaTableType", detalleVentaTable);
                DetalleVentaTableType.TypeName = "dbo.DetalleVentaTableType";
                DetalleVentaTableType.SqlDbType = SqlDbType.Structured;


                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_EJECUTAR_VENTA @IdVisitantes,@IdMetodoPago, @Cedula, @DetalleVentaTableType",
                     IdVisitantes, IdMetodoPago, cedula, DetalleVentaTableType
                 );


                return new BaseResponse<VentaEntradum>(default, true, "Entrada vendida exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<VentaEntradum>(default, false, ex.Message);
            }
        }
    }
}
