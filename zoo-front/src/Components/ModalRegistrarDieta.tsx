'use client';
import { useState, Fragment } from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { useRegistrarDieta } from '@/Hooks/useRegistrarDieta';
import { useAlimentos } from '@/Hooks/useAlimentos';

interface ModalRegistrarDietaProps {
  isOpen: boolean;
  onClose: () => void;
}

export default function ModalRegistrarDieta({
  isOpen,
  onClose,
}: ModalRegistrarDietaProps) {
  const { alimentos, loading: loadingAlimentos } = useAlimentos();
  const { registrarDieta, loading: loadingDieta } = useRegistrarDieta();

  const [dieta, setDieta] = useState({
    nombreDiet: '',
    alimentos: [] as { idAlimento: number }[],
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    const { name, value } = e.target;
    setDieta({ ...dieta, [name]: value });
  };

  const handleAlimentoChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const selectedId = Number(e.target.value);
    if (selectedId && !dieta.alimentos.find(a => a.idAlimento === selectedId)) {
      setDieta((prevState) => ({
        ...prevState,
        alimentos: [...prevState.alimentos, { idAlimento: selectedId }],
      }));
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await registrarDieta(dieta);
    onClose(); // Cerrar modal después de la operación
  };

  const handleRemoveAlimento = (id: number) => {
    setDieta((prevState) => ({
      ...prevState,
      alimentos: prevState.alimentos.filter((a) => a.idAlimento !== id),
    }));
  };

  const obtenerAlimento = (id: number) =>
    alimentos.find((alimento) => alimento.idAlimentos === id)?.nombre || 'Desconocido';

  return (
    <Transition appear show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-10" onClose={onClose}>
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-black bg-opacity-25" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="w-full max-w-lg p-6 bg-white rounded-lg shadow-xl">
                <Dialog.Title
                  as="h3"
                  className="text-2xl font-semibold leading-6 text-gray-900"
                >
                  Registrar Nueva Dieta
                </Dialog.Title>

                <form onSubmit={handleSubmit} className="space-y-4 mt-4">
                  <div>
                    <label className="block text-gray-700 font-medium">
                      Nombre de la Dieta
                    </label>
                    <input
                      type="text"
                      name="nombreDiet"
                      value={dieta.nombreDiet}
                      onChange={handleChange}
                      required
                      className="w-full px-4 py-2 border rounded-lg bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-400"
                    />
                  </div>

                  <div>
                    <label className="block text-gray-700 font-medium">
                      Seleccionar Alimentos
                    </label>
                    <select
                      onChange={handleAlimentoChange}
                      className="w-full px-4 py-2 border rounded-lg bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-400"
                    >
                      <option value="">Selecciona un alimento</option>
                      {loadingAlimentos ? (
                        <option>Cargando alimentos...</option>
                      ) : (
                        alimentos.map((alimento) => (
                          <option
                            key={alimento.idAlimentos}
                            value={alimento.idAlimentos}
                          >
                            {alimento.nombre}
                          </option>
                        ))
                      )}
                    </select>
                  </div>

                  <div className="mt-2">
                    <h4 className="text-gray-700 font-medium">Alimentos Seleccionados</h4>
                    <ul className="space-y-1">
                      {dieta.alimentos.map((alimento) => (
                        <li
                          key={alimento.idAlimento}
                          className="flex justify-between items-center bg-gray-100 px-3 py-2 rounded-lg"
                        >
                          <span>{obtenerAlimento(alimento.idAlimento)}</span>
                          <button
                            type="button"
                            onClick={() => handleRemoveAlimento(alimento.idAlimento)}
                            className="text-red-500 hover:text-red-700"
                          >
                            Eliminar
                          </button>
                        </li>
                      ))}
                    </ul>
                  </div>

                  <div className="flex justify-end space-x-4 mt-6">
                    <button
                      type="button"
                      onClick={onClose}
                      className="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600"
                    >
                      Cancelar
                    </button>
                    <button
                      type="submit"
                      disabled={loadingDieta}
                      className={`px-4 py-2 rounded-lg text-white ${
                        loadingDieta
                          ? 'bg-gray-400 cursor-not-allowed'
                          : 'bg-blue-500 hover:bg-blue-600'
                      } transition duration-300`}
                    >
                      {loadingDieta ? 'Guardando...' : 'Registrar Dieta'}
                    </button>
                  </div>
                </form>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
}
