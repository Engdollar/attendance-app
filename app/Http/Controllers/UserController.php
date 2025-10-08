<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreUserRequest;
use App\Http\Requests\UpdateUserRequest;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class UserController extends Controller
{

    public function __construct()
    {
        // Protect all role routes with permissions
        $this->middleware('permission:view-users')->only(['index']);
        $this->middleware('permission:create-users')->only(['create', 'store']);
        $this->middleware('permission:edit-users')->only(['edit']);
        $this->middleware('permission:update-users')->only(['update']);
        $this->middleware('permission:delete-users')->only(['destroy']);
    }
    public function index()
    {
        $users = User::with(['roles', 'permissions'])->orderBy('name')->get();
        return view('users.index', compact('users'));
    }

    public function create()
    {
        $roles = Role::orderBy('name')->get();
        $permissions = Permission::orderBy('name')->get();
        return view('users.create', compact('roles', 'permissions'));
    }

    public function store(StoreUserRequest $request)
    {
        $data = $request->validated();
        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
        ]);

        $user->syncRoles($request->input('roles', []));
        $user->syncPermissions($request->input('permissions', []));
        return redirect()->route('users.index')->with('success', 'User created.');
    }

    public function edit(User $user)
    {
        $groupedPermissions = Permission::orderBy('name')->get()
            ->groupBy(function ($perm) {
                return Str::of($perm->name)->after('-')->toString() ?: 'misc';
            });

        $roles = Role::orderBy('name')->get();
        $permissions = Permission::orderBy('name')->get();
        $user->load(['roles', 'permissions']);
        return view('users.edit', compact('user', 'roles', 'permissions', 'groupedPermissions'));
    }

    public function update(UpdateUserRequest $request, User $user)
    {
        $data = $request->validated();

        $user->name = $data['name'];
        $user->email = $data['email'];
        if (!empty($data['password'])) {
            $user->password = Hash::make($data['password']);
        }
        $user->save();

        $user->syncRoles($request->input('roles', []));
        $user->syncPermissions($request->input('permissions', []));
        return redirect()->route('users.index')->with('success', 'User updated.');
    }

    public function destroy(User $user)
    {
        $user->delete();
        return redirect()->route('users.index')->with('success', 'User deleted.');
    }
}
