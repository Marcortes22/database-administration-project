// Components/EmpleadosTareasReport.tsx
'use client';

import { useEmpleadosTareasPendientes } from '@/Hooks/useEmpleadoTareasPendientes';
import { useEmpleadosTareasTerminadas } from '@/Hooks/useEmpleadoTareasTerminadas';
import { usePorcentajeTareasCompletadasPorTipo } from '@/Hooks/usePorcentajeTareasCompletas';
import { useResumenTareasPorEstado } from '@/Hooks/useResumenTareaPorEstado';
import { useDistribucionTareasPorTipoYEmpleado } from '@/Hooks/useDistribucionTareasPorTipoYEmpleado';
import React, { useState } from 'react';
import EmpleadosTareasPendientesTable from './EmpleadoTareasPendientes';
import EmpleadosTareasTerminadasTable from './EmpleadoTareasTerminadas';
import PorcentajeTareasCompletadasPorTipoTable from './PorcentajeTareasCompletas';
import ResumenTareasPorEstadoTable from './ResumenTareasPorEstadoTable';
import DistribucionTareasPorTipoYEmpleadoTable from './DistribucionTareasPorTipoYEmpleado';

export default function EmpleadosTareasReport() {
  const [selectedReport, setSelectedReport] = useState<'pendientes' | 'terminadas' | 'porcentaje' | 'resumen' | 'distribucion'>('pendientes');
  const { data: pendientesData, loading: loadingPendientes, error: errorPendientes } = useEmpleadosTareasPendientes();
  const { data: terminadasData, loading: loadingTerminadas, error: errorTerminadas } = useEmpleadosTareasTerminadas();
  const { data: porcentajeData, loading: loadingPorcentaje, error: errorPorcentaje } = usePorcentajeTareasCompletadasPorTipo();
  const { data: resumenData, loading: loadingResumen, error: errorResumen } = useResumenTareasPorEstado();
  const { data: distribucionData, loading: loadingDistribucion, error: errorDistribucion } = useDistribucionTareasPorTipoYEmpleado();

  const handleReportChange = (reportType: 'pendientes' | 'terminadas' | 'porcentaje' | 'resumen' | 'distribucion') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'pendientes') {
      if (loadingPendientes) return <p className="text-center">Cargando reporte de tareas pendientes...</p>;
      if (errorPendientes) return <p className="text-center text-red-500">{errorPendientes}</p>;
      return <EmpleadosTareasPendientesTable data={pendientesData} />;
    } else if (selectedReport === 'terminadas') {
      if (loadingTerminadas) return <p className="text-center">Cargando reporte de tareas terminadas...</p>;
      if (errorTerminadas) return <p className="text-red-500 text-center">{errorTerminadas}</p>;
      return <EmpleadosTareasTerminadasTable data={terminadasData} />;
    } else if (selectedReport === 'porcentaje') {
      if (loadingPorcentaje) return <p className="text-center">Cargando reporte de porcentaje de tareas completadas...</p>;
      if (errorPorcentaje) return <p className="text-red-500 text-center">{errorPorcentaje}</p>;
      return porcentajeData ? <PorcentajeTareasCompletadasPorTipoTable data={porcentajeData} /> : null;
    } else if (selectedReport === 'resumen') {
      if (loadingResumen) return <p className="text-center">Cargando reporte de resumen de tareas por estado...</p>;
      if (errorResumen) return <p className="text-red-500 text-center">{errorResumen}</p>;
      return resumenData ? <ResumenTareasPorEstadoTable data={resumenData} /> : null;
    } else if (selectedReport === 'distribucion') {
      if (loadingDistribucion) return <p className="text-center">Cargando reporte de distribución de tareas por tipo y empleado...</p>;
      if (errorDistribucion) return <p className="text-red-500 text-center">{errorDistribucion}</p>;
      return distribucionData ? <DistribucionTareasPorTipoYEmpleadoTable data={distribucionData} /> : null;
    }
    return null;
  };

  return (
    <div className="text-center justify-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Tareas</h2>
      <div className="flex justify-center space-x-4">
        <button onClick={() => handleReportChange('pendientes')} className={`px-4 py-2 rounded ${selectedReport === 'pendientes' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Tareas Pendientes
        </button>
        <button onClick={() => handleReportChange('terminadas')} className={`px-4 py-2 rounded ${selectedReport === 'terminadas' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Tareas Terminadas
        </button>
        <button onClick={() => handleReportChange('porcentaje')} className={`px-4 py-2 rounded ${selectedReport === 'porcentaje' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Porcentaje Completado por Tipo
        </button>
        <button onClick={() => handleReportChange('resumen')} className={`px-4 py-2 rounded ${selectedReport === 'resumen' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Resumen Tareas por Estado
        </button>
        <button onClick={() => handleReportChange('distribucion')} className={`px-4 py-2 rounded ${selectedReport === 'distribucion' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>
          Distribución de Tareas por Tipo y Empleado
        </button>
      </div>
      {renderTable()}
    </div>
  );
}
