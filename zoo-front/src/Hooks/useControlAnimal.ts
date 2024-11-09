// Hooks/useControlAnimalTareas.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { useSession } from 'next-auth/react';
import { ControlAnimalTarea } from '@/Types/next-auth-types/ControlAnimal';
import toast from 'react-hot-toast';

export function useControlAnimalTareas() {
  const [tareas, setTareas] = useState<ControlAnimalTarea[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session, status } = useSession();

  useEffect(() => {
    const fetchTareas = async () => {
      if (status === 'loading') {
        // Espera a que la sesión esté completamente cargada
        return;
      }

      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        console.log('Token:', session.user.access_token); // Verificar si el token está disponible
        const response = await axios.get('http://localhost:5153/api/Tareas/controlAnimal', {
          headers: {
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        setTareas(response.data.data);
      } catch (error) {
        toast.error('Error al cargar las tareas de control animal');
        setError('Error al cargar las tareas de control animal.');
      } finally {
        setLoading(false);
      }
    };

    fetchTareas();
  }, [session, status]);

  return { tareas, loading, error };
}
