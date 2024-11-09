// Hooks/useAlimentosMasUsados.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { AlimentosMasUtilizados } from '@/Types/next-auth-types/AlimentosMasUtilizados';


export function useAlimentosMasUtilizados() {
  const [data, setData] = useState<AlimentosMasUtilizados[] | null>(null);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token'); // Obtener el token del almacenamiento local
        const response = await axios.get('http://localhost:5153/api/AlimentoReportes/AlimentosMasUtilizados', {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        setData(response.data.data);
      } catch (error) {
        setError('Error al cargar los alimentos más usados');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
}
