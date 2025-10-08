<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreRoleRequest;
use App\Http\Requests\UpdateRoleRequest;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Illuminate\Http\Request;


class RoleController extends Controller
{

    public function __construct()
    {
        // Protect all role routes with permissions
        $this->middleware('permission:view-roles')->only(['index']);
        $this->middleware('permission:create-roles')->only(['create', 'store']);
        $this->middleware('permission:edit-roles')->only(['edit']);
        $this->middleware('permission:update-roles')->only(['update']);
        $this->middleware('permission:delete-roles')->only(['destroy']);
    }

    public function index()
    {
        $roles = Role::with('permissions')->orderBy('name')->paginate(10);
        return view('roles.index', compact('roles'));
    }

    public function create()
    {
        $permissions = Permission::orderBy('name')->get();
        return view('roles.create', compact('permissions'));
    }

    public function store(StoreRoleRequest $request)
    {
        $role = Role::create(['name' => $request->name]);
        $role->syncPermissions($request->input('permissions', []));
        return redirect()->route('roles.index')->with('success', 'Role created.');
    }

    // public function edit(Role $role)
    // {
    //     // $permissions = Permission::orderBy('name')->get();

    //     $permissions = Permission::all()
    //         ->groupBy(function ($perm) {
    //             return explode('-', $perm->name)[1]; // group by prefix before '-'
    //         });
    //     $role->load('permissions');
    //     return view('roles.edit', compact('role', 'permissions'));
    // }

    public function edit(Role $role)
    {
        $groupedPermissions = Permission::orderBy('name')->get()
            ->groupBy(function ($perm) {
                return Str::of($perm->name)->after('-')->toString() ?: 'misc';
            });

        $role->load('permissions');

        return view('roles.edit', compact('role', 'groupedPermissions'));
    }

    public function update(UpdateRoleRequest $request, Role $role)
    {
        $role->update(['name' => $request->name]);
        $role->syncPermissions($request->input('permissions', []));
        return redirect()->route('roles.index')->with('success', 'Role updated.');
    }

    public function destroy(Role $role)
    {
        $role->delete();
        return redirect()->route('roles.index')->with('success', 'Role deleted.');
    }


}
