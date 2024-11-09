// Hooks/useControlAnimalTareasEmpleado.ts
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import {jwtDecode} from 'jwt-decode';
import { ControlAnimalTareaEmpleado } from '@/Types/next-auth-types/ControlAnimalTareaEmpleado';
import toast from 'react-hot-toast';

export function useControlAnimalTareasEmpleado() {
  const { data: session } = useSession();
  const [tareas, setTareas] = useState<ControlAnimalTareaEmpleado[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTareas = async () => {
      if (!session?.user?.access_token) {
        toast.error('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        // Decodificar el token y obtener el id del usuario
        const decodedToken = jwtDecode<{ Id: number }>(session.user.access_token);
        const empleadoId = decodedToken.Id;

        // Realizar la solicitud con el id del empleado
        const response = await fetch(`http://localhost:5153/api/Tareas/controlAnimal-empleado?id=${empleadoId}`, {
          headers: {
            Authorization: `Bearer ${session.user.access_token}`,
          },
        });

        if (!response.ok) throw new Error('Error al obtener las tareas de control de animal');

        const result = await response.json();
        setTareas(result.data);
      } catch (error) {
        setError('Error al cargar las tareas de control de animal');
      } finally {
        setLoading(false);
      }
    };

    fetchTareas();
  }, [session]);

  return { tareas, loading, error };
}
