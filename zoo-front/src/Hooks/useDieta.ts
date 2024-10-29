'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { Dieta } from '@/Types/next-auth-types/Dieta';
import toast from 'react-hot-toast';

export function useDietas() {
  const [dietas, setDietas] = useState<Dieta[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession();

  useEffect(() => {
    const fetchDietas = async () => {
      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Dieta', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener las dietas');

        const data = await response.json();
        setDietas(data.data);
      } catch (error) {
        toast.error('Error al obtener las dietas');
        setError('Error al obtener las dietas');
      } finally {
        setLoading(false);
      }
    };

    fetchDietas();
  }, [session]);

  return { dietas, loading, error };
}
