'use client';

import React, { useState } from 'react';
import HistorialMovimientosTable from './HistorialMovimientosTable';
import { useHistorialMovimientos } from '@/Hooks/useHistorialMovimientos';
import { useHistorialMovimientosAnimal } from '@/Hooks/useHistorialMovimientosAnimal';
import HistorialMovimientosAnimalTable from './HistorialMovimientosAnimalTable.tsx';

export default function HistorialMovimientosReport() {
    const [selectedReport, setSelectedReport] = useState<'historialMovimientos' | 'historialMovimientosAnimal'>('historialMovimientos');
    const { data: movimientosData, loading: loadingMovimientos, error: errorMovimientos } = useHistorialMovimientos();
    const { data: animalData, loading: loadingAnimal, error: errorAnimal } = useHistorialMovimientosAnimal();

    const handleReportChange = (reportType: 'historialMovimientos' | 'historialMovimientosAnimal') => {
        setSelectedReport(reportType);
    };

    const renderTable = () => {
        if (selectedReport === 'historialMovimientos') {
            if (loadingMovimientos) return <p className="text-center">Cargando historial de movimientos...</p>;
            if (errorMovimientos) return <p className="text-red-500 text-center">Error al cargar el historial de movimientos.</p>;
            return movimientosData ? <HistorialMovimientosTable data={movimientosData} /> : null;
        }

        if (selectedReport === 'historialMovimientosAnimal') {
            if (loadingAnimal) return <p className="text-center">Cargando historial de movimientos por animal...</p>;
            if (errorAnimal) return <p className="text-red-500 text-center">Error al cargar el historial de movimientos por animal.</p>;
            return animalData ? <HistorialMovimientosAnimalTable data={animalData} /> : null;
        }

        return null;
    };

    return (
        <div className="text-center mt-4">
            <h2 className="text-2xl font-semibold mb-4">Reporte de Historial de Movimientos</h2>
            <div className="flex justify-center space-x-4">
                <button
                    onClick={() => handleReportChange('historialMovimientos')}
                    className={`px-4 py-2 rounded ${selectedReport === 'historialMovimientos' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
                >
                    Historial de Movimientos
                </button>
                <button
                    onClick={() => handleReportChange('historialMovimientosAnimal')}
                    className={`px-4 py-2 rounded ${selectedReport === 'historialMovimientosAnimal' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
                >
                    Historial de Movimientos por Animal
                </button>
            </div>
            {renderTable()}
        </div>
    );
}
