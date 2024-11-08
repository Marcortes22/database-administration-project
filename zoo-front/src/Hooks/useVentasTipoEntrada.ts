// Hooks/useVentasPorTipoEntrada.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { VentasPorTipoEntrada } from '@/Types/next-auth-types/VentasPorTipoEntrada';

export const useVentasPorTipoEntrada = () => {
  const [data, setData] = useState<VentasPorTipoEntrada[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchVentasPorTipoEntrada = async () => {
      const token = session?.user?.access_token;
      if (!token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/VentasPorTipoEntrada', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener el reporte de ventas por tipo de entrada');

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

    fetchVentasPorTipoEntrada();
  }, [session]);

  return { data, loading, error };
};
