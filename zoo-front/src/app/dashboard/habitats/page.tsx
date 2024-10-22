'use client';

import { useCustomRouter } from '@/Hooks/Router/useRouter';

import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';
import toast from 'react-hot-toast';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useTiposHabitacion } from '@/Hooks/useTipoHabitacion';

export default function HabitatsTable() {
  const { navigateTo } = useCustomRouter();
  const { habitaciones, loading, error } = useHabitaciones(); // Usamos el hook adaptado
  const { tiposHabitacion } = useTiposHabitacion();

  const handleEdit = (id: number) => {
    toast.success('Hábitat editado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Editar hábitat con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    toast.success('Hábitat eliminado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Eliminar hábitat con id: ${id}`);
    // Aquí podrías hacer una llamada a tu API para eliminar el hábitat
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-96">
        <div className="animate-spin rounded-full h-10 w-10 border-t-4 border-b-4 border-blue-500"></div>
        <p className="text-xl font-semibold text-gray-600 ml-4">Cargando habitaciones...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-96">
        <div
          className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative"
          role="alert"
        >
          <strong className="font-bold">Error:</strong>
          <span className="block sm:inline"> {error}</span>
        </div>
      </div>
    );
  }

  const getTipoNombre = (idTipoHabitacion: number) => {
    const tipo = tiposHabitacion.find((tipo) => tipo.idTipoHabitacion === idTipoHabitacion);
    return tipo ? tipo.nombreTh : 'Desconocido';
  };

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Habitaciones</h2>
        <button
          onClick={() => navigateTo('/dashboard/habitats/addHabitats')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo registro
        </button>
      </div>

      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Dirección</th>
            <th className="px-6 py-3 text-center">Capacidad</th>
            <th className="px-6 py-3 text-center">ID Tipo Habitación</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {habitaciones?.map((habitat) => (
            <tr key={habitat.idHabitacion} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{habitat.idHabitacion}</td>
              <td className="px-6 py-4 text-center">{habitat.nombreHab}</td>
              <td className="px-6 py-4 text-center">{habitat.direccion}</td>
              <td className="px-6 py-4 text-center">{habitat.capacidad}</td>
              <td className="px-6 py-4 text-center">
                {getTipoNombre(habitat.idTipoHabitacion)}
              </td>
              <td className="px-6 py-4 flex justify-center space-x-2">
                <button
                  className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                  onClick={() => handleEdit(habitat.idHabitacion)}
                >
                  <FaEdit className="mr-1" /> Editar
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-2 rounded-full hover:bg-red-600 transition-all flex items-center"
                  onClick={() => handleDelete(habitat.idHabitacion)}
                >
                  <FaTrash className="mr-1" /> Eliminar
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
