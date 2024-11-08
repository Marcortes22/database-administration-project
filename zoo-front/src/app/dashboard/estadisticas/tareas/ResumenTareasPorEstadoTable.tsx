// Components/ResumenTareasPorEstadoTable.tsx
'use client';

import { ResumenTareasPorEstado } from '@/Types/next-auth-types/ResumenTareaPorEstado';
import React from 'react';

interface ResumenTareasPorEstadoTableProps {
  data: ResumenTareasPorEstado[];
}

export default function ResumenTareasPorEstadoTable({ data }: ResumenTareasPorEstadoTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Resumen de Tareas por Estado</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Estado de Tarea</th>
            <th className="px-6 py-3 text-center">Total de Tareas</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item) => (
            <tr key={item.idEstadoTarea} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center">{item.estadoTarea}</td>
              <td className="px-6 py-4 text-center">{item.totalTareas}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
