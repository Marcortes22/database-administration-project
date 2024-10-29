'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { EstadoSalud } from '@/Types/next-auth-types/EstadoSalud';
import toast from 'react-hot-toast';

export function useEstadoSalud() {
  const [estados, setEstados] = useState<EstadoSalud[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession();

  useEffect(() => {
    const fetchEstados = async () => {
      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/EstadoSalud', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener los estados de salud');

        const data = await response.json();
        setEstados(data.data);
      } catch (error) {
        toast.error('Error al obtener los estados de salud');
        setError('Error al obtener los estados de salud');
      } finally {
        setLoading(false);
      }
    };

    fetchEstados();
  }, [session]);

  return { estados, loading, error };
}
