// Hooks/useCalificacionesPorFecha.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { CalificacionesPorFecha } from '@/Types/next-auth-types/CalificacionVisitaPorFecha';

export function useCalificacionesPorFecha() {
  const [data, setData] = useState<CalificacionesPorFecha[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento
        const response = await axios.get('http://localhost:5153/api/CalificacionVisitaReporte/CalificacionesPorFecha', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        setData(response.data.data);
      } catch (error) {
        setError('Error al cargar los datos.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
}
