'use client';

import {
  Navbar,
  NavbarBrand,
  NavbarContent,
  NavbarItem,
} from '@nextui-org/navbar';
import { Button, Link } from '@nextui-org/react';
import { signOut } from 'next-auth/react';
import Image from 'next/image';
import LionImAGE from '@/Assets/lion.png';
import { useCustomRouter } from '@/Hooks/Router/useRouter';
import { FaSignOutAlt } from 'react-icons/fa'; // Importar icono

export default function AppNavbar() {
  const { navigateTo } = useCustomRouter();

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
          <p className="font-extrabold text-2xl text-gray-800">ZOO</p>
        </NavbarBrand>
      </NavbarContent>

      <NavbarContent className="hidden sm:flex gap-6" justify="center">
        {["Empleados", "Animales", "Venta de boletos", "Habitats", "Tareas"].map(
          (item, index) => (
            <NavbarItem key={index}>
              <Link
                color="foreground"
                className="text-gray-600 hover:text-blue-500 cursor-pointer transition-all duration-300 text-lg"
                onClick={() => navigateTo(`/dashboard/${item.toLowerCase()}`)}
              >
                {item}
              </Link>
            </NavbarItem>
          )
        )}
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
