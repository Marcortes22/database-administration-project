'use client';

import React, { useState } from 'react';
import AlimentosPorDietaTable from './AlimentosPorDietaTable';
import { useAlimentosPorDieta } from '@/Hooks/useAlimentoPorDieta';

export default function AlimentosReport() {
    const [selectedReport, setSelectedReport] = useState<'alimentosPorDieta'>('alimentosPorDieta');
    const { data: alimentosData, loading: loadingAlimentos, error: errorAlimentos } = useAlimentosPorDieta();

    const handleReportChange = (reportType: 'alimentosPorDieta') => {
        setSelectedReport(reportType);
    };

    const renderTable = () => {
        if (selectedReport === 'alimentosPorDieta') {
            if (loadingAlimentos) return <p className="text-center">Cargando reporte de alimentos por dieta...</p>;
            if (errorAlimentos) return <p className="text-red-500 text-center">Error al cargar el reporte de alimentos por dieta.</p>;
            return alimentosData ? <AlimentosPorDietaTable data={alimentosData} /> : null;
        }
        return null;
    };

    return (
        <div className="text-center mt-4">
            <h2 className="text-2xl font-semibold mb-4">Reporte de Alimentos</h2>
            <div className="flex justify-center space-x-4">
                <button
                    onClick={() => handleReportChange('alimentosPorDieta')}
                    className={`px-4 py-2 rounded ${selectedReport === 'alimentosPorDieta' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
                >
                    Alimentos por Dieta
                </button>
            </div>
            {renderTable()}
        </div>
    );
}