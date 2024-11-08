// Components/VentasPorVisitanteTable.tsx
'use client';

import React from 'react';
import { VentasPorVisitanteReporte } from '@/Types/next-auth-types/VentasPorVisitante';
import { div } from 'framer-motion/client';

interface VentasPorVisitanteTableProps {
  data: VentasPorVisitanteReporte[];
}

const VentasPorVisitanteTable: React.FC<VentasPorVisitanteTableProps> = ({ data }) => {
  return (
    <div>
      <h1 className="text-2xl font-semibold mb-4">Ventas Realizadas por Visitante</h1>
    <table className="min-w-full bg-white border border-gray-300 mt-4">
      <thead>
        <tr>
          <th className="py-2 px-4 border-b">Visitante</th>
          <th className="py-2 px-4 border-b">Total de Compras</th>
          <th className="py-2 px-4 border-b">Gasto Total</th>
        </tr>
      </thead>
      <tbody>
        {data.map((report, index) => (
          <tr key={index}>
            <td className="py-2 px-4 border-b text-center">{report.visitante}</td>
            <td className="py-2 px-4 border-b text-center">{report.totalCompras}</td>
            <td className="py-2 px-4 border-b text-center">${report.gastoTotal.toFixed(2)}</td>
          </tr>
        ))}
      </tbody>
    </table>
    </div>
  );
};

export default VentasPorVisitanteTable;
