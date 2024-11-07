// Hooks/useEntradasVendidas.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { EntradasVendidas } from '@/Types/next-auth-types/EntradasVendidad';

export const useEntradasVendidas = () => {
  const [data, setData] = useState<EntradasVendidas | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchEntradasVendidas = async () => {
      const token = session?.user?.access_token;
      if (!token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/EntradasVendidas', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener el reporte de entradas vendidas');

        const result = await response.json();
        if (result.success) {
          setData(result.data[0]);
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

    fetchEntradasVendidas();
  }, [session]);

  return { data, loading, error };
};
