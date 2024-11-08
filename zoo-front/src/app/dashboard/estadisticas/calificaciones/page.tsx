// Components/CalificacionesReportTable.tsx
'use client';

import React, { useState } from 'react';
import { useCalificacionesPorFecha } from '@/Hooks/useCalificacionVisitaPorFecha';
import { usePromedioCalificacionesPorMes } from '@/Hooks/usePromedioCalificacionesPorMes';
import PromedioCalificacionesTable from './PromedioCalificacionesTable';
import PromedioCalificacionesPorMesTable from './PromedioCalificacionesPorMesTable';
import CalificacionesPorFechaTable from './CalificacionsPorFechaTable';
import { usePromedioCalificaciones } from '@/Hooks/usePromedioCalificaciones ';

export default function CalificacionesReportTable() {
  const [selectedReport, setSelectedReport] = useState<'calificacionesPorFecha' | 'promedioCalificaciones' | 'promedioCalificacionesPorMes'>('calificacionesPorFecha');
  const { data: calificacionesData, loading: loadingCalificaciones, error: errorCalificaciones } = useCalificacionesPorFecha();
  const { data: promedioData, loading: loadingPromedio, error: errorPromedio } = usePromedioCalificaciones();
  const { data: promedioMesData, loading: loadingPromedioMes, error: errorPromedioMes } = usePromedioCalificacionesPorMes();

  const handleReportChange = (reportType: 'calificacionesPorFecha' | 'promedioCalificaciones' | 'promedioCalificacionesPorMes') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'calificacionesPorFecha') {
      if (loadingCalificaciones) return <p className="text-center">Cargando reporte de calificaciones por fecha...</p>;
      if (errorCalificaciones) return <p className="text-red-500 text-center">Error al cargar el reporte de calificaciones por fecha.</p>;
      return calificacionesData ? <CalificacionesPorFechaTable data={calificacionesData} /> : null;
    } else if (selectedReport === 'promedioCalificaciones') {
      if (loadingPromedio) return <p className="text-center">Cargando reporte de promedio de calificaciones...</p>;
      if (errorPromedio) return <p className="text-red-500 text-center">Error al cargar el reporte de promedio de calificaciones.</p>;
      return promedioData ? <PromedioCalificacionesTable data={promedioData} /> : null;
    } else if (selectedReport === 'promedioCalificacionesPorMes') {
      if (loadingPromedioMes) return <p className="text-center">Cargando reporte de promedio de calificaciones por mes...</p>;
      if (errorPromedioMes) return <p className="text-red-500 text-center">Error al cargar el reporte de promedio de calificaciones por mes.</p>;
      return promedioMesData ? <PromedioCalificacionesPorMesTable data={promedioMesData} /> : null;
    }
    return null;
  };

  return (
    <div className="text-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Calificaciones</h2>
      <div className="flex justify-center space-x-4">
        <button
          onClick={() => handleReportChange('calificacionesPorFecha')}
          className={`px-4 py-2 rounded ${selectedReport === 'calificacionesPorFecha' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Calificaciones por Fecha
        </button>
        <button
          onClick={() => handleReportChange('promedioCalificaciones')}
          className={`px-4 py-2 rounded ${selectedReport === 'promedioCalificaciones' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Promedio de Calificaciones
        </button>
        <button
          onClick={() => handleReportChange('promedioCalificacionesPorMes')}
          className={`px-4 py-2 rounded ${selectedReport === 'promedioCalificacionesPorMes' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Promedio de Calificaciones por Mes
        </button>
      </div>
      {renderTable()}
    </div>
  );
}
