'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react'; // Manejo de sesión y token
import toast from 'react-hot-toast';
import { Animal } from '@/Types/next-auth-types/Animal'; // Definición del tipo Animal

export function useAnimales() {
  const [animales, setAnimales] = useState<Animal[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession(); // Obtener la sesión y el token

  useEffect(() => {
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
            Authorization: `Bearer ${session.user.access_token}`, // Enviamos el token
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener los animales');
        }

        const result = await response.json();
        if (result.success) {
          setAnimales(result.data); // Guardar los animales obtenidos
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

    if (session) {
      fetchAnimales(); // Ejecutar si hay una sesión activa
    }
  }, [session]); // Ejecutar el efecto si la sesión cambia

  return { animales, loading, error };
}
