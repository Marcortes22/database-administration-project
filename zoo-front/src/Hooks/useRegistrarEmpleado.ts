'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import toast from 'react-hot-toast';
import { useSession } from 'next-auth/react';
import { Empleado } from '@/Types/next-auth-types/Empleado';

export const useRegistrarEmpleado = () => {
  const { data: session } = useSession(); // Para obtener el token de autenticación
  const router = useRouter(); // Para redirigir después de registrar
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const registrarEmpleado = async (empleado: Empleado) => {
    setLoading(true);
    setError(null);

    try {
      const res = await fetch('http://localhost:5153/api/Auth/register', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session?.user?.access_token}`, // Token del usuario autenticado
        },
        body: JSON.stringify(empleado),
      });

      if (!res.ok) {
        const errorData = await res.json();
        throw new Error(errorData.message || 'Error al registrar empleado');
      }

      toast.success('Empleado registrado correctamente', {
        style: { borderRadius: '10px', background: '#333', color: '#fff' },
      });

      router.push('/dashboard/empleados'); // Redirigir tras el registro
    } catch (err: any) {
      console.error('Error registrando empleado:', err);
      setError(err.message);
      toast.error('Ocurrió un error al registrar el empleado.');
    } finally {
      setLoading(false);
    }
  };

  return { registrarEmpleado, loading, error };
};