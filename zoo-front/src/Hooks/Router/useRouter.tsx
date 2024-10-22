'use client'; // Asegúrate de que este archivo esté en modo cliente

import { useRouter } from 'next/navigation'; // Correcto import de useRouter

export const useCustomRouter = () => {
  const router = useRouter();

  const navigateTo = (path: string) => {
    router.push(path); // Navega a la ruta dada
  };

  return { navigateTo };
};
