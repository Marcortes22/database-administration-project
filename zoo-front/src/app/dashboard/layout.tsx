import AppNavbar from '@/Components/Navbar';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Dashboard',
  description: 'View your dashboard',
};

export default function Layout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <div>
      <header>
        <AppNavbar />
      </header>
      <main>{children}</main>
      <footer></footer>
    </div>
  );
}
