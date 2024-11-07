// Hooks/useEstadosHabitacion.ts
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { EstadoHabitacion } from '@/Types/EstadoHabitacion';

export const useEstadosHabitacion = () => {
  const [estados, setEstados] = useState<EstadoHabitacion[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchEstadosHabitacion = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/EstadoHabitacion', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener los estados de habitación');
        }

        const result = await response.json();
        if (result.success) {
          setEstados(result.data);
        } else {
          setError(result.message);
        }
      } catch (error) {
        setError('Error al conectar con el servidor');
        toast.error('Error al obtener los estados de habitación');
      } finally {
        setLoading(false);
      }
    };

    fetchEstadosHabitacion();
  }, [session]);

  return { estados, loading, error };
};
