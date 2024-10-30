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
import { FaSignOutAlt } from 'react-icons/fa'; // Icono
import { jwtDecode } from 'jwt-decode';

interface DecodedToken {
  Id: string;
  Role: string;
  exp: number;
}

export default function AppNavbar() {
  const { navigateTo } = useCustomRouter();
  const { data: session } = useSession(); // Obtenemos la sesión

  // Decodificar el token para obtener el rol
  const token = session?.user?.access_token;
  let role = '';

  if (token) {
    const decoded: DecodedToken = jwtDecode(token);
    role = decoded.Role; 
  }

  // Definimos las rutas con su estructura organizada y condicionamos según el rol
  const routes = [
    { name: 'Empleados', path: '/dashboard/empleados', roles: ['ADMIN'] },
    { name: 'Animales', path: '/dashboard/animales', roles: ['ADMIN', 'USER'] },
    { name: 'Venta de entradas', path: '/dashboard/ventas', roles: ['SELLER'] },
    { name: 'Habitats', path: '/dashboard/habitats', roles: ['ADMIN'] },
    { name: 'Tareas', path: '/dashboard/tareas', roles: ['ADMIN'] },
  ];

  return (
    <Navbar isBordered className="bg-white shadow-md px-8 py-4">
      <NavbarContent justify="start">
        <NavbarBrand className="flex items-center">
          <Image
            src={LionImAGE}
            alt="Logo ZOO"
            width={40}
            height={40}
            className="mr-2"
          />
          <p className="font-extrabold text-2xl text-gray-800">Mundo Animal</p>
        </NavbarBrand>
      </NavbarContent>

      <NavbarContent className="hidden sm:flex gap-6" justify="center">
        {/* Mapeamos las rutas dinámicamente según el rol */}
        {routes
          .filter((route) => route.roles.includes(role)) // Filtramos según el rol
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
      </NavbarContent>

      <NavbarContent justify="end">
        <NavbarItem>
          <Button
            color="danger"
            className="bg-red-500 hover:bg-red-600 px-6 py-2 rounded-full text-white transition-all duration-300 flex items-center gap-2"
            onClick={() => signOut({ callbackUrl: '/' })}
          >
            <FaSignOutAlt size={18} /> {/* Icono */}
            Cerrar sesión
          </Button>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
  );
}
