// Hooks/usePromedioCalificaciones.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { PromedioCalificaciones } from '@/Types/next-auth-types/PromedioCalificaciones ';

export function usePromedioCalificaciones() {
  const [data, setData] = useState<PromedioCalificaciones | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento
        const response = await axios.get('http://localhost:5153/api/CalificacionVisitaReporte/PromedioCalificaciones', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        setData(response.data.data[0]);
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
