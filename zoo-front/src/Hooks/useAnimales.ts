'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { Animal } from '@/Types/next-auth-types/Animal';

export function useAnimales() {
  const [animales, setAnimales] = useState<Animal[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession();

  const fetchAnimales = async () => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      setLoading(false);
      toast.error('No se encontró el token de autenticación', {
        icon: '🚫',
        style: { borderRadius: '10px', background: '#333', color: '#fff' },
      });
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/Animal', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) {
        throw new Error('Error al obtener los animales');
      }

      const result = await response.json();
      if (result.success) {
        setAnimales(result.data);
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

  useEffect(() => {
    if (session) {
      fetchAnimales();
    }
  }, [session]);

  const updateAnimal = async (id: number, updatedAnimal: Partial<Animal>) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Animal/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(updatedAnimal),
      });

      if (!response.ok) throw new Error('Error al actualizar el animal');

      const result = await response.json();
      toast.success('Animal actualizado correctamente');
      setAnimales((prev) =>
        prev.map((animal) => (animal.idAnimales === id ? result.data : animal))
      );
    } catch (error) {
      toast.error('Error al actualizar el animal');
    }
  };

  const deleteAnimal = async (id: number) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Animal/${id}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al eliminar el animal');

      toast.success('Animal eliminado correctamente');
      setAnimales((prev) => prev.filter((animal) => animal.idAnimales !== id));
    } catch (error) {
      toast.error('Error al eliminar el animal');
    }
  };

  return { animales, loading, error, updateAnimal, deleteAnimal, setAnimales, fetchAnimales };
}
