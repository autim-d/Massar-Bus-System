<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Kreait\Laravel\Firebase\Facades\Firebase;

class AuthController extends Controller
{
    /**
     * Refresh the Firebase ID token using a refresh token.
     */
    public function refresh(Request $request)
    {
        $request->validate([
            'refresh_token' => 'required|string',
        ]);

        try {
            $auth = Firebase::auth();
            $signInResult = $auth->signInWithRefreshToken($request->refresh_token);

            return response()->json([
                'id_token' => $signInResult->idToken(),
                'refresh_token' => $signInResult->refreshToken(),
                'expires_in' => $signInResult->ttl(),
            ]);
        } catch (\Kreait\Firebase\Exception\AuthException $e) {
            return response()->json([
                'error' => 'Failed to refresh token',
                'message' => $e->getMessage()
            ], 401);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Internal Server Error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
