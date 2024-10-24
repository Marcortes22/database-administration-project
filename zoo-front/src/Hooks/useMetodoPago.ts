'use client';
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { MetodoPago } from '@/Types/next-auth-types/MetodoPago';

export const useMetodosPago = () => {
  const { data: session } = useSession();
  const [metodosPago, setMetodosPago] = useState<MetodoPago[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchMetodosPago = async () => {
      try {
        const res = await fetch('http://localhost:5153/api/MetodoPago', {
          headers: {
            Authorization: `Bearer ${session?.user?.access_token}`,
          },
        });

        const data = await res.json();
        setMetodosPago(data.data);
      } catch {
        setError('Error al cargar métodos de pago');
      } finally {
        setLoading(false);
      }
    };
if (session) {
      fetchMetodosPago();
    }
  }, [session]);

  return { metodosPago, loading, error };
};
