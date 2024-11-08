// Components/TotalVentasTable.tsx
'use client';

import { TotalVentasReporte } from '@/Types/next-auth-types/TotalVentasReporte';
import React from 'react';

export default function TotalVentasTable({ totalVentas, montoTotalVentas }: TotalVentasReporte) {
  return (
    <div>
        <h1 className="text-2xl font-semibold mb-4">Total de Ventas Realizadas</h1>
    <table className="min-w-full bg-white border border-gray-300 mt-4">
      <thead>
        <tr>
          <th className="py-2 px-4 border-b">Total de Ventas</th>
          <th className="py-2 px-4 border-b">Monto Total de Ventas</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td className="py-2 px-4 border-b text-center">{totalVentas}</td>
          <td className="py-2 px-4 border-b text-center">${montoTotalVentas.toFixed(2)}</td>
        </tr>
      </tbody>
    </table>
    </div>
  );
}
