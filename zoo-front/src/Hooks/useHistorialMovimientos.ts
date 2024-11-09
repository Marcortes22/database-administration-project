// Hooks/useHistorialMovimientos.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { HistorialMovimientos } from '@/Types/next-auth-types/HistorialMovimientos';


export function useHistorialMovimientos() {
    const [data, setData] = useState<HistorialMovimientos[] | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = localStorage.getItem('token');
                const response = await axios.get('http://localhost:5153/api/HistorialMovimientosReportes/historial-movimientos', {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                setData(response.data.data);
            } catch (error) {
                setError('Error al cargar el historial de movimientos');
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    return { data, loading, error };
}
