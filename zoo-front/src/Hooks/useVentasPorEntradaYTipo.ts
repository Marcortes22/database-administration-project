// Hooks/useVentasPorEntradaYtipoReport.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { VentasPorEntradaYtipoReporte } from '@/Types/next-auth-types/VentasPorEntradaYTipo';

export const useVentasPorEntradaYtipoReport = () => {
  const [data, setData] = useState<VentasPorEntradaYtipoReporte[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchVentasPorEntradaYtipo = async () => {
      const token = session?.user?.access_token;

      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        toast.error('No se encontró el token de autenticación');
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/VentasReportes/VentasPorEntradaYtipo', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener el reporte de ventas por entrada y tipo');

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

    fetchVentasPorEntradaYtipo();
  }, [session]);

  return { data, loading, error };
};
