'use client';
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { Visitante } from '@/Types/next-auth-types/Visitante';

export const useVisitantes = () => {
  const { data: session } = useSession();
  const [visitantes, setVisitantes] = useState<Visitante[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchVisitantes = async () => {
      try {
        const res = await fetch('http://localhost:5153/api/Visitante', {
          headers: {
            Authorization: `Bearer ${session?.user?.access_token}`,
          },
        });

        const data = await res.json();
        setVisitantes(data.data);
      } catch {
        setError('Error al cargar visitantes');
      } finally {
        setLoading(false);
      }
    };
    if (session) {
        fetchVisitantes();
    }
  }, [session]);

  return { visitantes, loading, error };
};
