'use client';

import { useCustomRouter } from '@/Hooks/Router/useRouter';
import Image from 'next/image';
import WelcomeImage from '@/Assets/elephant.png'; // Asegúrate de tener esta imagen en tu proyecto

export default function WelcomePage() {
  const { navigateTo } = useCustomRouter();

  return (
    <div className="min-h-screen bg-gray-50 flex items-center justify-center">
      <div className="max-w-3xl bg-white rounded-lg shadow-lg p-8 text-center">
        <Image
          src={WelcomeImage}
          alt="Bienvenido al Sistema"
          width={300}
          height={300}
          className="mx-auto mb-6"
        />
        <h1 className="text-4xl font-bold text-gray-800 mb-4">¡Bienvenido al Sistema ZOO!</h1>
        <p className="text-lg text-gray-600 mb-8">
          Gestiona los hábitats, animales, empleados y boletos de tu zoológico de manera eficiente.
          Explora las opciones disponibles en el menú superior para empezar.
        </p>
      </div>
    </div>
  );
}
