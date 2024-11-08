// Components/Top10DiasConMasVentasTable.tsx
'use client';

import React from 'react';
import { Top10DiasConMasVentas } from '@/Types/next-auth-types/Top10DiasConMasVentas';

interface Top10DiasConMasVentasTableProps {
  data: Top10DiasConMasVentas[];
}

export default function Top10DiasConMasVentasTable({ data }: Top10DiasConMasVentasTableProps) {
  return (
    <div className="mt-4">
      <h2 className="text-2xl font-semibold mb-4">Top 10 Días con Más Ventas</h2>
      <table className="min-w-full bg-white border border-gray-300">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Fecha</th>
            <th className="py-2 px-4 border-b">Total de Ventas</th>
            <th className="py-2 px-4 border-b">Monto Total de Ventas</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index}>
              <td className="py-2 px-4 border-b text-center">{item.fecha}</td>
              <td className="py-2 px-4 border-b text-center">{item.totalVentas}</td>
              <td className="py-2 px-4 border-b text-center">${item.montoTotalVentas.toFixed(2)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
