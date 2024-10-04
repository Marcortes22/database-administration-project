'use client';

import { signIn, useSession } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import { useState } from 'react';
import toast from 'react-hot-toast';

export default function useLogin() {
  const router = useRouter();
  const [error, setError] = useState('');
  const [username, setUsername] = useState('marcortes');
  const [password, setPassword] = useState('1234');

  async function onSubmit(e: React.FormEvent) {
    e.preventDefault();
    const result = await signIn('credentials', {
      username,
      password,
      redirect: false,
    });

    if (result?.error) {
      setError(result.error);

      toast('Credenciales incorrectas', {
        icon: '🚫',
        style: {
          borderRadius: '10px',
          background: '#333',
          color: '#fff',
        },
      });
      return;
    } else {
      toast('Bienvenido', {
        icon: '👏',
        style: {
          borderRadius: '10px',
          background: '#333',
          color: '#fff',
        },
      });

      router.push('/');
    }
  }
  return {
    onSubmit,
    setPassword,
    setUsername,
    username,
    password,
  };
}
