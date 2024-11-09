// Hooks/useMantenimientoHabitacionTareas.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { useSession } from 'next-auth/react';
import { MantenimientoHabitacionTarea } from '@/Types/next-auth-types/MantenimientoHabitacion';
import toast from 'react-hot-toast';

export function useMantenimientoHabitacionTareas() {
  const [tareas, setTareas] = useState<MantenimientoHabitacionTarea[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  useEffect(() => {
    const fetchTareas = async () => {
      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await axios.get('http://localhost:5153/api/Tareas/mantenimiento', {
          headers: {
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        setTareas(response.data.data);
      } catch (error) {
        setError('Error al cargar las tareas de mantenimiento de habitación.');
      } finally {
        setLoading(false);
      }
    };

    fetchTareas();
  }, [session]);

  return { tareas, loading, error };
}
