// Components/MantenimientoHabitacionTable.tsx
'use client';

import React from 'react';
import { MantenimientoHabitacionTarea } from '@/Types/next-auth-types/MantenimientoHabitacion';

interface MantenimientoHabitacionTableProps {
  data: MantenimientoHabitacionTarea[];
}

export default function MantenimientoHabitacionTable({ data }: MantenimientoHabitacionTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-4">Tareas de Mantenimiento de Habitación</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Tarea</th>
            <th className="px-6 py-3 text-center">Empleado</th>
            <th className="px-6 py-3 text-center">Estado</th>
            <th className="px-6 py-3 text-center">Habitación</th>
          </tr>
        </thead>
        <tbody>
          {data.map((tarea) => (
            <tr key={tarea.idTareas} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center">{tarea.idTareas}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreTarea}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreEmpleado}</td>
              <td className="px-6 py-4 text-center">{tarea.estado}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreHab}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
