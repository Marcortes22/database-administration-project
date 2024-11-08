// Hooks/useTotalVentasReport.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { TotalVentasReporte } from '@/Types/next-auth-types/TotalVentasReporte';

export const useTotalVentasReport = () => {
  const [data, setData] = useState<TotalVentasReporte | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();
  const [isClient, setIsClient] = useState(false);

  // Verifica si está en el cliente
  useEffect(() => {
    setIsClient(true);
  }, []);

  // Obtén el token desde la sesión o el localStorage
  const getToken = () => {
    const token = session?.user?.access_token;
    if (token) {
      if (isClient) localStorage.setItem('access_token', token); // Guarda el token en localStorage si estamos en el cliente
      return token;
    }
    return isClient ? localStorage.getItem('access_token') : null; // Recupera el token de localStorage si existe y estamos en el cliente
  };

  useEffect(() => {
    const fetchTotalVentas = async () => {
      const token = getToken();

      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/TotalVentas', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener el reporte de ventas totales');
        }

        const result = await response.json();
        if (result.success) {
          setData(result.data[0]);
        } else {
          setError(result.message);
          toast.error(result.message);
        }
      } catch (error) {
        setError('Error al conectar con el servidor');
        toast.error('Error al conectar con el servidor');
      } finally {
        setLoading(false);
      }
    };

    // Ejecuta la función solo si estamos en el cliente
    if (isClient) fetchTotalVentas();
  }, [session, isClient]);

  // Elimina el token del localStorage cuando la sesión se cierre
  useEffect(() => {
    if (!session && isClient) {
      localStorage.removeItem('access_token');
    }
  }, [session, isClient]);

  return { data, loading, error };
};
