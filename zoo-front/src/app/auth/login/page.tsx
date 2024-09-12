import UserSvg from '@/Assets/Icons/user.svg';
import PasswordSvg from '@/Assets/Icons/password.svg';

export default function Page() {
  return (
    <>
      <div className="bg-black p-3 opacity-75 rounded-lg text-stone-50">
        <form className="flex flex-col gap-5">
          <div className="relative">
            <input
              className="text-black pl-10 pr-4 py-2 border rounded-lg"
              type="text"
              name="username"
              placeholder="Usuario"
            />
            <div className="absolute inset-y-0 left-0 pl-2 flex items-center pointer-events-none">
              <UserSvg className="w-5 h-5" />
            </div>
          </div>

          <div className="relative">
            <input
              className="text-black pl-10 pr-4 py-2 border rounded-lg"
              type="password"
              name="password"
              placeholder="Contraseña"
            />
            <div className="absolute inset-y-0 left-0 pl-2 flex items-center pointer-events-none">
              <PasswordSvg className="w-5 h-5" />
            </div>
          </div>
          <input
            className="bg-gradient-to-r from-indigo-500 from-10% via-sky-500 via-30% to-emerald-500 to-90% mt-4 px-0 py-2 cursor-pointer rounded-lg"
            type="submit"
            value="Iniciar sesión"
          />
        </form>
      </div>
    </>
  );
}
