// Hooks/usePromedioCalificacionesPorMes.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { PromedioCalificacionesPorMes } from '@/Types/next-auth-types/PromedioCalificacionesPorMes';

export function usePromedioCalificacionesPorMes() {
  const [data, setData] = useState<PromedioCalificacionesPorMes[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento local
        const response = await axios.get('http://localhost:5153/api/CalificacionVisitaReporte/PromedioCalificacionesPorMes', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        setData(response.data.data);
      } catch (error) {
        setError('Error al cargar el reporte de promedio de calificaciones por mes.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
}
