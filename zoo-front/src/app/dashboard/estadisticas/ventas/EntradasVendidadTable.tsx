// Components/EntradasVendidasTable.tsx
'use client';

import { EntradasVendidas } from '@/Types/next-auth-types/EntradasVendidad';
import React from 'react';

interface EntradasVendidasTableProps {
  data: EntradasVendidas;
}

export default function EntradasVendidasTable({ data }: EntradasVendidasTableProps) {
  return (
    <div className="mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Entradas Vendidas</h2>
      <table className="min-w-full bg-white border border-gray-300">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Total de Entradas Vendidas</th>
            <th className="py-2 px-4 border-b">Monto Total de Ventas</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td className="py-2 px-4 border-b text-center">{data.totalEntradasVendidas}</td>
            <td className="py-2 px-4 border-b text-center">${data.montoTotalVentas.toFixed(2)}</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
