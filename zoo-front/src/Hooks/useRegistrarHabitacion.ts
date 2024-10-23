// hooks/useRegistrarHabitacion.ts
'use client';

import { useRouter } from 'next/navigation';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';

interface Habitacion {
  nombreHab: string;
  direccion: string;
  capacidad: number;
  idTipoHabitacion: number;
}

export const useRegistrarHabitacion = () => {
  const router = useRouter();
  const { data: session } = useSession();

  const registrarHabitacion = async (nuevaHabitacion: Habitacion) => {
    if (!session?.user?.access_token) {
      toast.error('No se encontró el token de autenticación.');
      return;
    }

    try {
      const res = await fetch('http://localhost:5153/api/Habitacion', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.user.access_token}`,
        },
        body: JSON.stringify(nuevaHabitacion),
      });

      if (!res.ok) {
        throw new Error('Error al registrar la habitación');
      }

      toast.success('Hábitat registrado correctamente', {
        style: { borderRadius: '10px', background: '#333', color: '#fff' },
      });

      router.push('/dashboard/habitats'); // Redirigimos a la lista de habitaciones
    } catch (error) {
      console.error(error);
      toast.error('Ocurrió un error al registrar la habitación.');
    }
  };

  return { registrarHabitacion };
};
