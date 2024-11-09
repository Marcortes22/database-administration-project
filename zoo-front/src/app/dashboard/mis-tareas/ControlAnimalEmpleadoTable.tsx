// Components/ControlAnimalEmpleadoTable.tsx
'use client';

import React from 'react';
import { useControlAnimalTareasEmpleado } from '@/Hooks/useControlAnimalTareaEmpleado';
import { ControlAnimalTareaEmpleado } from '@/Types/next-auth-types/ControlAnimalTareaEmpleado';
import { useCambiarEstadoTarea } from '@/Hooks/useCambiarEstado';

interface ControlAnimalEmpleadoTableProps {
  data: ControlAnimalTareaEmpleado[];
}

export default function ControlAnimalEmpleadoTable({ data }: ControlAnimalEmpleadoTableProps) {

  
  const { tareas, loading, error } = useControlAnimalTareasEmpleado();
  const { cambiarEstadoTarea, loading: loadingdata } = useCambiarEstadoTarea();

  if (loading) return <p className="text-center">Cargando tareas de mantenimiento habitacion...</p>;
  if (error) return <p className="text-red-500 text-center">{error}</p>;

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-semibold mb-4">Tareas de  Mantenimiento Habitacion</h2>
      <table className="w-full text-left text-gray-700 bg-white rounded-md">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Tarea</th>
            <th className="px-6 py-3 text-center">Empleado</th>
            <th className="px-6 py-3 text-center">Estado</th>
            <th className="px-6 py-3 text-center">Habitación</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {tareas.map((tarea) => (
            <tr key={tarea.idTareas} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{tarea.idTareas}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreTarea}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreEmpleado}</td>
              <td className="px-6 py-4 text-center">{tarea.estado}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreHab}</td>
              <td className="px-6 py-4 text-center">
            <button
              onClick={() => cambiarEstadoTarea(tarea.idTareas)}
              disabled={loadingdata}
              className={`px-4 py-2 rounded-lg text-white ${
                loading ? 'bg-gray-400 cursor-not-allowed' : 'bg-green-500 hover:bg-green-600'
              } transition duration-300`}
            >
              {loadingdata ? 'Procesando...' : 'Marcar como lista'}
            </button>
          </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
