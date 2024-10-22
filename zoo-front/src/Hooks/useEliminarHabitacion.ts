import { useSession } from 'next-auth/react';
import { useState } from 'react';

export const useEliminarHabitacion = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<null | string>(null);
  const { data: session } = useSession();
  
  const eliminarHabitacion = async (idHabitacion: number) => {
    setLoading(true);
    try {
      const response = await fetch(`http://localhost:5153/api/Habitacion/${idHabitacion}`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`, // Envía el token
          },
      });

      if (!response.ok) {
        throw new Error('Error al eliminar la habitación');
      }
    } catch (error) {
      setError('Error al eliminar la habitación');
    } finally {
      setLoading(false);
    }
  };

  return { eliminarHabitacion, loading, error };
};
