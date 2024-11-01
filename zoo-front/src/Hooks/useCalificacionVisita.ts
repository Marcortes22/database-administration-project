// Hooks/useCalificacionVisita.ts
'use client';

import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { CalificacionVisita } from '@/Types/next-auth-types/CalificaciónVisita';

export const useCalificacionVisita = () => {
  const { data: session } = useSession();
  const [loading, setLoading] = useState<boolean>(false);

  const enviarCalificacion = async (calificacion: CalificacionVisita) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      setLoading(true);
      const response = await fetch('http://localhost:5153/api/CalificacionVisita', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(calificacion),
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.message || 'Error al enviar la calificación');
      }

      toast.success('Calificación enviada exitosamente');
    } catch (error) {
      toast.error('Error al enviar la calificación');
    } finally {
      setLoading(false);
    }
  };

  return { enviarCalificacion, loading };
};
