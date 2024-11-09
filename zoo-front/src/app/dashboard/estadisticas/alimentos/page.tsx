// Components/AlimentosReport.tsx
'use client';

import React, { useState } from 'react';
import AlimentosPorDietaTable from './AlimentosPorDietaTable';
import PromedioAlimentosPorDietaTable from './PromedioAlimentosPorDietaTable';
import AlimentosMasUtilizadosTable from './AlimentosMasUtilizadosTable';
import { useAlimentosPorDieta } from '@/Hooks/useAlimentoPorDieta';
import { usePromedioAlimentosPorDieta } from '@/Hooks/usePromedioAlimentosPorDieta';
import { useAlimentosMasUtilizados } from '@/Hooks/useAlimentosMasUtilizados';

export default function AlimentosReport() {
  const [selectedReport, setSelectedReport] = useState<'alimentosPorDieta' | 'promedioAlimentosPorDieta' | 'alimentosMasUtilizados'>('alimentosPorDieta');
  const { data: alimentosData, loading: loadingAlimentos, error: errorAlimentos } = useAlimentosPorDieta();
  const { data: promedioData, loading: loadingPromedio, error: errorPromedio } = usePromedioAlimentosPorDieta();
  const { data: masUtilizadosData, loading: loadingMasUtilizados, error: errorMasUtilizados } = useAlimentosMasUtilizados();

  const handleReportChange = (reportType: 'alimentosPorDieta' | 'promedioAlimentosPorDieta' | 'alimentosMasUtilizados') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'alimentosPorDieta') {
      if (loadingAlimentos) return <p className="text-center">Cargando reporte de alimentos por dieta...</p>;
      if (errorAlimentos) return <p className="text-red-500 text-center">Error al cargar el reporte de alimentos por dieta.</p>;
      return alimentosData ? <AlimentosPorDietaTable data={alimentosData} /> : null;
    }

    if (selectedReport === 'promedioAlimentosPorDieta') {
      if (loadingPromedio) return <p className="text-center">Cargando reporte de promedio de alimentos por dieta...</p>;
      if (errorPromedio) return <p className="text-red-500 text-center">Error al cargar el reporte de promedio de alimentos por dieta.</p>;
      return promedioData ? <PromedioAlimentosPorDietaTable data={promedioData} /> : null;
    }

    if (selectedReport === 'alimentosMasUtilizados') {
      if (loadingMasUtilizados) return <p className="text-center">Cargando reporte de alimentos más utilizados...</p>;
      if (errorMasUtilizados) return <p className="text-red-500 text-center">Error al cargar el reporte de alimentos más utilizados.</p>;
      return masUtilizadosData ? <AlimentosMasUtilizadosTable data={masUtilizadosData} /> : null;
    }

    return null;
  };

  return (
    <div className="text-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Alimentos</h2>
      <div className="flex justify-center space-x-4">
        <button onClick={() => handleReportChange('alimentosPorDieta')} className={`px-4 py-2 rounded ${selectedReport === 'alimentosPorDieta' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>Alimentos por Dieta</button>
        <button onClick={() => handleReportChange('promedioAlimentosPorDieta')} className={`px-4 py-2 rounded ${selectedReport === 'promedioAlimentosPorDieta' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>Promedio Alimentos por Dieta</button>
        <button onClick={() => handleReportChange('alimentosMasUtilizados')} className={`px-4 py-2 rounded ${selectedReport === 'alimentosMasUtilizados' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}>Alimentos Más Utilizados</button>
      </div>
      {renderTable()}
    </div>
  );
}
