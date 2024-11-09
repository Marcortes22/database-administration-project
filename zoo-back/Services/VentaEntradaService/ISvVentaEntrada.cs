using Entities;
using Services.genericResponse;
using Services.VentaEntradaService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VentaEntradaService
{
    public interface ISvVentaEntrada
    {
        Task<BaseResponse<VentaEntradum>> Create(VentaCreateDto ventaCreateDto,  int cedulaCreador);

        Task<BaseResponse<List<VistaVentaSinCalificacione>>> GetAllVentasSinCalificaciones();
    }
}
