// useTipoTarea.ts
'use client';
import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { TipoTarea } from '@/Types/next-auth-types/TipoTarea';

export function useTipoTarea() {
  const [tipos, setTipos] = useState<TipoTarea[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  const getTipos = async () => {
    setLoading(true);
    setError(null);

    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      setLoading(false);
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/TipoTarea', {
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al obtener los tipos de tarea');

      const result = await response.json();
      setTipos(result.data);
    } catch (error) {
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  const createTipo = async (nuevoTipo: Omit<TipoTarea, 'idTipoTarea'>) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/TipoTarea', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(nuevoTipo),
      });

      if (!response.ok) throw new Error('Error al crear el tipo de tarea');

      const result = await response.json();
      toast.success('Tipo de tarea creado correctamente');
      setTipos((prev) => [...prev, result.data]);
    } catch (error) {
      setError('Error al crear el tipo de tarea');
      toast.error('Error al crear el tipo de tarea');
    }
  };

  const updateTipo = async (idTipoTarea: number, updatedTipo: TipoTarea) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/TipoTarea/${idTipoTarea}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(updatedTipo),
      });

      if (!response.ok) throw new Error('Error al actualizar el tipo de tarea');

      toast.success('Tipo de tarea actualizado correctamente');
      setTipos((prev) =>
        prev.map((tipo) => (tipo.idTipoTarea === idTipoTarea ? updatedTipo : tipo))
      );
    } catch (error) {
      setError('Error al actualizar el tipo de tarea');
      toast.error('Error al actualizar el tipo de tarea');
    }
  };

  const deleteTipo = async (idTipoTarea: number) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/TipoTarea/${idTipoTarea}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al eliminar el tipo de tarea');

      toast.success('Tipo de tarea eliminado correctamente');
      setTipos((prev) => prev.filter((tipo) => tipo.idTipoTarea !== idTipoTarea));
    } catch (error) {
      setError('Error al eliminar el tipo de tarea');
      toast.error('Error al eliminar el tipo de tarea');
    }
  };

  return { tipos, loading, error, getTipos, createTipo, updateTipo, deleteTipo };
}
