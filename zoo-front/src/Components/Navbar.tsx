'use client';

import {
  Navbar,
  NavbarBrand,
  NavbarContent,
  NavbarItem,
} from '@nextui-org/navbar';
import { Button, Link } from '@nextui-org/react';
import { signOut, useSession } from 'next-auth/react';
import Image from 'next/image';
import LionImAGE from '@/Assets/lion.png';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaSignOutAlt } from 'react-icons/fa';
import {jwtDecode} from 'jwt-decode';
import { useState } from 'react';
import { DecodedToken } from '@/Types/next-auth-types/DecodedToken';

export default function AppNavbar() {
  const { navigateTo } = useCustomRouter();
  const { data: session } = useSession();

  const [isStatisticsMenuOpen, setStatisticsMenuOpen] = useState(false);

  const token = session?.user?.access_token;
  let role = '';

  if (token) {
    const decoded: DecodedToken = jwtDecode(token);
    role = decoded.Role;
  }

  const routes = [
    { name: 'Empleados', path: '/dashboard/empleados', roles: ['ADMIN'] },
    { name: 'Animales', path: '/dashboard/animales', roles: ['ADMIN', 'USER'] },
    { name: 'Venta de entradas', path: '/dashboard/ventas', roles: ['SELLER'] },
    { name: 'Habitats', path: '/dashboard/habitats', roles: ['ADMIN'] },
    { name: 'Tareas', path: '/dashboard/tareas', roles: ['ADMIN'] },
    { name: 'Mis Tareas', path: '/dashboard/mis-tareas', roles: ['ADMIN', 'USER'] },
    { name: 'Calificación Visita', path: '/dashboard/calificacionVisita', roles: ['SELLER'] },
  ];

  const statisticsRoutes = [
    { name: 'Ventas', path: '/dashboard/estadisticas/ventas' },
    { name: 'Tareas', path: '/dashboard/estadisticas/tareas' },
    { name: 'Calificaciones', path: '/dashboard/estadisticas/calificaciones' },
    { name: 'Alimentos', path: '/dashboard/estadisticas/alimentos' },
  ];

  const toggleStatisticsMenu = () => {
    setStatisticsMenuOpen(!isStatisticsMenuOpen);
  };

  return (
    <Navbar isBordered className="bg-white shadow-md px-8 py-4">
      <NavbarContent justify="start" className="mr-auto">
        <NavbarBrand className="flex items-center">
          <Image
            src={LionImAGE}
            alt="Logo ZOO"
            width={40}
            height={40}
            className="mr-2"
          />
          <p className="font-extrabold text-xl text-gray-800">Mundo Animal</p>
        </NavbarBrand>
      </NavbarContent>

      <NavbarContent className="hidden sm:flex gap-6 ml-auto" justify="center">
        {routes
          .filter((route) => route.roles.includes(role))
          .map((route, index) => (
            <NavbarItem key={index}>
              <Link
                color="foreground"
                className="text-gray-600 hover:text-blue-500 cursor-pointer transition-all duration-300 text-lg"
                onClick={() => navigateTo(route.path)}
              >
                {route.name}
              </Link>
            </NavbarItem>
          ))}

        {role === 'ADMIN' && (
          <div className="relative">
            <Link
              color="foreground"
              className="text-gray-600 hover:text-blue-500 cursor-pointer transition-all duration-300 text-lg"
              onClick={toggleStatisticsMenu} // Toggle al hacer click
            >
              Estadísticas
            </Link>
            {isStatisticsMenuOpen && ( // Mostrar si el menú está abierto
              <div className="absolute bg-white shadow-lg rounded-md mt-2 py-2 w-40 z-10">
                {statisticsRoutes.map((option, index) => (
                  <div
                    key={index}
                    onClick={() => {
                      navigateTo(option.path);
                      setStatisticsMenuOpen(false); // Cerrar el menú al hacer clic en una opción
                    }}
                    className="px-4 py-2 text-gray-700 hover:bg-gray-100 cursor-pointer"
                  >
                    {option.name}
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </NavbarContent>

      <NavbarContent justify="end" className="ml-auto">
        <NavbarItem>
          <Button
            color="danger"
            className="bg-red-500 hover:bg-red-600 px-6 py-2 rounded-full text-white transition-all duration-300 flex items-center gap-2"
            onClick={() => signOut({ callbackUrl: '/' })}
          >
            <FaSignOutAlt size={18} />
            Cerrar sesión
          </Button>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
  );
}
