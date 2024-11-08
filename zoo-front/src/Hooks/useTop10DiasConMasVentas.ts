// Hooks/useTop10DiasConMasVentas.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { Top10DiasConMasVentas } from '@/Types/next-auth-types/Top10DiasConMasVentas';

export const useTop10DiasConMasVentas = () => {
  const [data, setData] = useState<Top10DiasConMasVentas[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchTop10DiasConMasVentas = async () => {
      const token = session?.user?.access_token;
      if (!token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/Top10DiasConMasVentas', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener el reporte de los 10 días con más ventas');

        const result = await response.json();
        if (result.success) {
          setData(result.data);
        } else {
          toast.error(result.message || 'Error al obtener los datos');
        }
      } catch (error) {
        toast.error('Error al conectar con el servidor');
        setError('Error al obtener los datos');
      } finally {
        setLoading(false);
      }
    };

    fetchTop10DiasConMasVentas();
  }, [session]);

  return { data, loading, error };
};
