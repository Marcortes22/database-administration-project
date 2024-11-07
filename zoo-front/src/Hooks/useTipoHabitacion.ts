// hooks/useTiposHabitacion.ts

'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { TipoHabitacion } from '@/Types/next-auth-types/TipoHabitacion';

export const useTiposHabitacion = () => {
  const [tiposHabitacion, setTiposHabitacion] = useState<TipoHabitacion[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();
  const [isClient, setIsClient] = useState(false);

  // Verifica si está en el cliente
  useEffect(() => {
    setIsClient(true);
  }, []);

  // Obtén el token desde la sesión o el localStorage
  const getToken = () => {
    const token = session?.user?.access_token;
    if (token) {
      if (isClient) localStorage.setItem('access_token', token); // Guarda el token en localStorage si estamos en el cliente
      return token;
    }
    return isClient ? localStorage.getItem('access_token') : null; // Recupera el token de localStorage si existe y estamos en el cliente
  };

  useEffect(() => {
    const fetchTiposHabitacion = async () => {
      const token = getToken();
      if (!token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const res = await fetch('http://localhost:5153/api/TipoHabitacion', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`,
          },
        });

        if (!res.ok) throw new Error('Error al obtener los tipos de habitación');

        const data = await res.json();
        setTiposHabitacion(data.data);
      } catch (error) {
        setError('Error al obtener los tipos de habitación');
      } finally {
        setLoading(false);
      }
    };

    // Ejecuta la función solo si estamos en el cliente
    if (isClient) fetchTiposHabitacion();
  }, [session, isClient]);

  // Elimina el token del localStorage cuando la sesión se cierre
  useEffect(() => {
    if (!session && isClient) {
      localStorage.removeItem('access_token');
    }
  }, [session, isClient]);

  return { tiposHabitacion, loading, error };
};
