<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Kreait\Laravel\Firebase\Facades\Firebase;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class FirebaseAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $bearerToken = $request->bearerToken();

        if (!$bearerToken) {
            return response()->json(['error' => 'Unauthorized: No token provided'], 401);
        }

        try {
            $auth = Firebase::auth();
            $verifiedIdToken = $auth->verifyIdToken($bearerToken);
            
            $uid = $verifiedIdToken->claims()->get('sub');
            $claims = $verifiedIdToken->claims();
            
            $user = User::firstOrCreate(
                ['firebase_uid' => $uid],
                [
                    'email' => $claims->has('email') ? $claims->get('email') : null,
                    'first_name' => $claims->has('name') ? $claims->get('name') : null,
                    'avatar_url' => $claims->has('picture') ? $claims->get('picture') : null,
                ]
            );

            Auth::setUser($user);
            $request->merge(['auth_user' => $user]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Unauthorized: Invalid token', 'message' => $e->getMessage()], 401);
        }

        return $next($request);
    }
}
