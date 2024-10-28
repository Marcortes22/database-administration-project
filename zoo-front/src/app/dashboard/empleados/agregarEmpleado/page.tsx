
'use client';
import { useState } from 'react';
import { useRoles } from '@/Hooks/useRoles';

import { Empleado, RegistarEmpleado } from '@/Types/next-auth-types/Empleado';
import { usePuestos } from '@/Hooks/usePuestos';
import { useRegistrarEmpleado } from '@/Hooks/useRegistrarEmpleado';

export default function FormularioRegistroEmpleado() {
  const { puestos, loading: loadingPuestos, error: errorPuestos } = usePuestos();
  const { roles, loading: loadingRoles, error: errorRoles } = useRoles();
  const { registrarEmpleado, loading } = useRegistrarEmpleado();

  const [empleado, setEmpleado] = useState<RegistarEmpleado>({
    idEmpleado: '',
    nombre: '',
    apellido1: '',
    apellido2: '',
    correo: '',
    idPuesto: 0,
    contraseña: '',
    idRol: 0,
    rolFechaInicio: new Date().toISOString(),
    rolFechaFin: new Date().toISOString(),
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setEmpleado({ ...empleado, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await registrarEmpleado(empleado);
  };

  const handleCancel = () => {
    window.history.back();
  };

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <h2 className="text-3xl font-bold text-gray-800 text-center mb-6">
        Registrar Nuevo Empleado
      </h2>

      <form onSubmit={handleSubmit}>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-gray-700 font-medium">Cédula del Empleado</label>
            <input
              type="text"
              name="idEmpleado"
              value={empleado.idEmpleado}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Nombre</label>
            <input
              type="text"
              name="nombre"
              value={empleado.nombre}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Primer Apellido</label>
            <input
              type="text"
              name="apellido1"
              value={empleado.apellido1}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Segundo Apellido</label>
            <input
              type="text"
              name="apellido2"
              value={empleado.apellido2}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Correo Electrónico</label>
            <input
              type="email"
              name="correo"
              value={empleado.correo}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Contraseña</label>
            <input
              type="password"
              name="contraseña"
              value={empleado.contraseña}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Puesto</label>
            <select
              name="idPuesto"
              value={empleado.idPuesto}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Seleccione un puesto</option>
              {loadingPuestos ? (
                <option>Cargando puestos...</option>
              ) : errorPuestos ? (
                <option>Error al cargar puestos</option>
              ) : (
                puestos.map((puesto) => (
                  <option key={puesto.idPuesto} value={puesto.idPuesto}>
                    {puesto.nombre}
                  </option>
                ))
              )}
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Rol</label>
            <select
              name="idRol"
              value={empleado.idRol}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            >
              <option value="">Seleccione un rol</option>
              {loadingRoles ? (
                <option>Cargando roles...</option>
              ) : errorRoles ? (
                <option>Error al cargar roles</option>
              ) : (
                roles.map((rol) => (
                  <option key={rol.idRol} value={rol.idRol}>
                    {rol.nombre}
                  </option>
                ))
              )}
            </select>
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Fecha Inicio Rol</label>
            <input
              type="date"
              name="rolFechaInicio"
              value={empleado.rolFechaInicio.split('T')[0]}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>

          <div>
            <label className="block text-gray-700 font-medium">Fecha Fin Rol</label>
            <input
              type="date"
              name="rolFechaFin"
              value={empleado.rolFechaFin.split('T')[0]}
              onChange={handleChange}
              className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
              required
            />
          </div>
        </div>

        <div className="flex justify-between mt-6">
          <button
            type="button"
            onClick={handleCancel}
            className="bg-red-500 text-white px-5 py-3 rounded-lg hover:bg-red-600 transition duration-300"
          >
            Cancelar
          </button>
          <button
            type="submit"
            disabled={loading}
            className="bg-green-500 text-white px-5 py-3 rounded-lg hover:bg-green-600 transition duration-300"
          >
            {loading ? 'Registrando...' : 'Registrar Empleado'}
          </button>
        </div>
      </form>
    </div>
  );
}