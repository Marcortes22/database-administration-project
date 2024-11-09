// Components/ControlAnimalTable.tsx
'use client';

import { ControlAnimalTarea } from '@/Types/next-auth-types/ControlAnimal';
import React from 'react';

interface ControlAnimalTableProps {
  data: ControlAnimalTarea[];
}

export default function ControlAnimalTable({ data }: ControlAnimalTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-semibold text-gray-700 mb-6">Tareas de Control Animal</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Tarea</th>
            <th className="px-6 py-3 text-center">Empleado</th>
            <th className="px-6 py-3 text-center">Estado</th>
            <th className="px-6 py-3 text-center">Animal</th>
          </tr>
        </thead>
        <tbody>
          {data.map((tarea) => (
            <tr key={tarea.idTareas} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center">{tarea.nombreTarea}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreEmpleado}</td>
              <td className="px-6 py-4 text-center">{tarea.estado}</td>
              <td className="px-6 py-4 text-center">{tarea.nombreAni}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
