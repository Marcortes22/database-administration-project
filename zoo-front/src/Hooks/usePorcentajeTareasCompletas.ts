// Hooks/usePorcentajeTareasCompletadasPorTipo.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { PorcentajeTareasCompletadasPorTipo } from '@/Types/next-auth-types/PorcentajeTareasCompletas';

export const usePorcentajeTareasCompletadasPorTipo = () => {
  const [data, setData] = useState<PorcentajeTareasCompletadasPorTipo[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  const getToken = () => {
    const token = session?.user?.access_token;
    if (token) {
      localStorage.setItem('access_token', token);
      return token;
    }
    return localStorage.getItem('access_token');
  };

  useEffect(() => {
    const fetchPorcentajeTareasCompletadasPorTipo = async () => {
      const token = getToken();

      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/TareasReportes/PorcentajeTareasCompletadasPorTipo', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener el reporte de porcentaje de tareas completadas por tipo');
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

    fetchPorcentajeTareasCompletadasPorTipo();
  }, [session]);

  return { data, loading, error };
};
