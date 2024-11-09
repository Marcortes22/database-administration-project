// Components/TareasEmpleadoReport.tsx
'use client';

import React, { useState } from 'react';
import ControlAnimalEmpleadoTable from './ControlAnimalEmpleadoTable';
import { useMantenimientoTareasEmpleado } from '@/Hooks/useControlMantenimientoEmpleado';
import { useControlAnimalTareasEmpleado } from '@/Hooks/useControlAnimalTareaEmpleado';
import MantenimientoEmpleadoTable from './ControlMantenimientoEmpleadoTable';

export default function TareasEmpleadoReport() {
  const [selectedReport, setSelectedReport] = useState<'controlAnimal' | 'mantenimientoHabitacion'>('controlAnimal');
  const { tareas: controlAnimalData, loading: loadingControlAnimal, error: errorControlAnimal } = useControlAnimalTareasEmpleado();
  const { tareas: mantenimientoData, loading: loadingMantenimiento, error: errorMantenimiento } = useMantenimientoTareasEmpleado();

  const handleReportChange = (reportType: 'controlAnimal' | 'mantenimientoHabitacion') => {
    setSelectedReport(reportType);
  };

  const renderTable = () => {
    if (selectedReport === 'controlAnimal') {
      if (loadingControlAnimal) return <p className="text-center">Cargando tareas de control animal...</p>;
      if (errorControlAnimal) return <p className="text-red-500 text-center">Error al cargar las tareas de control animal.</p>;
      return controlAnimalData ? <ControlAnimalEmpleadoTable data={controlAnimalData} /> : null;
    } else if (selectedReport === 'mantenimientoHabitacion') {
      if (loadingMantenimiento) return <p className="text-center">Cargando tareas de mantenimiento...</p>;
      if (errorMantenimiento) return <p className="text-red-500 text-center">Error al cargar las tareas de mantenimiento.</p>;
      return mantenimientoData ? <MantenimientoEmpleadoTable data={mantenimientoData} /> : null;
    }
    return null;
  };

  return (
    <div className="text-center mt-4">
      <h2 className="text-2xl font-semibold mb-4">Reporte de Tareas por Empleado</h2>
      <div className="flex justify-center space-x-4 mb-4">
        <button
          onClick={() => handleReportChange('controlAnimal')}
          className={`px-4 py-2 rounded ${selectedReport === 'controlAnimal' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Mantenimiento de Habitacion
        </button>
        <button
          onClick={() => handleReportChange('mantenimientoHabitacion')}
          className={`px-4 py-2 rounded ${selectedReport === 'mantenimientoHabitacion' ? 'bg-blue-500 text-white' : 'bg-gray-200 text-gray-700'}`}
        >
          Control Animal
        </button>
      </div>
      {renderTable()}
    </div>
  );
}
