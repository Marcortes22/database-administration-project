'use client';

import { Button } from '@nextui-org/react';
import { signOut } from 'next-auth/react';

export default function SignOutButton() {
  return (
    <Button
      color="danger"
      variant="flat"
      className="bg-red-500 text-white px-6 py-3 rounded-full shadow-lg hover:bg-red-600 transition-all duration-300 ease-in-out transform hover:scale-105 font-semibold text-base tracking-wide"
      onClick={() => signOut({ callbackUrl: '/' })} 
    >
      Cerrar Sesión
    </Button>
  );
}
