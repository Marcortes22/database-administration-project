// Components/VentasPorEmpleadoTable.tsx
'use client';

import React from 'react';
import { VentasPorEmpleadoReporte } from '@/Types/next-auth-types/VentasPorEmpleado';

interface VentasPorEmpleadoTableProps {
  data: VentasPorEmpleadoReporte[];
}

const VentasPorEmpleadoTable: React.FC<VentasPorEmpleadoTableProps> = ({ data }) => {
  return (
    <div>
<h1  className="text-2xl font-semibold mb-4">Ventas Realizadas Por Empleado</h1>
    <table className="min-w-full bg-white border border-gray-300 mt-4">
      <thead>
        <tr>
          <th className="py-2 px-4 border-b">Empleado</th>
          <th className="py-2 px-4 border-b">Total de Ventas</th>
          <th className="py-2 px-4 border-b">Monto Total de Ventas</th>
        </tr>
      </thead>
      <tbody>
        {data.map((report, index) => (
          <tr key={index}>
            <td className="py-2 px-4 border-b text-center">{report.empleado}</td>
            <td className="py-2 px-4 border-b text-center">{report.totalVentas}</td>
            <td className="py-2 px-4 border-b text-center">${report.montoTotalVentas.toFixed(2)}</td>
          </tr>
        ))}
      </tbody>
    </table>
    </div>
  );
};

export default VentasPorEmpleadoTable;
