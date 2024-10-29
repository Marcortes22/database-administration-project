'use client';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { useAnimales } from '@/Hooks/useAnimales';
import { useDietas } from '@/Hooks/useDieta';
import { useEspecies } from '@/Hooks/useEspecie';
import { useEstadoSalud } from '@/Hooks/useEstadoSalud';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { use } from 'react';
import { FaPlus } from 'react-icons/fa';

export default function TablaAnimales() {
  const { animales, loading, error } = useAnimales();
  const { especies } = useEspecies();
  const { estados } = useEstadoSalud();
  const { dietas } = useDietas();
  const { habitaciones } = useHabitaciones();
  const {navigateTo}= useCustomRouter();

  const obtenerNombreEspecie = (id: number) =>
    especies.find((especie) => especie.idEspecie === id)?.nombreEsp || 'Desconocido';

  const obtenerEstadoSalud = (id: number) =>
    estados.find((estado) => estado.idEstadoSalud === id)?.estadoSalud || 'Desconocido';

  const obtenerDieta = (id: number) =>
    dietas.find((dieta) => dieta.idDieta === id)?.nombreDiet || 'Desconocido';

  const obtenerHabitacion = (id: number) =>
    habitaciones.find((habitacion) => habitacion.idHabitacion === id)?.nombreHab || 'Desconocido';

  if (loading) return <p className="text-center">Cargando datos...</p>;
  if (error) return <p className="text-center text-red-500">Error: {error}</p>;

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Animales</h2>
        <button
          onClick={() => navigateTo('/dashboard/animales/agregarAnimal')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo animal
        </button>
      </div>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Edad</th>
            <th className="px-6 py-3 text-center">Habitación</th>
            <th className="px-6 py-3 text-center">Dieta</th>
            <th className="px-6 py-3 text-center">Especie</th>
            <th className="px-6 py-3 text-center">Estado de Salud</th>
          </tr>
        </thead>
        <tbody>
          {animales.map((animal) => (
            <tr key={animal.idAnimales} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center">{animal.nombreAni}</td>
              <td className="px-6 py-4 text-center">{animal.edadAni}</td>
              <td className="px-6 py-4 text-center">{obtenerHabitacion(animal.idHabitacion)}</td>
              <td className="px-6 py-4 text-center">{obtenerDieta(animal.idDieta)}</td>
              <td className="px-6 py-4 text-center">{obtenerNombreEspecie(animal.idEspecie)}</td>
              <td className="px-6 py-4 text-center">{obtenerEstadoSalud(animal.idEstadoSalud)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
