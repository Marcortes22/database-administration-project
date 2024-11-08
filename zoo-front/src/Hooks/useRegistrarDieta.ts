// hooks/useRegistrarDieta.ts
'use client';

import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { CrearDieta } from '@/Types/next-auth-types/Dieta';

export const useRegistrarDieta = () => {
  const { data: session } = useSession(); // Obtener token de sesión
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const registrarDieta = async (dieta: CrearDieta) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    setLoading(true);

    try {
      const response = await fetch('http://localhost:5153/api/Dieta', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`, // Token en el header
        },
        body: JSON.stringify(dieta),
      });

      if (!response.ok) {
        throw new Error('Error al registrar la dieta');
      }

      const result = await response.json();
      if (result.success) {
        toast.success('Dieta registrada exitosamente');
      } else {
        toast.error(result.message || 'Error en el registro');
      }
    } catch (error) {
      console.error('Error en la conexión con la API:', error);
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  return { registrarDieta, loading, error };
};
