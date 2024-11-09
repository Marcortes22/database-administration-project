// Components/TareasReport.tsx
'use client';

import React, { useState } from 'react';
import ControlAnimalTable from './ControlAnimalTable';
import MantenimientoHabitacionTable from './MantenimientoHabitacionTable';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { useControlAnimalTareas } from '@/Hooks/useControlAnimal';
import { useMantenimientoHabitacionTareas } from '@/Hooks/useMantenimientoHabitacion';

export default function TareasReport() {
  const [selectedReport, setSelectedReport] = useState<'controlAnimal' | 'mantenimientoHabitacion'>('controlAnimal');
  const { tareas: controlAnimalData, loading: loadingControlAnimal, error: errorControlAnimal } = useControlAnimalTareas();
  const { tareas: mantenimientoData, loading: loadingMantenimiento, error: errorMantenimiento } = useMantenimientoHabitacionTareas();
  const { navigateTo } = useCustomRouter();

  const handleReportChange = (reportType: 'controlAnimal' | 'mantenimientoHabitacion') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'controlAnimal') {
      if (loadingControlAnimal) return <p className="text-center">Cargando tareas de control animal...</p>;
      if (errorControlAnimal) return <p className="text-red-500 text-center">Error al cargar las tareas de control animal.</p>;
      return controlAnimalData ? <ControlAnimalTable data={controlAnimalData} /> : null;
    }

    if (selectedReport === 'mantenimientoHabitacion') {
      if (loadingMantenimiento) return <p className="text-center">Cargando tareas de mantenimiento de habitación...</p>;
      if (errorMantenimiento) return <p className="text-red-500 text-center">Error al cargar las tareas de mantenimiento de habitación.</p>;
      return mantenimientoData ? <MantenimientoHabitacionTable data={mantenimientoData} /> : null;
    }

    return null;
  };

  return (
    <div className="text-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Tareas</h2>
      
      {/* Botones de navegación para redirigir */}
      <div className="flex justify-end mb-6 space-x-4">
        <button
          onClick={() => navigateTo('/dashboard/tareas/ControlAnimal')}
          className="bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 transition duration-300"
        >
          Ir a Control de Animal
        </button>
        <button
          onClick={() => navigateTo('/dashboard/tareas/MantenimientoHabitacion')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300"
        >
          Ir a Mantenimiento de Habitación
        </button>
      </div>

      {/* Botones para cambiar entre reportes */}
      <div className="flex justify-center space-x-4 mb-4">
        <button
          onClick={() => handleReportChange('controlAnimal')}
          className={`px-4 py-2 rounded ${selectedReport === 'controlAnimal' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Control de Animal
        </button>
        <button
          onClick={() => handleReportChange('mantenimientoHabitacion')}
          className={`px-4 py-2 rounded ${selectedReport === 'mantenimientoHabitacion' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Mantenimiento de Habitación
        </button>
      </div>

      {/* Renderizado de la tabla según el reporte seleccionado */}
      {renderTable()}
    </div>
  );
}
