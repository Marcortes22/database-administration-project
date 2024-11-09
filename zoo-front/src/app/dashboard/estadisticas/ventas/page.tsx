// Components/VentasReportTable.tsx
'use client';

import React, { useState } from 'react';
import TotalVentasTable from './TotalVentasTable';
import VentasPorEmpleadoTable from './VentasPorEmpleadoTable';
import VentasPorMetodoPagoTable from './VentasPorMetodoPagoTable';
import { useTotalVentasReport } from '@/Hooks/useTotalVentas';
import { useVentasPorDiaReport } from '@/Hooks/useVentasPorDia';
import { useVentasPorEmpleadoReport } from '@/Hooks/useVentasPorEmpleado';
import { useVentasPorMetodoPagoReport } from '@/Hooks/useVentasPorMetodoPago';
import { useVentasPorVisitanteReport } from '@/Hooks/useVentasPorVisitante';
import VentasPorDiaTable from './VentasPodDiaTable';
import VentasPorVisitanteTable from './VentasPorVisitante';
import { useTop10DiasConMasVentas } from '@/Hooks/useTop10DiasConMasVentas';
import { data, i } from 'framer-motion/client';
import Top10DiasConMasVentasTable from './Top10DiasConMasVentasTable';
import { useEntradasVendidas } from '@/Hooks/useEntradasVendidas';
import EntradasVendidasTable from './EntradasVendidadTable';
import { useVentasPorTipoEntrada } from '@/Hooks/useVentasTipoEntrada';
import VentasPorTipoEntradaTable from './VentasTipoEntradaTable';
import VentasPorEntradaYtipoTable from './VentasPorEntradayTipoTable';
import { useVentasPorEntradaYtipoReport } from '@/Hooks/useVentasPorEntradaYTipo';

