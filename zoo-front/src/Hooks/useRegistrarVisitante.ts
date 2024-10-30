// hooks/useRegistrarVisitante.ts
'use client';

import { useState } from 'react';
import { useSession } from 'next-auth/react'; // Para manejar el token de sesión
import toast from 'react-hot-toast';
import { CrearVisitante } from '@/Types/next-auth-types/Visitante';

export function useRegistrarVisitante() {
  const { data: session } = useSession(); // Obtener token de sesión
  const [loading, setLoading] = useState<boolean>(false);

  const registrarVisitante = async (visitante: CrearVisitante) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    setLoading(true);
    try {
      const response = await fetch('http://localhost:5153/api/Visitante', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(visitante),
      });

      if (!response.ok) {
        throw new Error('Error al registrar el visitante');
      }

      toast.success('Visitante registrado correctamente');
    } catch (error) {
      toast.error('Error al conectar con el servidor');
      console.error(error);
    } finally {
      setLoading(false);
    }
  };

  return { registrarVisitante, loading };
}
