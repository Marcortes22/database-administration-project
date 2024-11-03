'use client';

import React, { useEffect } from 'react';
import { useTareas } from '@/Hooks/useTareas';
import { useAnimales } from '@/Hooks/useAnimales';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useCustomRouter } from '@/Hooks/Router/useRouter';

export default function TableTareas() {
  const { tareas, loading, error, fetchTareas } = useTareas();
  const { animales } = useAnimales();
  const { habitaciones } = useHabitaciones();
  const { navigateTo } = useCustomRouter();

  useEffect(() => {
    fetchTareas(); // Cargar las tareas al montar el componente
  }, []);

  const obtenerNombreAnimal = (id: number) =>
    animales.find((animal) => animal.idAnimales === id)?.nombreAni || 'Sin Asignación';

  const obtenerNombreHabitacion = (id: number) =>
    habitaciones.find((habitacion) => habitacion.idHabitacion === id)?.nombreHab || 'Sin Asignación';

  if (loading) {
    return (
      <div className="flex justify-center items-center h-96">
        <div className="animate-spin rounded-full h-10 w-10 border-t-4 border-b-4 border-blue-500"></div>
        <p className="text-xl font-semibold text-gray-600 ml-4">Cargando tareas...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-96">
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
          <strong className="font-bold">Error:</strong>
          <span className="block sm:inline"> {error}</span>
        </div>
      </div>
    );
  }

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Lista de Tareas</h2>
        <div className="space-x-4">
          <button
            onClick={() => navigateTo('/dashboard/tareas/MantenimientoHabitacion')}
            className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300"
          >
            Mantenimiento Habitación
          </button>
          <button
            onClick={() => navigateTo('/dashboard/tareas/ControlAnimal')}
            className="bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 transition duration-300"
          >
            Control Animales
          </button>
        </div>
      </div>

      <table className="w-full text-left text-gray-500 bg-white rounded-md">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Tarea</th>
            <th className="px-6 py-3 text-center">Empleado</th>
            <th className="px-6 py-3 text-center">Estado</th>
            <th className="px-6 py-3 text-center">Asignación</th>
          </tr>
        </thead>
        <tbody>
          {tareas.map((tarea) => (
            <tr key={tarea.idTareas} className="border-b hover:bg-gray-100 transition duration-200">
              <td className="px-6 py-4 text-center font-medium">{tarea.idTareas}</td>
              <td className="px-6 py-4 text-center">{tarea.idTipoTareaNavigation?.nombreTt}</td>
              <td className="px-6 py-4 text-center">{tarea.idEmpleadoNavigation?.nombre}</td>
              <td className="px-6 py-4 text-center">{tarea.idEstadoTareaNavigation?.nombre}</td>
              <td className="px-6 py-4 text-center">
                {tarea.controlAnimals.length > 0 ? (
                  tarea.controlAnimals.map((control) => (
                    <div key={control.idControl}>{obtenerNombreAnimal(control.idAnimales)}</div>
                  ))
                ) : (
                  tarea.mantenimientoHabitacions.map((habitacion) => (
                    <div key={habitacion.idMantenimientoHabitacion}>
                      Habitación {obtenerNombreHabitacion(habitacion.idHabitacion)}
                    </div>
                  ))
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
