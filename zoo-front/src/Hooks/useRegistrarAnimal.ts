// hooks/useRegistrarAnimal.ts
'use client';

import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { Animal } from '@/Types/next-auth-types/Animal';

export const useRegistrarAnimal = () => {
  const { data: session } = useSession();
  const [loading, setLoading] = useState<boolean>(false);

  const crearAnimal = async (animal: Animal) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      setLoading(true);
      const response = await fetch('http://localhost:5153/api/Animal', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(animal),
      });

      const result = await response.json(); // Parseamos la respuesta del backend

      if (!response.ok) {
        // Si el backend retorna un mensaje de error
        toast.error(result.message || 'Error al crear el animal');
        return;
      }

      // Si la creación es exitosa
      toast.success(result.message || 'Animal creado exitosamente');
    } catch (error) {
      // En caso de error en la conexión o algo inesperado
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  return { crearAnimal, loading };
};
