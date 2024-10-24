// types.ts
export interface DetalleVenta {
    idEntrada: number;
    cantidad: number;
  }
  
  export interface VentaEntrada {
    idVisitantes: number;
    idMetodoPago: number;
    detalles: DetalleVenta[];
  }
  