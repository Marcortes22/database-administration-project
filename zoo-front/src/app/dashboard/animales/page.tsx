'use client';

import { useState } from 'react';
import toast from 'react-hot-toast';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';
import { useCustomRouter } from '@/Hooks/Router/useRouter';

export default function AnimalesTable() {
  const { navigateTo } = useCustomRouter();
  const [animales, setAnimales] = useState([
    { IdAnimal: 1, Nombre: 'León', Edad: 5 },
    { IdAnimal: 2, Nombre: 'Tigre', Edad: 3 },
    { IdAnimal: 3, Nombre: 'Elefante', Edad: 10 },
  ]);

  const handleEdit = (id: number) => {
    toast.success('Animal editado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Editar animal con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    setAnimales(animales.filter(animal => animal.IdAnimal !== id));
    toast.success('Animal eliminado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Eliminar animal con id: ${id}`);
  };

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Animales</h2>
        <button
          onClick={() => navigateTo('/dashboard/animales/addAnimales')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo animal
        </button>
      </div>

      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Edad</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {animales.map((animal) => (
            <tr key={animal.IdAnimal} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{animal.IdAnimal}</td>
              <td className="px-6 py-4 text-center">{animal.Nombre}</td>
              <td className="px-6 py-4 text-center">{animal.Edad}</td>
              <td className="px-6 py-4 flex justify-center space-x-2">
                <button
                  className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                  onClick={() => handleEdit(animal.IdAnimal)}
                >
                  <FaEdit className="mr-1" /> Editar
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-2 rounded-full hover:bg-red-600 transition-all flex items-center"
                  onClick={() => handleDelete(animal.IdAnimal)}
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
