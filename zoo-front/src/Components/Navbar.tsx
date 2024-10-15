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
import LionImAGE from '@/Assets/lion.png'
import { useCustomRouter } from '@/Hooks/Router/useRouter';

export default function AppNavbar() {

  const { navigateTo } = useCustomRouter();
  return (
    <Navbar isBordered className="bg-opacity-70 backdrop-blur-md bg-gray-800">
      <NavbarContent justify="start">
        <NavbarBrand>
          <Image
            src={LionImAGE}
            alt="Logo ZOO"
            width={30}
            height={30}
            className="mr-2"
          />
          <p className="font-bold text-white">ZOO</p>
        </NavbarBrand>
      </NavbarContent>
      <NavbarContent className="hidden sm:flex gap-6" justify="center">
        <NavbarItem>
          <Link
            color="foreground"
            href="#"
            className="text-white hover:text-blue-400 transition duration-300"
          >
            Empleados
          </Link>
        </NavbarItem>
        <NavbarItem isActive>
          <Link
            href="#"
            aria-current="page"
            className="text-white hover:text-blue-400 transition duration-300"
          >
            Animales
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link
            color="foreground"
            href="#"
            className="text-white hover:text-blue-400 transition duration-300"
          >
            Venta de boletos
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link
            color="foreground"
            href="#"
            className="text-white hover:text-blue-400 transition duration-300"
            onClick={() => navigateTo('/dashboard/habitats')}
          >
            Habitats
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link
            color="foreground"
            href="#"
            className="text-white hover:text-blue-400 transition duration-300"
          >
            Tareas
          </Link>
        </NavbarItem>
      </NavbarContent>
      <NavbarContent justify="end">
        <NavbarItem>
          <Button color="danger" onClick={() => signOut({ callbackUrl: '/' })} >
            Cerrar sesión
          </Button>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
  );
}
