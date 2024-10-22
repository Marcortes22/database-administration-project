// hooks/useHabitaciones.ts
'use client';

import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react'; // Para manejar la sesión y token
import { Habitacion } from '@/Types/next-auth-types/Habitacion';


export const useHabitaciones = () => {
  const [habitaciones, setHabitaciones] = useState<Habitacion[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<null | string>(null);

  const { data: session } = useSession(); // Obtén la sesión para usar el token

  useEffect(() => {
    const fetchHabitaciones = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Habitacion', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`, // Envía el token
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener las habitaciones');
        }

        const result = await response.json();
        setHabitaciones(result.data); // Ajustamos para obtener solo `data`
      } catch (error) {
        setError('Error al obtener las habitaciones');
      } finally {
        setLoading(false);
      }
    };

    if (session) {
      fetchHabitaciones(); // Llamada a la API solo si la sesión está disponible
    }
  }, [session]); // Ejecuta cuando cambie la sesión

  return { habitaciones, loading, error };
};
