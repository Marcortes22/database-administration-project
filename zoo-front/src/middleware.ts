import { getToken } from 'next-auth/jwt';
import { NextRequest, NextResponse } from 'next/server';
import { jwtDecode } from 'jwt-decode';
import { Payload } from './Types/next-auth-types/payload';

async function authMiddleware(req: NextRequest) {
  try {
    const session = await getToken({
      req,
      secret: process.env.NEXTAUTH_SECRET,
    });

    if (session) {
      return null;
    }

    return NextResponse.redirect(new URL('/auth/login', req.url));
  } catch (error) {
    console.error('Error al obtener el token:', error);
    return NextResponse.redirect(new URL('/auth/login', req.url));
  }
}

export async function middleware(req: NextRequest) {
  let response = await authMiddleware(req);
  if (response) {
    return response;
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/', '/admin/:path*', '/user/:path*', '/dashboard/:path*'],
};
