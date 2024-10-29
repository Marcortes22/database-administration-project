'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { Especie } from '@/Types/next-auth-types/Especie';
import toast from 'react-hot-toast';

export function useEspecies() {
  const [especies, setEspecies] = useState<Especie[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession();

  useEffect(() => {
    const fetchEspecies = async () => {
      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Especie', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener las especies');

        const data = await response.json();
        setEspecies(data.data);
      } catch (error) {
        toast.error('Error al obtener las especies');
        setError('Error al obtener las especies');
      } finally {
        setLoading(false);
      }
    };

    fetchEspecies();
  }, [session]);

  return { especies, loading, error };
}
