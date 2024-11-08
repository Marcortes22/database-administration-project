// Components/PromedioCalificacionesTable.tsx
'use client';

import { PromedioCalificaciones } from '@/Types/next-auth-types/PromedioCalificaciones ';
import React from 'react';

interface PromedioCalificacionesTableProps {
  data: PromedioCalificaciones;
}

export default function PromedioCalificacionesTable({ data }: PromedioCalificacionesTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Promedio de Calificaciones</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Promedio Nota Recorrido</th>
            <th className="px-6 py-3 text-center">Promedio Nota Servicio Cliente</th>
            <th className="px-6 py-3 text-center">Promedio Nota Final</th>
          </tr>
        </thead>
        <tbody>
          <tr className="border-b hover:bg-gray-100">
            <td className="px-6 py-4 text-center font-medium">{data.promedioNotaRecorrido}</td>
            <td className="px-6 py-4 text-center">{data.promedioNotaServicioCliente}</td>
            <td className="px-6 py-4 text-center">{data.promedioNotaFinal}</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
