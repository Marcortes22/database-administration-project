'use client';

import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { useState } from 'react';
import toast from 'react-hot-toast';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa'; 

export default function HabitatsTable() {
  const { navigateTo } = useCustomRouter();
  const [habitats, setHabitats] = useState([
    { IdHabitacion: 1, Nombre: 'Habitat 1', Direccion: 'Ubicación 1', Capacidad: 50 },
    { IdHabitacion: 2, Nombre: 'Habitat 2', Direccion: 'Ubicación 2', Capacidad: 30 },
    { IdHabitacion: 3, Nombre: 'Habitat 3', Direccion: 'Ubicación 3', Capacidad: 20 },
  ]);

  const handleEdit = (id: number) => {
    toast.success('Hábitat editado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Editar habitat con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    setHabitats(habitats.filter(habitat => habitat.IdHabitacion !== id));
    toast.success('Hábitat eliminado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Eliminar habitat con id: ${id}`);
  };

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Hábitats</h2>
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
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {habitats.map((habitat) => (
            <tr key={habitat.IdHabitacion} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{habitat.IdHabitacion}</td>
              <td className="px-6 py-4 text-center">{habitat.Nombre}</td>
              <td className="px-6 py-4 text-center">{habitat.Direccion}</td>
              <td className="px-6 py-4 text-center">{habitat.Capacidad}</td>
              <td className="px-6 py-4 flex justify-center space-x-2">
                <button
                  className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                  onClick={() => handleEdit(habitat.IdHabitacion)}
                >
                  <FaEdit className="mr-1" /> Editar
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-2 rounded-full hover:bg-red-600 transition-all flex items-center"
                  onClick={() => handleDelete(habitat.IdHabitacion)}
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
