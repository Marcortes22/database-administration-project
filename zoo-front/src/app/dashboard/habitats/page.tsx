'use client';

import { useState } from 'react';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';
import toast from 'react-hot-toast';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useTiposHabitacion } from '@/Hooks/useTipoHabitacion';
import { useEliminarHabitacion } from '@/Hooks/useEliminarHabitacion';
import { Habitacion } from '@/Types/next-auth-types/Habitacion';
import { ModalEditHabitacion } from './editModal';
import { DeleteModal } from './elimModal';

export default function HabitatsTable() {
  const { navigateTo } = useCustomRouter();
  const { habitaciones, loading, error } = useHabitaciones();
  const { tiposHabitacion } = useTiposHabitacion();
  const { eliminarHabitacion, loading: loadingEliminar } = useEliminarHabitacion(); // Usamos el hook de eliminar
  const [selectedHabitacion, setSelectedHabitacion] = useState<Habitacion | null>(null);
  const [habitacionIdToDelete, setHabitacionIdToDelete] = useState<number | null>(null); // Estado para abrir el modal de eliminación

  const handleEdit = (habitacion: Habitacion) => {
    setSelectedHabitacion(habitacion); // Abre el modal de edición
  };

  const handleDelete = (id: number) => {
    setHabitacionIdToDelete(id); // Abrir el modal de confirmación de eliminación
  };

  const confirmDelete = () => {
    if (habitacionIdToDelete !== null) {
      eliminarHabitacion(habitacionIdToDelete)
        .then(() => {
          toast.success('Habitación eliminada correctamente', {
            style: { borderRadius: '10px', background: '#333', color: '#fff' },
          });
          setHabitacionIdToDelete(null); // Cerrar el modal después de eliminar
        })
        .catch(() => {
          toast.error('Error al eliminar la habitación');
        });
    }
  };

  const refreshHabitaciones = () => {
    // Aquí puedes llamar de nuevo al hook para refrescar las habitaciones después de editar
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center h-96">
        <div className="animate-spin rounded-full h-10 w-10 border-t-4 border-b-4 border-blue-500"></div>
        <p className="text-xl font-semibold text-gray-600 ml-4">
          Cargando habitaciones...
        </p>
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
    <div className="relative mx-8 my-6 p-6 bg-white shadow-md rounded-md">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Habitaciones</h2>
        <button
          onClick={() => navigateTo('/dashboard/habitats/addHabitats')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo registro
        </button>
      </div>

      <table className="w-full text-left text-gray-500 bg-white rounded-md">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Dirección</th>
            <th className="px-6 py-3 text-center">Capacidad</th>
            <th className="px-6 py-3 text-center">Tipo Habitación</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {habitaciones.map((habitat) => (
            <tr
              key={habitat.idHabitacion}
              className="border-b hover:bg-gray-100 transition duration-200"
            >
              <td className="px-6 py-4 text-center font-medium">
                {habitat.idHabitacion}
              </td>
              <td className="px-6 py-4 text-center">{habitat.nombreHab}</td>
              <td className="px-6 py-4 text-center">{habitat.direccion}</td>
              <td className="px-6 py-4 text-center">{habitat.capacidad}</td>
              <td className="px-6 py-4 text-center">
                {getTipoNombre(habitat.idTipoHabitacion)}
              </td>
              <td className="px-6 py-4 flex justify-center space-x-2">
                <button
                  className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                  onClick={() => handleEdit(habitat)}
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

      {/* Modal de edición */}
      {selectedHabitacion && (
        <ModalEditHabitacion
          habitacion={selectedHabitacion}
          onClose={() => setSelectedHabitacion(null)}
          onSave={refreshHabitaciones}
        />
      )}

      {/* Modal de confirmación de eliminación */}
      {habitacionIdToDelete !== null && (
        <DeleteModal
          habitacionId={habitacionIdToDelete}
          onClose={() => setHabitacionIdToDelete(null)}
          onDelete={confirmDelete}
          loading={loadingEliminar}
        />
      )}
    </div>
  );
}
