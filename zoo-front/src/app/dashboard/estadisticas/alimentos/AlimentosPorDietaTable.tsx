// Components/CalificacionesPorFechaTable.tsx
'use client';
import { AlimentosPorDieta } from '@/Types/next-auth-types/AlimentosPorDieta';
import { CalificacionesPorFecha } from '@/Types/next-auth-types/CalificacionVisitaPorFecha';
import React from 'react';

interface AlimentosPorDietaProps {
  data: AlimentosPorDieta[];
}

export default function AlimentosPorDietaTable({ data }: AlimentosPorDietaProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">Alimentos por Dieta</h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Dieta</th>
            <th className="px-6 py-3 text-center">alimentos</th>
            <th className="px-6 py-3 text-center">Unidad de Medida</th>
            <th className="px-6 py-3 text-center">Cantidad Total</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{item.dieta}</td>
              <td className="px-6 py-4 text-center">{item.alimento}</td>
              <td className="px-6 py-4 text-center">{item.unidadMedida}</td>
              <td className="px-6 py-4 text-center">{item.cantidadTotal}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
