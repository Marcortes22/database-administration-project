import { useEffect, useState } from "react";

export const useHabitaciones = () => {
    const [habitaciones, setHabitaciones] = useState<Habitacion[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<null | string>(null);
  
    useEffect(() => {
      const fetchHabitaciones = async () => {
        try {
          const response = await fetch('http://localhost:5153/api/Habitacion'); // Ajusta la URL a tu backend
          if (!response.ok) {
            throw new Error('Error al obtener las habitaciones');
          }
          const data = await response.json();
          setHabitaciones(data);
        } catch (err) {
          setError('Error al obtener las habitaciones');
        } finally {
          setLoading(false);
        }
      };
  
      fetchHabitaciones();
    }, []);
  
    return { habitaciones, loading, error };
  };