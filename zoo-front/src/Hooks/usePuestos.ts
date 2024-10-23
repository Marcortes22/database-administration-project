// hooks/usePuestos.ts
'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { Puesto } from '@/Types/next-auth-types/Puesto';

export const usePuestos = () => {
  const { data: session, status } = useSession(); // Usamos status para verificar el estado de la sesión
  const [puestos, setPuestos] = useState<Puesto[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchPuestos = async () => {
      if (status !== 'authenticated' || !session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const res = await fetch('http://localhost:5153/api/Puesto', {
          headers: {
            Authorization: `Bearer ${session.user.access_token}`, // Usamos el token
            'Content-Type': 'application/json',
          },
        });

        if (!res.ok) {
          throw new Error('Error al obtener los puestos');
        }

        const data = await res.json();
        setPuestos(data.data); // Ajustamos para acceder al array en `data`
      } catch (err: any) {
        setError(err.message || 'Error al obtener los datos');
      } finally {
        setLoading(false);
      }
    };

    if (status === 'authenticated') {
      fetchPuestos(); // Ejecutamos la solicitud solo si la sesión está autenticada
    }
  }, [session, status]); // Escuchamos los cambios en el estado de la sesión

  return { puestos, loading, error };
};
