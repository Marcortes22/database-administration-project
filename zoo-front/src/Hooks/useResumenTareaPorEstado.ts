// Hooks/useResumenTareasPorEstado.ts
'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { ResumenTareasPorEstado } from '@/Types/next-auth-types/ResumenTareaPorEstado';

export const useResumenTareasPorEstado = () => {
  const [data, setData] = useState<ResumenTareasPorEstado[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchResumenTareasPorEstado = async () => {
      const token = session?.user?.access_token;
      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/TareasReportes/ResumenTareasPorEstado', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener el resumen de tareas por estado');

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

    fetchResumenTareasPorEstado();
  }, [session]);

  return { data, loading, error };
};