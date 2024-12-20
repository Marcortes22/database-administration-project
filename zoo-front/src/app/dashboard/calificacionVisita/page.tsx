// Components/FormularioCalificacionVisita.tsx
'use client';

import { useState, useEffect } from 'react';
import { useCalificacionVisita } from '@/Hooks/useCalificacionVisita';
import { useVisitantes } from '@/Hooks/useVisitante';
import { CalificacionVisita } from '@/Types/next-auth-types/CalificaciónVisita';


export default function FormularioCalificacionVisita() {
  const { enviarCalificacion, loading } = useCalificacionVisita();
  const { visitantes, loading: loadingVisitantes, error: errorVisitantes } = useVisitantes();
  
  const [calificacion, setCalificacion] = useState<CalificacionVisita>({
    idVentaEntrada: 0,
    notaRecorrido: 0,
    sugerenciaMejoraRecorrido: '',
    notaServicioAlCliente: 0,
    sugerenciaMejoraServicioAlCliente: '',
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
  ) => {
    const { name, value } = e.target;
    setCalificacion({
      ...calificacion,
      [name]: name.includes('nota') ? Number(value) : value,
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await enviarCalificacion(calificacion);
  };

  return (
    <div className="max-w-4xl mx-auto my-10 p-8 bg-white shadow-2xl rounded-xl">
      <h2 className="text-3xl font-bold text-gray-800 text-center mb-6">
        Calificación de la Visita
      </h2>
      <form onSubmit={handleSubmit} className="space-y-6">
        <div>
          <label className="block text-gray-700 font-medium">Visitante</label>
          <select
            name="idVentaEntrada"
            value={calificacion.idVentaEntrada}
            onChange={handleChange}
            required
            className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
          >
            <option value="" disabled>
              Selecciona un visitante
            </option>
            {loadingVisitantes ? (
              <option>Cargando visitantes...</option>
            ) : errorVisitantes ? (
              <option>Error al cargar visitantes</option>
            ) : (
              visitantes.map((visitante) => (
                <option key={visitante.idVisitantes} value={visitante.idVisitantes}>
                  {visitante.nombreVist} {visitante.apell1Vist} {visitante.apell2Vist}
                </option>
              ))
            )}
          </select>
        </div>

        <div>
          <label className="block text-gray-700 font-medium">Nota Recorrido (1-5)</label>
          <input
            type="number"
            name="notaRecorrido"
            value={calificacion.notaRecorrido}
            onChange={handleChange}
            min={1}
            max={5}
            required
            className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div>
          <label className="block text-gray-700 font-medium">Sugerencia para el Recorrido</label>
          <textarea
            name="sugerenciaMejoraRecorrido"
            value={calificacion.sugerenciaMejoraRecorrido}
            onChange={handleChange}
            rows={3}
            className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div>
          <label className="block text-gray-700 font-medium">Nota Servicio al Cliente (1-5)</label>
          <input
            type="number"
            name="notaServicioAlCliente"
            value={calificacion.notaServicioAlCliente}
            onChange={handleChange}
            min={1}
            max={5}
            required
            className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div>
          <label className="block text-gray-700 font-medium">Sugerencia para el Servicio al Cliente</label>
          <textarea
            name="sugerenciaMejoraServicioAlCliente"
            value={calificacion.sugerenciaMejoraServicioAlCliente}
            onChange={handleChange}
            rows={3}
            className="w-full px-4 py-3 border rounded-lg bg-gray-100 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div className="flex justify-end mt-6">
          <button
            type="submit"
            disabled={loading}
            className={`px-5 py-3 rounded-lg text-white ${
              loading
                ? 'bg-gray-400 cursor-not-allowed'
                : 'bg-blue-500 hover:bg-blue-600'
            } transition duration-300`}
          >
            {loading ? 'Enviando...' : 'Enviar Calificación'}
          </button>
        </div>
      </form>
    </div>
  );
}
