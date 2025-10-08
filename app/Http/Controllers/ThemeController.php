<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ThemeController extends Controller
{
    public function update(Request $request)
    {
        $request->validate([
            'theme' => 'required|string|in:BlueTheme,LightTheme,DarkTheme,SemiDarkTheme,BoderedTheme'
        ]);

        $user = Auth::user();
        $user->theme = $request->theme;
        $user->save();

        return response()->json(['success' => true]);
    }
}
