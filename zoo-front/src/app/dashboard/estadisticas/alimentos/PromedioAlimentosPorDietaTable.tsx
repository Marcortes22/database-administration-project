// Components/PromedioAlimentosPorDietaTable.tsx
'use client';
import React from 'react';
import { PromedioAlimentosPorDieta } from '@/Types/next-auth-types/PromedioAlimentosPorDieta';

interface PromedioAlimentosPorDietaProps {
  data: PromedioAlimentosPorDieta[];
}

export default function PromedioAlimentosPorDietaTable({ data }: PromedioAlimentosPorDietaProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Promedio de Alimentos por Dieta</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Alimento</th>
            <th className="px-6 py-3 text-center">Promedio Cantidad</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{item.alimento}</td>
              <td className="px-6 py-4 text-center">{item.promedioCantidad}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
