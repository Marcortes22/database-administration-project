// useCrearTarea.ts
'use client';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';

export function useCrearTarea() {
  const { data: session } = useSession();

  const crearControlAnimal = async (data: { idAnimales: number; idEmpleado: number; nombreTarea: string }) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/ControlAnimal', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) throw new Error('Error al crear tarea de ControlAnimal');

      toast.success('Tarea de ControlAnimal creada correctamente');
    } catch (error) {
      toast.error('Error al crear tarea de ControlAnimal');
    }
  };

  const crearMantenimientoHabitacion = async (data: { idHabitacion: number; idEmpleado: number; nombreTarea: string }) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación');
      return;
    }

    try {
      const response = await fetch('http://localhost:5153/api/MantenimientoHabitacion', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) throw new Error('Error al crear tarea de MantenimientoHabitacion');

      toast.success('Tarea de MantenimientoHabitacion creada correctamente');
    } catch (error) {
      toast.error('Error al crear tarea de MantenimientoHabitacion');
    }
  };

  return { crearControlAnimal, crearMantenimientoHabitacion };
}
