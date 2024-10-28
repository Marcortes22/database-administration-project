'use client';

import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import { Rol } from '@/Types/next-auth-types/Role';

export const useRoles = () => {
  const { data: session } = useSession(); // Token de sesión
  const [roles, setRoles] = useState<Rol[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchRoles = async () => {
      try {
        const res = await fetch('http://localhost:5153/api/Rol', {
          headers: {
            Authorization: `Bearer ${session?.user?.access_token}`, // Autorización con token
            'Content-Type': 'application/json',
          },
        });

        if (!res.ok) {
          throw new Error('Error al obtener los roles');
        }

        const data = await res.json();
        setRoles(data.data); // Accedemos al array dentro de `data`
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchRoles();
  }, [session]);

  return { roles, loading, error };
};