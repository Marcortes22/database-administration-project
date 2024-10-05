import type { Metadata } from 'next';

import '../Styles/globals.css';
import SessionAuthProvider from '@/Context/SessionAuthProvider';
import { Toaster } from 'react-hot-toast';
import { Providers } from './providers';

export const metadata: Metadata = {
  title: 'Zoo',
  description: 'Database project',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <SessionAuthProvider>
          <Toaster position="top-right" />
          <Providers>{children}</Providers>
        </SessionAuthProvider>
      </body>
    </html>
  );
}
