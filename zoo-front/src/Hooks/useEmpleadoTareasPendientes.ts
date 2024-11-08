// Hooks/useEmpleadosTareasPendientes.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { EmpleadoTareaPendiente } from '@/Types/next-auth-types/EmpleadoTareasPendientes';

export const useEmpleadosTareasPendientes = () => {
  const [data, setData] = useState<EmpleadoTareaPendiente[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();
  const [isClient, setIsClient] = useState(false);

  useEffect(() => {
    setIsClient(true);
  }, []);

  const getToken = () => {
    const token = session?.user?.access_token;
    if (token) {
      if (isClient) localStorage.setItem('access_token', token);
      return token;
    }
    return isClient ? localStorage.getItem('access_token') : null;
  };

  useEffect(() => {
    const fetchEmpleadosTareasPendientes = async () => {
      const token = getToken();

      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/TareasReportes/EmpleadosTareasPendientes', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener el reporte de tareas pendientes');
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

    if (isClient) fetchEmpleadosTareasPendientes();
  }, [session, isClient]);

  useEffect(() => {
    if (!session && isClient) {
      localStorage.removeItem('access_token');
    }
  }, [session, isClient]);

  return { data, loading, error };
};
