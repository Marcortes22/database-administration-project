// useEstadoTarea.ts
'use client';
import { useState } from 'react';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';
import { EstadoTarea } from '@/Types/next-auth-types/EstadoTarea';


export function useEstadoTarea() {
  const [estados, setEstados] = useState<EstadoTarea[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const { data: session } = useSession();

  const getEstados = async () => {
    setLoading(true);
    setError(null);

    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      setLoading(false);
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/EstadoTarea', {
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al obtener los estados de tarea');

      const result = await response.json();
      setEstados(result.data);
    } catch (error) {
      setError('Error al conectar con el servidor');
      toast.error('Error al conectar con el servidor');
    } finally {
      setLoading(false);
    }
  };

  const createEstado = async (nuevoEstado: Omit<EstadoTarea, 'idEstado'>) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/EstadoTarea', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(nuevoEstado),
      });

      if (!response.ok) throw new Error('Error al crear el estado de tarea');

      const result = await response.json();
      toast.success('Estado de tarea creado correctamente');
      setEstados((prev) => [...prev, result.data]);
    } catch (error) {
      setError('Error al crear el estado de tarea');
      toast.error('Error al crear el estado de tarea');
    }
  };

  const updateEstado = async (idEstado: number, updatedEstado: EstadoTarea) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/EstadoTarea/${idEstado}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(updatedEstado),
      });

      if (!response.ok) throw new Error('Error al actualizar el estado de tarea');

      toast.success('Estado de tarea actualizado correctamente');
      setEstados((prev) =>
        prev.map((estado) => (estado.idEstado === idEstado ? updatedEstado : estado))
      );
    } catch (error) {
      setError('Error al actualizar el estado de tarea');
      toast.error('Error al actualizar el estado de tarea');
    }
  };

  const deleteEstado = async (idEstado: number) => {
    if (!session?.user?.access_token) {
      setError('No se encontró el token de autenticación');
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch(`http://localhost:5153/api/EstadoTarea/delete/${idEstado}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${session.user.access_token}`,
        },
      });

      if (!response.ok) throw new Error('Error al eliminar el estado de tarea');

      toast.success('Estado de tarea eliminado correctamente');
      setEstados((prev) => prev.filter((estado) => estado.idEstado !== idEstado));
    } catch (error) {
      setError('Error al eliminar el estado de tarea');
      toast.error('Error al eliminar el estado de tarea');
    }
  };

  return { estados, loading, error, getEstados, createEstado, updateEstado, deleteEstado };
}
