// useAlimento.ts
'use client';
import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { Alimento } from '@/Types/next-auth-types/Dieta';

export function useAlimento() {
  const [alimentos, setAlimentos] = useState<Alimento[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  const getAlimentos = async () => {
    setLoading(true);
    setError(null);

    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      setLoading(false);
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/Alimento', {
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al obtener los alimentos');

      const result = await response.json();
      setAlimentos(result.data);
    } catch (error) {
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  const getAlimentoById = async (id: number) => {
    setLoading(true);
    setError(null);

    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      setLoading(false);
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Alimento/getById?id=${id}`, {
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al obtener el alimento');

      const result = await response.json();
      return result.data; // Retornamos el alimento específico
    } catch (error) {
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  const createAlimento = async (nuevoAlimento: Omit<Alimento, 'idAlimento'>) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/Alimento', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(nuevoAlimento),
      });

      if (!response.ok) throw new Error('Error al crear el alimento');

      const result = await response.json();
      toast.success('Alimento creado correctamente');
      setAlimentos((prev) => [...prev, result.data]);
    } catch (error) {
      setError('Error al crear el alimento');
      toast.error('Error al crear el alimento');
    }
  };

  const updateAlimento = async (idAlimento: number, updatedAlimento: Alimento) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Alimento/${idAlimento}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(updatedAlimento),
      });

      if (!response.ok) throw new Error('Error al actualizar el alimento');

      toast.success('Alimento actualizado correctamente');
      setAlimentos((prev) =>
        prev.map((alimento) => (alimento.idAlimento === idAlimento ? updatedAlimento : alimento))
      );
    } catch (error) {
      setError('Error al actualizar el alimento');
      toast.error('Error al actualizar el alimento');
    }
  };

  const deleteAlimento = async (idAlimento: number) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/Alimento/${idAlimento}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al eliminar el alimento');

      toast.success('Alimento eliminado correctamente');
      setAlimentos((prev) => prev.filter((alimento) => alimento.idAlimento !== idAlimento));
    } catch (error) {
      setError('Error al eliminar el alimento');
      toast.error('Error al eliminar el alimento');
    }
  };

  return { alimentos, loading, error, getAlimentos, getAlimentoById, createAlimento, updateAlimento, deleteAlimento };
}
