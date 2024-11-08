'use client';
import { useVisitantes } from '@/Hooks/useVisitante';
import { useEntradas } from '@/Hooks/useEntrada';
import { useMetodosPago } from '@/Hooks/useMetodoPago';
import { useVentaEntradas } from '@/Hooks/useVentaEntradas';
import { FaPlus } from 'react-icons/fa';
import { useCustomRouter } from '@/Hooks/Router/useRouter';

export default function VentaEntradaForm() {
  const {
    detalles,
    idVisitante,
    idMetodoPago,
    setIdVisitante,
    setIdMetodoPago,
    handleDetalleChange,
    agregarDetalle,
    eliminarDetalle,
    realizarVenta,
  } = useVentaEntradas();

  const { visitantes, loading: loadingVisitantes, error: errorVisitantes } = useVisitantes();
  const { entradas, loading: loadingEntradas, error: errorEntradas } = useEntradas();
  const { metodosPago, loading: loadingMetodos, error: errorMetodos } = useMetodosPago();
  const {navigateTo} = useCustomRouter();

  if (loadingVisitantes || loadingEntradas || loadingMetodos) return <p>Cargando datos...</p>;
  if (errorVisitantes || errorEntradas || errorMetodos) return <p>Error al cargar datos</p>;

  return (
    <div className="max-w-3xl mx-auto my-12 p-10 bg-white rounded-3xl shadow-2xl transition-shadow hover:shadow-3xl">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-700">Venta de Entradas</h2>
        <button
          onClick={() => navigateTo('/dashboard/ventas/registrarVisitante')}
          className="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-300 flex items-center"
        >
          <FaPlus className="mr-2" /> Agregar nuevo visitante
        </button>
      </div>
      
      <form 
        onSubmit={(e) => { e.preventDefault(); realizarVenta(); }} 
        className="space-y-6"
      >
        {/* Selección de Visitante */}
        <div className="space-y-2">
          <label className="block text-lg font-medium text-gray-700">Visitante</label>
          <select
            value={idVisitante ?? ''}
            onChange={(e) => setIdVisitante(parseInt(e.target.value, 10) || null)}
            className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          >
            <option value="">Selecciona un visitante</option>
            {visitantes.map((v) => (
              <option key={v.idVisitantes} value={v.idVisitantes}>
                {v.nombreVist} {v.apell1Vist} {v.apell2Vist}
              </option>
            ))}
          </select>
        </div>

        {/* Detalles de Entradas */}
        {detalles.map((detalle, index) => (
          <div key={index} className="grid grid-cols-1 md:grid-cols-3 gap-6 items-end">
            <div className="space-y-2">
              <label className="block text-lg font-medium text-gray-700">Tipo de Entrada</label>
              <select
                value={detalle.idEntrada ?? ''}
                onChange={(e) =>
                  handleDetalleChange(index, 'idEntrada', parseInt(e.target.value, 10) || 0)
                }
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
              >
                <option value="">Selecciona un tipo de entrada</option>
                {entradas.map((entrada) => (
                  <option key={entrada.idEntrada} value={entrada.idEntrada}>
                    {entrada.tipoEntrada} - ${entrada.precioTotal}
                  </option>
                ))}
              </select>
            </div>

            <div className="space-y-2">
              <label className="block text-lg font-medium text-gray-700">Cantidad</label>
              <input
                type="number"
                min="1"
                value={detalle.cantidad}
                onChange={(e) =>
                  handleDetalleChange(index, 'cantidad', Number(e.target.value))
                }
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>

            <button
              type="button"
              onClick={() => eliminarDetalle(index)}
              className="bg-red-500 text-white px-6 py-3 rounded-lg hover:bg-red-600 transition duration-300"
            >
              Eliminar Entrada
            </button>
          </div>
        ))}

        {/* Botón para agregar detalles */}
        <div className="flex justify-start">
          <button
            type="button"
            onClick={agregarDetalle}
            className="bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600 transition duration-300"
          >
            Agregar Entrada
          </button>
        </div>

        {/* Selección del Método de Pago */}
        <div className="space-y-2">
          <label className="block text-lg font-medium text-gray-700">Método de Pago</label>
          <select
            value={idMetodoPago ?? ''}
            onChange={(e) => setIdMetodoPago(parseInt(e.target.value, 10) || null)}
            className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          >
            <option value="">Selecciona un método de pago</option>
            {metodosPago.map((metodo) => (
              <option key={metodo.idMetodoPago} value={metodo.idMetodoPago}>
                {metodo.metodopago}
              </option>
            ))}
          </select>
        </div>

        {/* Botones de Acción */}
        <div className="flex justify-between mt-6">
          <button
            type="button"
            onClick={() => window.history.back()}
            className="bg-red-500 text-white px-6 py-3 rounded-lg hover:bg-red-600 transition duration-300"
          >
            Cancelar
          </button>
          <button
            type="submit"
            className="bg-green-500 text-white px-6 py-3 rounded-lg hover:bg-green-600 transition duration-300"
          >
            Realizar Venta
          </button>
        </div>
      </form>
    </div>
  );
}
