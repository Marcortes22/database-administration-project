'use client';
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { TipoEntrada } from '@/Types/next-auth-types/TipoEntrada';

export const useTiposEntrada = () => {
  const { data: session } = useSession();
  const [tiposEntrada, setTiposEntrada] = useState<TipoEntrada[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTiposEntrada = async () => {
      try {
        const res = await fetch('http://localhost:5153/api/TipoEntrada', {
          headers: {
            Authorization: `Bearer ${session?.user?.access_token}`,
          },
        });

        const data = await res.json();
        setTiposEntrada(data.data);
      } catch {
        setError('Error al cargar tipos de entrada');
      } finally {
        setLoading(false);
      }
    };
if (session) {
      fetchTiposEntrada();
    }
  }, [session]);

  return { tiposEntrada, loading, error };
};
