'use client';

import { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
import { FaFilter, FaChartBar } from 'react-icons/fa';

interface VentaEntrada {
  id: number;
  tipo: string;
  fecha: string;
  cantidad: number;
  total: number;
}

const ventasSimuladas: VentaEntrada[] = [
  { id: 1, tipo: 'Adulto', fecha: '2024-10-15', cantidad: 50, total: 500 },
  { id: 2, tipo: 'Niño', fecha: '2024-10-15', cantidad: 30, total: 150 },
  { id: 3, tipo: 'Grupo', fecha: '2024-10-16', cantidad: 20, total: 200 },
];

export default function VentasEntradas() {
  const [ventas, setVentas] = useState<VentaEntrada[]>(ventasSimuladas);
  const [filtroFecha, setFiltroFecha] = useState('');
  const [totalRecaudado, setTotalRecaudado] = useState(0);

  useEffect(() => {
    calcularTotalRecaudado();
  }, [ventas]);

  const calcularTotalRecaudado = () => {
    const total = ventas.reduce((acc, venta) => acc + venta.total, 0);
    setTotalRecaudado(total);
  };

  const filtrarPorFecha = (fecha: string) => {
    const ventasFiltradas = ventasSimuladas.filter((venta) => venta.fecha === fecha);
    setVentas(ventasFiltradas);
    toast.success(`Filtrado por la fecha: ${fecha}`, {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
  };

  return (
    <div className="min-h-screen p-8">
      <h1 className="text-3xl font-bold text-center mb-8">Ventas de Entradas</h1>

      <div className="flex justify-between items-center mb-6">
        <div className="flex items-center">
          <input
            type="date"
            className="border rounded-md px-3 py-2 mr-4"
            value={filtroFecha}
            onChange={(e) => setFiltroFecha(e.target.value)}
          />
          <button
            onClick={() => filtrarPorFecha(filtroFecha)}
            className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 transition duration-300 flex items-center"
          >
            <FaFilter className="mr-2" /> Filtrar
          </button>
        </div>
        <h2 className="text-xl font-semibold text-gray-700">
          Total Recaudado: <span className="text-green-600">${totalRecaudado}</span>
        </h2>
      </div>

      <table className="w-full bg-white rounded-lg shadow-md overflow-hidden">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-4 py-2">ID</th>
            <th className="px-4 py-2">Tipo de Entrada</th>
            <th className="px-4 py-2">Fecha</th>
            <th className="px-4 py-2">Cantidad</th>
            <th className="px-4 py-2">Total</th>
          </tr>
        </thead>
        <tbody>
          {ventas.map((venta) => (
            <tr key={venta.id} className="border-b hover:bg-gray-100">
              <td className="px-4 py-2 text-center">{venta.id}</td>
              <td className="px-4 py-2 text-center">{venta.tipo}</td>
              <td className="px-4 py-2 text-center">{venta.fecha}</td>
              <td className="px-4 py-2 text-center">{venta.cantidad}</td>
              <td className="px-4 py-2 text-center">${venta.total}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
