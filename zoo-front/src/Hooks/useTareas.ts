// Hooks/useTareas.ts
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { Tarea } from '@/Types/next-auth-types/Tarea';

export function useTareas() {
  const [tareas, setTareas] = useState<Tarea[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  // Fetch todas las tareas
  const fetchTareas = async () => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      setLoading(false);
      return;
    }

    try {
      setLoading(true);
      const response = await fetch('http://localhost:5153/api/Tareas', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Error al obtener las tareas');
      }

      const result = await response.json();
      if (result.success) {
        setTareas(result.data);
      } else {
        setError(result.message);
      }
    } catch (error) {
      setError('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  // Actualizar el estado de una tarea
  const updateTaskState = async (id: number, idEstadoTarea: number) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Tareas/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify({ IdEstadoTarea: idEstadoTarea }),
      });

      if (!response.ok) throw new Error('Error al actualizar el estado de la tarea');

      const result = await response.json();
      toast.success('Estado de tarea actualizado exitosamente');

      // Actualizamos la lista de tareas en el estado local
      setTareas((prev) =>
        prev.map((tarea) => (tarea.idTareas === id ? { ...tarea, idEstadoTareaNavigation: { nombre: result.data.idEstadoTareaNavigation.nombre } } : tarea))
      );
    } catch (error) {
      toast.error('Error al actualizar el estado de la tarea');
    }
  };

  useEffect(() => {
    fetchTareas();
  }, [session]);

  return { tareas, loading, error, fetchTareas, updateTaskState };
}
