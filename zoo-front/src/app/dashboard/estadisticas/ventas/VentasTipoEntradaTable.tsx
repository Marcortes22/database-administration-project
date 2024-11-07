// Components/VentasPorTipoEntradaTable.tsx
'use client';

import React from 'react';
import { VentasPorTipoEntrada } from '@/Types/next-auth-types/VentasPorTipoEntrada';

interface VentasPorTipoEntradaTableProps {
  data: VentasPorTipoEntrada[];
}

export default function VentasPorTipoEntradaTable({ data }: VentasPorTipoEntradaTableProps) {
  return (
    <div className="mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Ventas por Tipo de Entrada</h2>
      <table className="min-w-full bg-white border border-gray-300">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Tipo de Entrada</th>
            <th className="py-2 px-4 border-b">Total de Entradas</th>
            <th className="py-2 px-4 border-b">Monto Total de Ventas</th>
          </tr>
        </thead>
        <tbody>
          {data.map((entry, index) => (
            <tr key={index}>
              <td className="py-2 px-4 border-b text-center">{entry.tipoEntrada}</td>
              <td className="py-2 px-4 border-b text-center">{entry.totalEntradas}</td>
              <td className="py-2 px-4 border-b text-center">${entry.montoTotalVentas.toFixed(2)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
