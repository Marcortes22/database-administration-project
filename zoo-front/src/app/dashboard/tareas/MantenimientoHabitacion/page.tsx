// Components/FormularioMantenimientoHabitacion.tsx
'use client';
import { useCrearTarea } from '@/Hooks/useCrearTareas';
import { useEmpleados } from '@/Hooks/useEmpleado';
import { useHabitaciones } from '@/Hooks/useHabitacion';
import { useRouter } from 'next/navigation';
import { useState } from 'react';
import toast from 'react-hot-toast';

export default function FormularioMantenimientoHabitacion() {
  const { empleados } = useEmpleados();
  const { habitaciones } = useHabitaciones();
  const { crearMantenimientoHabitacion } = useCrearTarea();
  const [nombreTarea, setNombreTarea] = useState('');
  const [idEmpleado, setIdEmpleado] = useState<number | null>(null);
  const [idHabitacion, setIdHabitacion] = useState<number | null>(null);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!nombreTarea || !idEmpleado || !idHabitacion) {
      toast.error('Por favor, completa todos los campos.');
      return;
    }

    await crearMantenimientoHabitacion({ idHabitacion, idEmpleado, nombreTarea });
    router.push('/dashboard/tareas'); // Redirige a la lista de tareas después de la creación
  };

  const handleCancel = () => {
    router.push('/dashboard/tareas'); // Redirige a la lista de tareas al cancelar
  };

  return (
    <div className="max-w-md mx-auto bg-white shadow-lg rounded-lg p-6">
      <h2 className="text-2xl font-bold mb-4">Mantenimiento Habitación</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label className="block text-sm font-medium">Nombre de Tarea</label>
          <input
            type="text"
            className="w-full p-2 border rounded"
            value={nombreTarea}
            onChange={(e) => setNombreTarea(e.target.value)}
          />
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium">Empleado</label>
          <select className="w-full p-2 border rounded" value={idEmpleado || ''} onChange={(e) => setIdEmpleado(Number(e.target.value))}>
            <option value="">Seleccione un empleado</option>
            {empleados.map((empleado) => (
              <option key={empleado.idEmpleado} value={empleado.idEmpleado}>
                {empleado.nombre} {empleado.apellido1}
              </option>
            ))}
          </select>
        </div>
        <div className="mb-4">
          <label className="block text-sm font-medium">Habitación</label>
          <select className="w-full p-2 border rounded" value={idHabitacion || ''} onChange={(e) => setIdHabitacion(Number(e.target.value))}>
            <option value="">Seleccione una habitación</option>
            {habitaciones.map((habitacion) => (
              <option key={habitacion.idHabitacion} value={habitacion.idHabitacion}>
                {habitacion.nombreHab}
              </option>
            ))}
          </select>
        </div>
        <div className="flex justify-end space-x-4">
          <button
            type="button"
            onClick={handleCancel}
            className="bg-red-500 text-white px-4 py-2 rounded-full hover:bg-red-600 transition duration-300"
          >
            Cancelar
          </button>
          <button
            type="submit"
            className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300"
          >
            Crear Mantenimiento
          </button>
        </div>
      </form>
    </div>
  );
}
