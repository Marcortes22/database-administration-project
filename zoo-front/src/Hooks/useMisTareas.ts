'use client';
import { useEffect, useState } from 'react';
import { useSession } from 'next-auth/react';
import { jwtDecode } from 'jwt-decode';
import toast from 'react-hot-toast';
import { DecodedToken } from '@/Types/next-auth-types/DecodedToken';
import { Tarea } from '@/Types/next-auth-types/Tarea';

export const useTareasByEmpleado = () => {
  const { data: session } = useSession();
  const [tareas, setTareas] = useState<Tarea[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchTareasByEmpleado = async () => {
      try {
        const decoded: DecodedToken = jwtDecode(session?.user?.access_token || '');
        const empleadoId = decoded.Id;

        const response = await fetch(`http://localhost:5153/api/Tareas/tasksByEmpleado${empleadoId}`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session?.user?.access_token}`,
          },
        });

        const result = await response.json();
        console.log(result); // Verifica que la respuesta sea correcta

        if (!response.ok) {
          throw new Error(result.message || 'Error al obtener las tareas');
        }

        setTareas(result.data || []); // Asigna result.data directamente
      } catch (error) {
        setError('Error al conectar con el servidor');
        toast.error('Error al obtener las tareas');
      } finally {
        setLoading(false);
      }
    };

    if (session) {
      fetchTareasByEmpleado();
    }
  }, [session]);

  return { tareas, loading, error };
};
