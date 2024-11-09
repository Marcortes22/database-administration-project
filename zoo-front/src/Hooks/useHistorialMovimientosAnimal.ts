// Hooks/useHistorialMovimientosAnimal.ts
import { useState, useEffect } from 'react';
import axios from 'axios';
import { HistorialMovimientosAnimal } from '@/Types/next-auth-types/HistorialMovimientos';


export function useHistorialMovimientosAnimal() {
    const [data, setData] = useState<HistorialMovimientosAnimal[] | null>(null);
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const token = localStorage.getItem('token');
                const response = await axios.get('http://localhost:5153/api/HistorialMovimientosReportes/historial-movimientos-animal', {
                    headers: {
                        Authorization: `Bearer ${token}`,
                    },
                });
                setData(response.data.data);
            } catch (error) {
                setError('Error al cargar el historial de movimientos del animal');
            } finally {
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    return { data, loading, error };
}
