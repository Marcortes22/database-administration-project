// hooks/useCrearAnimal.ts
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

      if (!response.ok) {
        throw new Error('Error al crear el animal');
      }

      toast.success('Animal creado exitosamente');
    } catch (error) {
      toast.error('Error al crear el animal');
    } finally {
      setLoading(false);
    }
  };

  return { crearAnimal, loading };
};
