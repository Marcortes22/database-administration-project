import type { Metadata } from 'next';

import '../Styles/globals.css';
import SessionAuthProvider from '@/Context/SessionAuthProvider';

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
      <head>
        <link rel="icon" href="../public/Assets/elephand.png" />
      </head>
      <body>
        <SessionAuthProvider>{children}</SessionAuthProvider>
      </body>
    </html>
  );
}
