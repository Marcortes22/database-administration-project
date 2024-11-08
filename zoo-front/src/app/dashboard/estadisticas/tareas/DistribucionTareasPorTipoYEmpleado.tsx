// Components/DistribucionTareasPorTipoYEmpleadoTable.tsx
'use client';

import { DistribucionTareasPorTipoYEmpleado } from '@/Types/next-auth-types/DistribucionTareasPorTipoYEmpleado';
import React from 'react';

interface DistribucionTareasPorTipoYEmpleadoTableProps {
  data: DistribucionTareasPorTipoYEmpleado[];
}

export default function DistribucionTareasPorTipoYEmpleadoTable({ data }: DistribucionTareasPorTipoYEmpleadoTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Distribución de Tareas por Tipo y Empleado</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Cedula Empleado</th>
            <th className="px-6 py-3 text-center">Nombre Completo</th>
            <th className="px-6 py-3 text-center">Tipo de Tarea</th>
            <th className="px-6 py-3 text-center">Total de Tareas</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item) => (
            <tr key={item.idEmpleado} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{item.idEmpleado}</td>
              <td className="px-6 py-4 text-center">{item.nombreCompleto}</td>
              <td className="px-6 py-4 text-center">{item.tipoTarea}</td>
              <td className="px-6 py-4 text-center">{item.totalTareas}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
