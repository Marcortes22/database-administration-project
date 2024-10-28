// hooks/useEntradas.ts
'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { Entrada } from '@/Types/next-auth-types/Entrada';

export const useEntradas = () => {
  const { data: session } = useSession(); // Obtener la sesión para acceder al token
  const [entradas, setEntradas] = useState<Entrada[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchEntradas = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Entrada', {
          method: 'GET',
          headers: {
            Authorization: `Bearer ${session.user.access_token}`,
            'Content-Type': 'application/json',
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener las entradas');
        }

        const result = await response.json();
        setEntradas(result.data); // Asignamos solo los datos
      } catch (err) {
        setError('Error al conectar con el servidor');
      } finally {
        setLoading(false);
      }
    };

    if (session) {
      fetchEntradas(); // Llamada a la API si la sesión está disponible
    }
  }, [session]);

  return { entradas, loading, error };
};
