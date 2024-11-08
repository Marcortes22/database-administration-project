// Components/VentasPorEntradaYtipoTable.tsx
'use client';

import { VentasPorEntradaYtipoReporte } from '@/Types/next-auth-types/VentasPorEntradaYTipo';
import React from 'react';

interface VentasPorEntradaYtipoTableProps {
  data: VentasPorEntradaYtipoReporte[];
}

export default function VentasPorEntradaYtipoTable({ data }: VentasPorEntradaYtipoTableProps) {
  return (
    <div className="mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Ventas por Entrada y Tipo</h2>
      <table className="min-w-full bg-white border border-gray-300">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Tipo de Entrada</th>
            <th className="py-2 px-4 border-b">Cantidad</th>
            <th className="py-2 px-4 border-b">Monto Total</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index}>
              <td className="py-2 px-4 border-b text-center">{item.tipoEntrada}</td>
              <td className="py-2 px-4 border-b text-center">{item.cantidad}</td>
              <td className="py-2 px-4 border-b text-center">${item.montoTotal.toFixed(2)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
