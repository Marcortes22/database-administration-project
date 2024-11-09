// Hooks/usePromedioCalificacionesPorMes.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { AlimentosPorDieta } from '@/Types/next-auth-types/AlimentosPorDieta';

export function useAlimentosPorDieta() {
  const [data, setData] = useState<AlimentosPorDieta[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento local
        const response = await axios.get('http://localhost:5153/api/AlimentoReportes/AlimentosPorDieta', {
          headers: {
            Authorization: `Bearer ${token}`
          }
        });
        setData(response.data.data);
      } catch (error) {
        setError('Error al cargar los alimentos por dieta');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
}
