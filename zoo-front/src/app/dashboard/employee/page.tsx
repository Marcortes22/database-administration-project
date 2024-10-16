'use client';

import { useState } from 'react';
import toast from 'react-hot-toast';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';

export default function EmpleadosTable() {
  // Datos simulados para los empleados
  const [empleados, setEmpleados] = useState([
    { IdEmpleado: 1, Nombre: 'Juan', Apellido1: 'Pérez', Apellido2: 'García', CorreoElectronico: 'juan.perez@example.com' },
    { IdEmpleado: 2, Nombre: 'María', Apellido1: 'López', Apellido2: 'Rodríguez', CorreoElectronico: 'maria.lopez@example.com' },
    { IdEmpleado: 3, Nombre: 'Carlos', Apellido1: 'Gómez', Apellido2: 'Martínez', CorreoElectronico: 'carlos.gomez@example.com' },
  ]);

  const handleEdit = (id: number) => {
    toast.success('Empleado editado correctamente', {
      style: {
        borderRadius: '10px',
        background: '#333',
        color: '#fff',
      },
    });
    console.log(`Editar empleado con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    setEmpleados(empleados.filter(empleado => empleado.IdEmpleado !== id));
    toast.success('Empleado eliminado correctamente', {
      style: {
        borderRadius: '10px',
        background: '#333',
        color: '#fff',
      },
    });
    console.log(`Eliminar empleado con id: ${id}`);
  };

  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg mx-8 my-6">
      <div className="flex justify-between mb-4">
        <h2 className="text-xl font-semibold">Registro de Empleados</h2>
        <button
          onClick={() => console.log('Navegar a agregar empleado')}
          className="bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo empleado
        </button>
      </div>
      <table className="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" className="px-6 py-3 text-center">ID</th>
            <th scope="col" className="px-6 py-3 text-center">Nombre</th>
            <th scope="col" className="px-6 py-3 text-center">Apellido 1</th>
            <th scope="col" className="px-6 py-3 text-center">Apellido 2</th>
            <th scope="col" className="px-6 py-3 text-center">Correo Electrónico</th>
            <th scope="col" className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {empleados.map((empleado) => (
            <tr key={empleado.IdEmpleado} className="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
              <th scope="row" className="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white text-center">
                {empleado.IdEmpleado}
              </th>
              <td className="px-6 py-4 text-center">{empleado.Nombre}</td>
              <td className="px-6 py-4 text-center">{empleado.Apellido1}</td>
              <td className="px-6 py-4 text-center">{empleado.Apellido2}</td>
              <td className="px-6 py-4 text-center">{empleado.CorreoElectronico}</td>
              <td className="px-6 py-4 text-center">
                <button
                  className="bg-blue-500 text-white px-3 py-1 rounded-md mr-2 hover:bg-blue-600 transition duration-300"
                  onClick={() => handleEdit(empleado.IdEmpleado)}
                >
                  <FaEdit />
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition duration-300"
                  onClick={() => handleDelete(empleado.IdEmpleado)}
                >
                  <FaTrash />
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
