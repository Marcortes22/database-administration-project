// Components/PorcentajeTareasCompletadasPorTipoTable.tsx
'use client';
import { PorcentajeTareasCompletadasPorTipo } from '@/Types/next-auth-types/PorcentajeTareasCompletas';
import React from 'react';

interface PorcentajeTareasCompletadasPorTipoTableProps {
  data: PorcentajeTareasCompletadasPorTipo[];
}

export default function PorcentajeTareasCompletadasPorTipoTable({
  data,
}: PorcentajeTareasCompletadasPorTipoTableProps) {
  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <h2 className="text-2xl font-bold text-gray-700 mb-6">
        Porcentaje de Tareas Completadas por Tipo
      </h2>
      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Tipo de Tarea</th>
            <th className="px-6 py-3 text-center">Porcentaje Completado</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center">{item.tipoTarea}</td>
              <td className="px-6 py-4 text-center">
                {item.porcentajeCompletado}%
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
