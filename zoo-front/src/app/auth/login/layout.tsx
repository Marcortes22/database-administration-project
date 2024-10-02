import Image from 'next/image';
import penguinImg from '@/Assets/penguin.jpg';
export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <main className=" h-screen flex items-center justify-center">
        <Image
          className="absolute"
          src={penguinImg}
          fill={true}
          alt="Background img"
          priority={true}
          style={{ objectFit: 'cover' }}
        />
        <div className="relative">{children}</div>
      </main>
    </>
  );
}
