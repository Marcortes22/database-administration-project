// Components/CalificacionesPorFechaTable.tsx
'use client';

import { CalificacionesPorFecha } from '@/Types/next-auth-types/CalificacionVisitaPorFecha';
import React from 'react';

interface CalificacionesPorFechaTableProps {
  data: CalificacionesPorFecha[];
}

export default function CalificacionesPorFechaTable({ data }: CalificacionesPorFechaTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Calificaciones por Fecha</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Fecha</th>
            <th className="px-6 py-3 text-center">Promedio Nota Recorrido</th>
            <th className="px-6 py-3 text-center">Promedio Nota Servicio Cliente</th>
            <th className="px-6 py-3 text-center">Promedio Nota Final</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{item.fecha}</td>
              <td className="px-6 py-4 text-center">{item.promedioNotaRecorrido}</td>
              <td className="px-6 py-4 text-center">{item.promedioNotaServicioCliente}</td>
              <td className="px-6 py-4 text-center">{item.promedioNotaFinal}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
