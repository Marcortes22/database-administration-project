'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react'; // Para manejar la sesión y el token
import toast from 'react-hot-toast';
import {  Empleado, RegistarEmpleado } from '@/Types/next-auth-types/Empleado';

export function useEmpleados() {
  const [empleados, setEmpleados] = useState<Empleado[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  const { data: session } = useSession(); // Obtener sesión y token

  useEffect(() => {
    const fetchEmpleados = async () => {
      if (!session?.user?.access_token) {
        setError('No se encontró el token de autenticación');
        setLoading(false);
        return;
      }

      try {
        const response = await fetch('http://localhost:5153/api/Empleado', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${session.user.access_token}`, // Enviar token
          },
        });

        if (!response.ok) {
          throw new Error('Error al obtener los empleados');
        }

        const result = await response.json();
        if (result.success) {
          setEmpleados(result.data); // Guardar los empleados obtenidos
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
      fetchEmpleados(); // Ejecutar si hay una sesión activa
    }
  }, [session]); // Ejecutar el efecto si la sesión cambia

  return { empleados, loading, error };
}
