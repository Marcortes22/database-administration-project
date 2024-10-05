'use client';

import { Button } from '@nextui-org/button';
import { signOut } from 'next-auth/react';
import Link from 'next/link';

export default function SignOutButton() {
  return (
    <>
      <Button
        onClick={() => signOut()}
        as={Link}
        color="danger"
        href="#"
        variant="flat"
      >
        Cerrar sesion
      </Button>
    </>
  );
}
