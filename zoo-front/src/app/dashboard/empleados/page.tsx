'use client';

import { useState } from 'react';
import toast from 'react-hot-toast';
import { FaPlus, FaEdit, FaTrash } from 'react-icons/fa';

export default function EmpleadosTable() {
  const [empleados, setEmpleados] = useState([
    {
      IdEmpleado: 1,
      Nombre: 'Juan',
      Apellido1: 'Pérez',
      Apellido2: 'García',
      CorreoElectronico: 'juan.perez@example.com',
    },
    {
      IdEmpleado: 2,
      Nombre: 'María',
      Apellido1: 'López',
      Apellido2: 'Rodríguez',
      CorreoElectronico: 'maria.lopez@example.com',
    },
    {
      IdEmpleado: 3,
      Nombre: 'Carlos',
      Apellido1: 'Gómez',
      Apellido2: 'Martínez',
      CorreoElectronico: 'carlos.gomez@example.com',
    },
  ]);

  const handleEdit = (id: number) => {
    toast.success('Empleado editado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Editar empleado con id: ${id}`);
  };

  const handleDelete = (id: number) => {
    setEmpleados(empleados.filter((empleado) => empleado.IdEmpleado !== id));
    toast.success('Empleado eliminado correctamente', {
      style: { borderRadius: '10px', background: '#333', color: '#fff' },
    });
    console.log(`Eliminar empleado con id: ${id}`);
  };

  return (
    <div className="relative mx-8 my-6 p-6 bg-white shadow-lg rounded-lg">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Registro de Empleados</h2>
        <button
          onClick={() => console.log('Navegar a agregar empleado')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo empleado
        </button>
      </div>

      <table className="w-full text-left text-gray-500">
        <thead className="bg-gray-50">
          <tr className="text-gray-700 uppercase text-sm">
            <th className="px-6 py-3 text-center">ID</th>
            <th className="px-6 py-3 text-center">Nombre</th>
            <th className="px-6 py-3 text-center">Apellido 1</th>
            <th className="px-6 py-3 text-center">Apellido 2</th>
            <th className="px-6 py-3 text-center">Correo Electrónico</th>
            <th className="px-6 py-3 text-center">Acciones</th>
          </tr>
        </thead>
        <tbody>
          {empleados.map((empleado) => (
            <tr key={empleado.IdEmpleado} className="border-b hover:bg-gray-100">
              <td className="px-6 py-4 text-center font-medium">{empleado.IdEmpleado}</td>
              <td className="px-6 py-4 text-center">{empleado.Nombre}</td>
              <td className="px-6 py-4 text-center">{empleado.Apellido1}</td>
              <td className="px-6 py-4 text-center">{empleado.Apellido2}</td>
              <td className="px-6 py-4 text-center">{empleado.CorreoElectronico}</td>
              <td className="px-6 py-4 flex justify-center space-x-2">
                <button
                  className="bg-blue-500 text-white px-3 py-2 rounded-full hover:bg-blue-600 transition-all flex items-center"
                  onClick={() => handleEdit(empleado.IdEmpleado)}
                >
                  <FaEdit className="mr-1" /> Editar
                </button>
                <button
                  className="bg-red-500 text-white px-3 py-2 rounded-full hover:bg-red-600 transition-all flex items-center"
                  onClick={() => handleDelete(empleado.IdEmpleado)}
                >
                  <FaTrash className="mr-1" /> Eliminar
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
