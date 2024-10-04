'use client';
import { signOut } from 'next-auth/react';
export default function Home() {
  return (
    <>
      <div>
        <button className="" onClick={() => signOut()}>
          Cerrar sesion
        </button>
      </div>
    </>
  );
}
