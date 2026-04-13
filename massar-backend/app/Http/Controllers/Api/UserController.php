<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function profile(Request $request)
    {
        return response()->json($request->user());
    }

    public function update(Request $request)
    {
        $validated = $request->validate([
            'first_name' => 'sometimes|string|max:100',
            'last_name' => 'sometimes|string|max:100',
            'phone_number' => 'sometimes|string|max:20|unique:users,phone_number,' . $request->user()->id,
            'identity_number' => 'sometimes|string|max:50',
            'nationality' => 'sometimes|string|max:100',
            'avatar_url' => 'sometimes|url|max:255',
        ]);

        $request->user()->update($validated);
        
        return response()->json($request->user());
    }
}
