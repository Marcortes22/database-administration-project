// Hooks/useCambiarEstadoTarea.ts
import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { CambiarEstadoPayload } from '@/Types/next-auth-types/CambiarEstado';

export const useCambiarEstadoTarea = () => {
  const { data: session } = useSession();
  const [loading, setLoading] = useState(false);

  const cambiarEstadoTarea = async (idTarea: number) => {
    const payload: CambiarEstadoPayload = { idTarea, idEstadoTarea: 3 }; // Estado 3 = Completada

    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      setLoading(true);
      const response = await fetch(`http://localhost:5153/api/Tareas/caambiarEstado-`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(payload),
      });

      const result = await response.json();
      if (!response.ok) {
        throw new Error(result.message || 'No se pudo cambiar el estado de la tarea.');
      }

      toast.success('Estado de la tarea actualizado exitosamente');
    } catch (error) {
      toast.error((error as Error).message);
    } finally {
      setLoading(false);
    }
  };

  return { cambiarEstadoTarea, loading };
};
