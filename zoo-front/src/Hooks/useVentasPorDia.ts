// Hooks/useVentasPorDiaReport.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { VentasPorDiaReporte } from '@/Types/next-auth-types/VentasPorDia';

export const useVentasPorDiaReport = () => {
  const [data, setData] = useState<VentasPorDiaReporte[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();
  const [isClient, setIsClient] = useState(false);

  // Asegúrate de que el hook solo se ejecute en el cliente
  useEffect(() => {
    setIsClient(true);
  }, []);

  // Función para obtener el token, ya sea desde la sesión o desde localStorage
  const getToken = () => {
    const token = session?.user?.access_token;
    if (token) {
      if (isClient) localStorage.setItem('access_token', token); // Guarda el token en localStorage si estamos en el cliente
      return token;
    }
    return isClient ? localStorage.getItem('access_token') : null; // Recupera el token de localStorage si existe y estamos en el cliente
  };

  useEffect(() => {
    const fetchVentasPorDia = async () => {
      const token = getToken();

      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/VentasPorDia', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener el reporte de ventas por día');
        }

        const result = await response.json();
        if (result.success) {
          setData(result.data);
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

    // Ejecuta la función solo si estamos en el cliente y el token está disponible
    if (isClient) fetchVentasPorDia();
  }, [session, isClient]);

  // Elimina el token del localStorage cuando la sesión se cierre
  useEffect(() => {
    if (!session && isClient) {
      localStorage.removeItem('access_token');
    }
  }, [session, isClient]);

  return { data, loading, error };
};
