import {
  Navbar,
  NavbarBrand,
  NavbarContent,
  NavbarItem,
  NavbarMenuToggle,
  NavbarMenu,
  NavbarMenuItem,
} from '@nextui-org/navbar';
import { Button, Link } from '@nextui-org/react';
import SignOutButton from './SignOut';
export default function AppNavbar() {
  return (
    <Navbar>
      <NavbarBrand>
        {/* <AcmeLogo /> */}
        <p className="font-bold text-inherit">ZOO</p>
      </NavbarBrand>
      <NavbarContent className="hidden sm:flex gap-4" justify="center">
        <NavbarItem>
          <Link color="foreground" href="#">
            Empleados
          </Link>
        </NavbarItem>
        <NavbarItem isActive>
          <Link href="#" aria-current="page">
            Animales
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link color="foreground" href="#">
            Venta de boletos
          </Link>
        </NavbarItem>
        <NavbarItem>
          <Link color="foreground" href="#">
            Tareas
          </Link>
        </NavbarItem>
      </NavbarContent>
      <NavbarContent justify="end">
        <NavbarItem>
          <SignOutButton></SignOutButton>
        </NavbarItem>
      </NavbarContent>
    </Navbar>
  );
}
