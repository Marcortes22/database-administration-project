// hooks/useAlimentos.ts
'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react'; // Para manejar sesión y token

// Definición del tipo Alimento
interface Alimento {
  idAlimentos: number;
  nombre: string;
}

export const useAlimentos = () => {
  const { data: session } = useSession(); // Obtener sesión y token de autenticación
  const [alimentos, setAlimentos] = useState<Alimento[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchAlimentos = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Alimento', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`, // Token en los headers
          },
        });

        if (!response.ok) {
          if (response.status === 401) throw new Error('No autorizado');
          throw new Error('Error al obtener los alimentos');
        }

        const data = await response.json();
        setAlimentos(data.data); // Asumiendo que los datos están en `data.data`
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Error desconocido');
      } finally {
        setLoading(false);
      }
    };

    fetchAlimentos(); // Ejecutar la llamada a la API
  }, [session]);

  return { alimentos, loading, error };
};
