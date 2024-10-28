// hooks/useVentaEntradas.ts
import { useState } from 'react';
import toast from 'react-hot-toast';
import { useSession } from 'next-auth/react';
import { DetalleVenta, VentaEntrada } from '@/Types/next-auth-types/VentaEntrada';

export const useVentaEntradas = () => {
  const { data: session } = useSession();

  // Estados del formulario
  const [idVisitante, setIdVisitante] = useState<number | null>(null);
  const [idMetodoPago, setIdMetodoPago] = useState<number | null>(null);
  const [detalles, setDetalles] = useState<DetalleVenta[]>([
    { idEntrada: -1, cantidad: 1 }, // Valor inicial para evitar ID inválido
  ]);

  // Agregar un nuevo detalle
  const agregarDetalle = () => {
    setDetalles([...detalles, { idEntrada: -1, cantidad: 1 }]);
  };

  // Eliminar un detalle específico
  const eliminarDetalle = (index: number) => {
    setDetalles(detalles.filter((_, i) => i !== index));
  };

  // Manejar cambios en los detalles
  const handleDetalleChange = (
    index: number,
    field: keyof DetalleVenta,
    value: number
  ) => {
    const nuevosDetalles = [...detalles];
    nuevosDetalles[index] = {
      ...nuevosDetalles[index],
      [field]: value,
    };
    console.log('Detalles actualizados:', nuevosDetalles);
    setDetalles(nuevosDetalles);
  };

  // Enviar la venta a la API
  const realizarVenta = async () => {
// Construir el objeto de la venta
const venta: VentaEntrada = {
  idVisitantes: idVisitante ?? 0,
  idMetodoPago: idMetodoPago ?? 0,
  detalles: detalles.filter(
    (d) => d.idEntrada !== -1 && d.cantidad > 0
  ),
};

// Verificar si hay token de autenticación
console.log('Detalles a enviar:', venta.detalles);
console.log('ID Visitante:', idVisitante);
console.log('ID Método de Pago:', idMetodoPago);

if (!session?.user?.access_token) {
  toast.error('No se encontró el token de autenticación');
  return;
}

    console.log('Datos de la venta:', venta);

    // Validar campos del formulario
    if (
      !venta.idVisitantes ||
      !venta.idMetodoPago ||
      venta.detalles.length === 0
    ) {
      toast.error('Uno o más datos son inválidos o faltan.');
      return;
    }

    try {
      // Llamada a la API
      const response = await fetch('http://localhost:5153/api/VentaEntrada', {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(venta),
      });

      if (!response.ok) {
        throw new Error('Error al realizar la venta');
      }

      const result = await response.json();
      if (result.success) {
        console.log('Venta realizada correctamente:', venta);
        toast.success('Venta realizada con éxito');
        resetFormulario();
      } else {
        toast.error(result.message || 'Error en la venta');
      }
    } catch (error) {
      console.error('Error en la conexión con la API:', error);
      toast.error('Error al conectar con el servidor');
    }
  };

  // Resetear el formulario después de una venta exitosa
  const resetFormulario = () => {
    setIdVisitante(null);
    setIdMetodoPago(null);
    setDetalles([{ idEntrada: -1, cantidad: 1 }]);
  };

  // Retornar funciones y estados necesarios
  return {
    detalles,
    idVisitante,
    idMetodoPago,
    setIdVisitante,
    setIdMetodoPago,
    handleDetalleChange,
    agregarDetalle,
    eliminarDetalle,
    realizarVenta,
  };
};
