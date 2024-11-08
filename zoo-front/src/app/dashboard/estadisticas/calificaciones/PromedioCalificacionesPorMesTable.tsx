// Components/PromedioCalificacionesPorMesTable.tsx
'use client';

import { PromedioCalificacionesPorMes } from '@/Types/next-auth-types/PromedioCalificacionesPorMes';
import React from 'react';

interface PromedioCalificacionesPorMesTableProps {
  data: PromedioCalificacionesPorMes[];
}

export default function PromedioCalificacionesPorMesTable({ data }: PromedioCalificacionesPorMesTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6 text-center">Promedio de Calificaciones por Mes</h2>
      <table className="w-full text-center text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3">Año</th>
            <th className="px-6 py-3">Mes</th>
            <th className="px-6 py-3">Promedio Nota Final</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 font-medium">{item.anio}</td>
              <td className="px-6 py-4">{item.mes}</td>
              <td className="px-6 py-4">{item.promedioNotaFinal}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
