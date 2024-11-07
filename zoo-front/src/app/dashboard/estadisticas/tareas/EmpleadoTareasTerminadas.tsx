// Components/EmpleadosTareasTerminadasTable.tsx
'use client';

import { EmpleadoTareaTerminada } from '@/Types/next-auth-types/EmpleadoTareasTerminadas';
import React from 'react';

interface EmpleadosTareasTerminadasTableProps {
  data: EmpleadoTareaTerminada[];
}

export default function EmpleadosTareasTerminadasTable({ data }: EmpleadosTareasTerminadasTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Reporte de Tareas Terminadas por Empleados</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Cedula Empleado</th>
            <th className="px-6 py-3 text-center">Nombre Completo</th>
            <th className="px-6 py-3 text-center">Puesto</th>
            <th className="px-6 py-3 text-center">Tareas Completadas</th>
          </tr>
        </thead>
        <tbody>
          {data.map((empleado) => (
            <tr key={empleado.idEmpleado} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{empleado.idEmpleado}</td>
              <td className="px-6 py-4 text-center">{empleado.nombreCompleto}</td>
              <td className="px-6 py-4 text-center">{empleado.puesto}</td>
              <td className="px-6 py-4 text-center">{empleado.tareasCompletadas}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
