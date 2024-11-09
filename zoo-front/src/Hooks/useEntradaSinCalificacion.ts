import { useState, useEffect } from 'react';
import axios from 'axios';
import { useSession } from 'next-auth/react';
import { VentaEntradaSinCalificacion } from '@/Types/next-auth-types/VentaEntradaSinCalificacion';

export function useVentasSinCalificacion() {
  const { data: session } = useSession();
  const [ventasSinCalificacion, setVentasSinCalificacion] = useState<VentaEntradaSinCalificacion[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchVentasSinCalificacion = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await axios.get('http://localhost:5153/api/VentaEntrada/ventas-sin-calificaciones', {
          headers: {
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });
         // Formatear la fecha y hora
         const formattedData = response.data.data.map((venta: VentaEntradaSinCalificacion) => {
          const fecha = new Date(venta.fechaventa);
          return {
            ...venta,
            fecha: fecha.toLocaleDateString(), // Fecha formateada
            hora: fecha.toLocaleTimeString(),   // Hora formateada
          };
        });

        setVentasSinCalificacion(formattedData);
      } catch (error) {
        setError('Error al cargar las ventas sin calificación.');
      } finally {
        setLoading(false);
      }
    };

    fetchVentasSinCalificacion();
  }, [session]);

  return { ventasSinCalificacion, loading, error };
}
