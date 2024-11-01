// Components/FormularioControlAnimal.tsx
'use client';
import { useState } from 'react';
import { useAnimales } from '@/Hooks/useAnimales';
import toast from 'react-hot-toast';
import { useCrearTarea } from '@/Hooks/useCrearTareas';
import { useEmpleados } from '@/Hooks/useEmpleado';
import { useRouter } from 'next/navigation';

export default function FormularioControlAnimal() {
  const { empleados } = useEmpleados();
  const { animales } = useAnimales();
  const { crearControlAnimal } = useCrearTarea();
  const [nombreTarea, setNombreTarea] = useState('');
  const [idEmpleado, setIdEmpleado] = useState<number | null>(null);
  const [idAnimal, setIdAnimal] = useState<number | null>(null);
  const router = useRouter();
  

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!nombreTarea || !idEmpleado || !idAnimal) {
      toast.error('Por favor, completa todos los campos.');
      return;
    }

    await crearControlAnimal({ idAnimales: idAnimal, idEmpleado, nombreTarea });

    router.push('/dashboard/tareas');
  };

  return (
    <div className="max-w-md mx-auto bg-white shadow-lg rounded-lg p-6">
      <h2 className="text-2xl font-bold mb-4">Control Animal</h2>
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
          <label className="block text-sm font-medium">Animal</label>
          <select className="w-full p-2 border rounded" value={idAnimal || ''} onChange={(e) => setIdAnimal(Number(e.target.value))}>
            <option value="">Seleccione un animal</option>
            {animales.map((animal) => (
              <option key={animal.idAnimales} value={animal.idAnimales}>
                {animal.nombreAni}
              </option>
            ))}
          </select>
        </div>
        <button type="submit" className="bg-blue-500 text-white px-4 py-2 rounded-full hover:bg-blue-600 transition duration-300">
          Crear Control Animal
        </button>
      </form>
    </div>
  );
}
