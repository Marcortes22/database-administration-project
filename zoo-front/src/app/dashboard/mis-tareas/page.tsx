'use client';
import { useAnimales } from '@/Hooks/useAnimales';
import { useCambiarEstadoTarea } from '@/Hooks/useCambiarEstado';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useTareasByEmpleado } from '@/Hooks/useMisTareas';

export default function MisTareas() {
  const { tareas, loading, error } = useTareasByEmpleado();
  const { animales } = useAnimales();
  const { habitaciones } = useHabitaciones();
  const { cambiarEstadoTarea, loading: loadingAction } = useCambiarEstadoTarea();

  const obtenerNombreAnimal = (id: number) =>
    animales.find((animal) => animal.idAnimales === id)?.nombreAni;

  const obtenerNombreHabitacion = (id: number) =>
    habitaciones.find((habitacion) => habitacion.idHabitacion === id)?.nombreHab;

  const handleAprobarTarea = (idTarea: number) => {
    const payload = { idTarea, idEstadoTarea: 3 }; 
    cambiarEstadoTarea(payload);
  };

  if (loading) {
    return <p className="text-center">Cargando tareas...</p>;
  }

  if (error) {
    return <p className="text-center text-red-500">Error: {error}</p>;
  }

  if (!tareas || tareas.length === 0) {
    return <p className="text-center text-gray-500">No hay tareas disponibles.</p>;
  }

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <h2 className="text-3xl font-bold text-gray-800 text-center mb-6">Mis Tareas</h2>
      <table className="w-full border-collapse border border-gray-300">
        <thead>
          <tr className="bg-gray-200">
            <th className="border border-gray-300 px-4 py-2">Tarea</th>
            <th className="border border-gray-300 px-4 py-2">Estado</th>
            <th className="border border-gray-300 px-4 py-2">Descripción</th>
            <th className="border border-gray-300 px-4 py-2">Asignación</th>
            <th className="border border-gray-300 px-4 py-2">Acción</th>
          </tr>
        </thead>
        <tbody>
          {tareas.map((tarea) => (
            <tr key={tarea.idTareas} className="text-center">
              <td className="border border-gray-300 px-4 py-2">
                {tarea.idTipoTareaNavigation?.nombreTt || 'N/A'}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                {tarea.idEstadoTareaNavigation?.nombre || 'N/A'}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                {tarea.controlAnimals?.length > 0 ? (
                  tarea.controlAnimals.map((control) => (
                    <div key={`control-${control.idControl}`}>{control.nombre}</div>
                  ))
                ) : (
                  tarea.mantenimientoHabitacions?.map((habitacion) => (
                    <div key={`habitacion-${habitacion.idMantenimientoHabitacion}`}>{habitacion.nombre}</div>
                  ))
                )}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                {tarea.controlAnimals?.length > 0 ? (
                  tarea.controlAnimals.map((control) => (
                    <div key={`animal-${control.idControl}`}>
                      {obtenerNombreAnimal(control.idAnimales)}
                    </div>
                  ))
                ) : (
                  tarea.mantenimientoHabitacions?.map((habitacion) => (
                    <div key={`habitacion-nombre-${habitacion.idMantenimientoHabitacion}`}>
                      Habitación {obtenerNombreHabitacion(habitacion.idHabitacion)}
                    </div>
                  ))
                )}
              </td>
              <td className="border border-gray-300 px-4 py-2">
                <button
                  onClick={() => handleAprobarTarea(tarea.idTareas)}
                  disabled={loadingAction}
                  className={`px-4 py-2 rounded-lg text-white ${
                    loadingAction
                      ? 'bg-gray-400 cursor-not-allowed'
                      : 'bg-green-500 hover:bg-green-600'
                  } transition duration-300`}
                >
                  {loadingAction ? 'Aprobando...' : 'Aprobar'}
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
