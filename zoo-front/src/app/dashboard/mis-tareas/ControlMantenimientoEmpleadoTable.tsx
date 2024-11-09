// Components/MantenimientoEmpleadoTable.tsx
'use client';

import React from 'react';
import { ControlMantenimientoEmpleado } from '@/Types/next-auth-types/ControlMantenimientoEmpleado';
import { useCambiarEstadoTarea } from '@/Hooks/useCambiarEstado';

interface MantenimientoEmpleadoTableProps {
  data: ControlMantenimientoEmpleado[];
}

export default function MantenimientoEmpleadoTable({ data }: MantenimientoEmpleadoTableProps) {
  const {cambiarEstadoTarea, loading} = useCambiarEstadoTarea();
  
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-semibold mb-4">Tareas de Control Animal</h2>
      <table className="w-full text-left text-gray-500 bg-white rounded-md">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID Tarea</th>
            <th className="px-6 py-3 text-center">Nombre de la Tarea</th>
            <th className="px-6 py-3 text-center">Empleado</th>
            <th className="px-6 py-3 text-center">Estado</th>
            <th className="px-6 py-3 text-center">Nombre del Animal</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {data.map((tarea) => (
            <tr key={tarea.idTareas} className="border-b hover:bg-gray-100 transition duration-200">
              <td className="px-6 py-4 text-center">{tarea.idTareas}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreTarea}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreEmpleado}</td>
              <td className="px-6 py-4 text-center">{tarea.estado}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreAni}</td>
            <td className="px-6 py-4 text-center">
            <button
              onClick={() => cambiarEstadoTarea(tarea.idTareas)}
              disabled={loading}
              className={`px-4 py-2 rounded-lg text-white ${
                loading ? 'bg-gray-400 cursor-not-allowed' : 'bg-green-500 hover:bg-green-600'
              } transition duration-300`}
            >
              {loading ? 'Procesando...' : 'Marcar como lista'}
            </button>
          </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
