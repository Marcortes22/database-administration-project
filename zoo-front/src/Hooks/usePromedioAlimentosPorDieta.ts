// Hooks/usePromedioAlimentosPorDieta.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { PromedioAlimentosPorDieta } from '@/Types/next-auth-types/PromedioAlimentosPorDieta';

export function usePromedioAlimentosPorDieta() {
  const [data, setData] = useState<PromedioAlimentosPorDieta[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento local
        const response = await axios.get('http://localhost:5153/api/AlimentoReportes/PromedioAlimentosPorDieta', {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setData(response.data.data);
      } catch (error) {
        setError('Error al cargar el promedio de alimentos por dieta');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
}
