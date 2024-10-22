import { Habitacion } from '@/Types/next-auth-types/Habitacion';
import { useSession } from 'next-auth/react';
import { useState } from 'react';


export const useEditarHabitacion = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<null | string>(null);
  const { data: session } = useSession()

  const editarHabitacion = async (idHabitacion: number, habitacion: Partial<Habitacion>) => {
    setLoading(true);
    try {
      const response = await fetch(`http://localhost:5153/api/Habitacion/${idHabitacion}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(habitacion), // Enviamos solo los campos que han cambiado
      });

      if (!response.ok) {
        throw new Error('Error al actualizar la habitación');
      }
    } catch (error) {
      setError('Error al actualizar la habitación');
    } finally {
      setLoading(false);
    }
  };

  return { editarHabitacion, loading, error };
};
