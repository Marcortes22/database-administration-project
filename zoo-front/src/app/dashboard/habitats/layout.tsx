export default function Layout({ children }: { children: React.ReactNode }) {
    return (
      <div>
        <h2 className="text-lg font-semibold text-center my-4">Registro de Habitats</h2>
        <div>{children}</div> 
      </div>
    );
  }
  