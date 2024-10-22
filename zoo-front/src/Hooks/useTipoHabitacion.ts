// hooks/useTiposHabitacion.ts

'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react'; // Para manejar el token de sesión
import { TipoHabitacion } from '@/Types/next-auth-types/TipoHabitacion';

export const useTiposHabitacion = () => {
  const [tiposHabitacion, setTiposHabitacion] = useState<TipoHabitacion[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession(); // Obtenemos la sesión

  useEffect(() => {
    const fetchTiposHabitacion = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const res = await fetch('http://localhost:5153/api/TipoHabitacion', { // Ajusta la URL si es necesario
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`, // Pasamos el token
          },
        });

        if (!res.ok) throw new Error('Error al obtener los tipos de habitación');

        const data = await res.json();
        setTiposHabitacion(data.data); // Guardamos solo la propiedad `data`
      } catch (error) {
        setError('Error al obtener los tipos de habitación');
      } finally {
        setLoading(false);
      }
    };

    fetchTiposHabitacion();
  }, [session]);

  return { tiposHabitacion, loading, error };
};