export default function VentasReportTable() {
  const [selectedReport, setSelectedReport] = useState<'total' | 'dia' | 'empleado' | 'metodoPago' | 'visitante' | 'top10' | 'entradas' | 'tipoEntrada' | 'entradaYtipo'>('total');
  const { data: totalData, loading: loadingTotal, error: errorTotal } = useTotalVentasReport();
  const { data: diaData, loading: loadingDia, error: errorDia } = useVentasPorDiaReport();
  const { data: empleadoData, loading: loadingEmpleado, error: errorEmpleado } = useVentasPorEmpleadoReport();
  const { data: metodoPagoData, loading: loadingMetodoPago, error: errorMetodoPago } = useVentasPorMetodoPagoReport();
  const { data: visitanteData, loading: loadingVisitante, error: errorVisitante } = useVentasPorVisitanteReport();
  const {data: top10Data, loading: loadingTop10, error: errorTop10} = useTop10DiasConMasVentas();
  const { data: entradasData, loading: loadingEntradas, error: errorEntradas } = useEntradasVendidas();
  const { data: tipoEntradaData, loading: loadingTipoEntrada, error: errorTipoEntrada } = useVentasPorTipoEntrada();
  const { data: entradaYtipoData, loading: loadingEntradaYtipo, error: errorEntradaYtipo } = useVentasPorEntradaYtipoReport();


  const handleReportChange = (reportType: 'total' | 'dia' | 'empleado' | 'metodoPago' | 'visitante' | 'top10' | 'entradas' | 'tipoEntrada' | 'entradaYtipo') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'total') {
      if (loadingTotal) return <p>Cargando reporte de ventas totales...</p>;
      if (errorTotal) return <p className="text-red-500">{errorTotal}</p>;
      if (totalData) return <TotalVentasTable totalVentas={totalData.totalVentas} montoTotalVentas={totalData.montoTotalVentas} />;
    } else if (selectedReport === 'dia') {
      if (loadingDia) return <p>Cargando reporte de ventas por día...</p>;
      if (errorDia) return <p className="text-red-500">{errorDia}</p>;
      if (diaData) return <VentasPorDiaTable data={diaData} />;
    } else if (selectedReport === 'empleado') {
      if (loadingEmpleado) return <p>Cargando reporte de ventas por empleado...</p>;
      if (errorEmpleado) return <p className="text-red-500">{errorEmpleado}</p>;
      if (empleadoData) return <VentasPorEmpleadoTable data={empleadoData} />;
    } else if (selectedReport === 'metodoPago') {
      if (loadingMetodoPago) return <p>Cargando reporte de ventas por método de pago...</p>;
      if (errorMetodoPago) return <p className="text-red-500">{errorMetodoPago}</p>;
      if (metodoPagoData) return <VentasPorMetodoPagoTable data={metodoPagoData} />;
    } else if (selectedReport === 'visitante') {
      if (loadingVisitante) return <p>Cargando reporte de ventas por visitante...</p>;
      if (errorVisitante) return <p className="text-red-500">{errorVisitante}</p>;
      if (visitanteData) return <VentasPorVisitanteTable data={visitanteData} />;
    } else if (selectedReport === 'top10') {
      if (loadingTop10) return <p>Cargando reporte de los 10 días con más ventas...</p>;
      if (errorTop10) return <p className="text-red-500">{errorTop10}</p>;
      if (top10Data) return <Top10DiasConMasVentasTable data={top10Data} />;
    }else if (selectedReport === 'entradas') {
        if (loadingEntradas) return <p>Cargando reporte de los 10 días con más ventas...</p>;
        if (errorEntradas) return <p className="text-red-500">{errorEntradas}</p>;
        if (entradasData) return <EntradasVendidasTable data={entradasData} />;
      } else if (selectedReport === 'tipoEntrada') {
        if (loadingTipoEntrada) return <p>Cargando reporte de los 10 días con más ventas...</p>;
        if (errorTipoEntrada) return <p className="text-red-500">{errorTipoEntrada}</p>;
        if (tipoEntradaData) return <VentasPorTipoEntradaTable data={tipoEntradaData} />;
      } else if (selectedReport === 'entradaYtipo') {
        if (loadingEntradaYtipo) return <p>Cargando reporte de los 10 días con más ventas...</p>;
        if (errorEntradaYtipo) return <p className="text-red-500">{errorEntradaYtipo}</p>;
        if (entradaYtipoData) return <VentasPorEntradaYtipoTable data={entradaYtipoData} />;
    return null;
    }
  };

  return (
    <div className="text-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Ventas</h2>
      <div className="flex space-x-4">
        <button
          onClick={() => handleReportChange('total')}
          className={`px-4 py-2 rounded ${selectedReport === 'total' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Ventas Totales
        </button>
        <button
          onClick={() => handleReportChange('dia')}
          className={`px-4 py-2 rounded ${selectedReport === 'dia' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Ventas por Día
        </button>
        <button
          onClick={() => handleReportChange('empleado')}
          className={`px-4 py-2 rounded ${selectedReport === 'empleado' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Ventas por Empleado
        </button>
        <button
          onClick={() => handleReportChange('metodoPago')}
          className={`px-4 py-2 rounded ${selectedReport === 'metodoPago' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Ventas por Método de Pago
        </button>
        <button
          onClick={() => handleReportChange('visitante')}
          className={`px-4 py-2 rounded ${selectedReport === 'visitante' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Ventas por Visitante
        </button>
        <button
          onClick={() => handleReportChange('top10')}
          className={`px-4 py-2 rounded ${selectedReport === 'top10' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Top 10 días con más ventas
        </button>
        <button 
        onClick={() => handleReportChange('entradas')} 
        className={`px-4 py-2 rounded ${selectedReport === 'entradas' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Entradas Vendidas
          </button>
          <button 
        onClick={() => handleReportChange('tipoEntrada')} 
        className={`px-4 py-2 rounded ${selectedReport === 'tipoEntrada' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Ventas por Tipo Entrada
          </button>
      </div>
      {renderTable()}
    </div>
  );
}
