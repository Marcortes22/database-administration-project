'use client';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';
import toast from 'react-hot-toast';
import { useEmpleados } from '@/Hooks/useEmpleado';

export default function EmpleadosTable() {
  const { empleados, loading, error } = useEmpleados();
  const { navigateTo } = useCustomRouter();

  const handleEdit = (id: number) => {
    toast.success('Empleado editado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Editar empleado con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    toast.success('Empleado eliminado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Eliminar empleado con id: ${id}`);
  };

  if (loading) {
    return <p className="text-center">Cargando datos...</p>;
  }

  if (error) {
    return <p className="text-center text-red-500">Error al cargar los datos</p>;
  }

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Empleados</h2>
        <button
          onClick={() => navigateTo('/dashboard/empleados/agregarEmpleado')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo empleado
        </button>
      </div>

      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">Cédula</th>
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Apellido 1</th>
            <th className="px-6 py-3 text-center">Apellido 2</th>
            <th className="px-6 py-3 text-center">Puesto</th>
          </tr>
        </thead>
        <tbody>
          {empleados.map((empleado) => (
            <tr key={empleado.idEmpleado} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{empleado.idEmpleado}</td>
              <td className="px-6 py-4 text-center">{empleado.nombre}</td>
              <td className="px-6 py-4 text-center">{empleado.apellido1}</td>
              <td className="px-6 py-4 text-center">{empleado.apellido2}</td>
              <td className="px-6 py-4 text-center">{empleado.puesto}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
