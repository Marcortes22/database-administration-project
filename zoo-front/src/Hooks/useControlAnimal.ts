// useControlAnimal.ts
'use client';
import { useState } from 'react';
import { useSession } from 'next-auth/react'; // Para obtener el token de la sesión
import toast from 'react-hot-toast';

interface CreateControlAnimalDto {
  reporte: string;
  idTareas: number;
  idAnimales: number;
}

export function useControlAnimal() {
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession(); // Obtener la sesión y el token

  const createControlAnimal = async (controlAnimalDto: CreateControlAnimalDto) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación', {
        icon: '🚫',
        style: { borderRadius: '10px', background: '#333', color: '#fff' },
      });
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch('http://localhost:5153/api/ControlAnimal', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`, // Envía el token
        },
        body: JSON.stringify(controlAnimalDto),
      });

      if (!response.ok) {
        throw new Error('Error al crear el control animal');
      }

      const result = await response.json();
      if (result.success) {
        toast.success('Control animal creado correctamente', {
          icon: '✅',
          style: { borderRadius: '10px', background: '#333', color: '#fff' },
        });
        return result.data; // Retornamos los datos en caso de éxito
      } else {
        setError(result.message);
        toast.error(result.message, {
          icon: '🚫',
          style: { borderRadius: '10px', background: '#333', color: '#fff' },
        });
      }
    } catch (error) {
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor', {
        icon: '❌',
        style: { borderRadius: '10px', background: '#333', color: '#fff' },
      });
    } finally {
      setLoading(false);
    }
  };

  return { createControlAnimal, loading, error };
}
