import { useEffect, useState } from "react";

  export const useEmpleados = () => {
    const [empleados, setEmpleados] = useState<Empleado[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<null | string>(null);
  
    useEffect(() => {
      const fetchEmpleados = async () => {
        try {
          const response = await fetch('http://localhost:5153/api/Empleado');
          if (!response.ok) {
            throw new Error('Error al obtener los empleados');
          }
          const data = await response.json();
          setEmpleados(data);
        } catch (err) { setError('Error al obtener los empleados');
        } finally {
          setLoading(false);
        }
      };
  
      fetchEmpleados();
    }, []);
  
    return { empleados, loading, error };
  };