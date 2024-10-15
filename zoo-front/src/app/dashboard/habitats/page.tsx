'use client';

import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { useState } from 'react';
import toast from 'react-hot-toast';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa'; 

export default function HabitatsTable() {
  const { navigateTo } = useCustomRouter();
  // Datos simulados para los habitats
  const [habitats, setHabitats] = useState([
    { IdHabitacion: 1, Nombre: 'Habitat 1', Direccion: 'Ubicación 1', Capacidad: 50 },
    { IdHabitacion: 2, Nombre: 'Habitat 2', Direccion: 'Ubicación 2', Capacidad: 30 },
    { IdHabitacion: 3, Nombre: 'Habitat 3', Direccion: 'Ubicación 3', Capacidad: 20 },
  ]);

  const handleEdit = (id: number) => {
    toast.success('Hábitat editado correctamente', {
      style: {
        borderRadius: '10px',
        background: '#333',
        color: '#fff',
      },
    });
    console.log(`Editar habitat con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    setHabitats(habitats.filter(habitat => habitat.IdHabitacion !== id));
    toast.success('Hábitat eliminado correctamente', {
      style: {
        borderRadius: '10px',
        background: '#333',
        color: '#fff',
      },
    });
    console.log(`Eliminar habitat con id: ${id}`);
  };

  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg mx-8 my-6"> {/* Márgenes en los lados */}
   <div className="flex justify-between mb-4">
        <h2 className="text-xl font-semibold">Registro de Hábitats</h2>
        <button
          onClick={() => navigateTo('/dashboard/habitats/addHabitats')}
          className="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo registro
        </button>
      </div>
      <table className="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" className="px-6 py-3 text-center">ID</th>
            <th scope="col" className="px-6 py-3 text-center">Nombre</th>
            <th scope="col" className="px-6 py-3 text-center">Dirección</th>
            <th scope="col" className="px-6 py-3 text-center">Capacidad</th>
            <th scope="col" className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {habitats.map((habitat) => (
            <tr key={habitat.IdHabitacion} className="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" className="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center">
                {habitat.IdHabitacion}
              </th>
              <td className="px-6 py-4 text-center">{habitat.Nombre}</td>
              <td className="px-6 py-4 text-center">{habitat.Direccion}</td>
              <td className="px-6 py-4 text-center">{habitat.Capacidad}</td>
              <td className="px-6 py-4 text-center">
                <button
                  className="bg-blue-500 text-white px-3 py-1 rounded-md mr-2 hover:bg-blue-600 transition duration-300"
                  onClick={() => handleEdit(habitat.IdHabitacion)}
                >
                <FaEdit/>
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition duration-300"
                  onClick={() => handleDelete(habitat.IdHabitacion)}
                >
                 <FaTrash/> 
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
