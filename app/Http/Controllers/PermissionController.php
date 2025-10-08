<?php

namespace App\Http\Controllers;

use App\Http\Requests\StorePermissionRequest;
use App\Http\Requests\UpdatePermissionRequest;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Artisan;

class PermissionController extends Controller
{
    public function __construct()
    {
        // Protect all role routes with permissions
        $this->middleware('permission:view-permissions')->only(['index']);
        $this->middleware('permission:create-permissions')->only(['create', 'store','generatePermissions']);
        $this->middleware('permission:edit-permissions')->only(['edit']);
        $this->middleware('permission:update-permissions')->only(['update']);
        $this->middleware('permission:delete-permissions')->only(['destroy','deleteAll']);
    }

    public function index()
    {
        $permissions = Permission::orderBy('id')->get();
        return view('permissions.index', compact('permissions'));
    }

    public function create()
    {
        return view('permissions.create');
    }

    public function store(StorePermissionRequest $request)
    {
        Permission::create(['name' => $request->name]);
        return redirect()->route('permissions.index')->with('success', 'Permission created.');
    }

    public function edit(Permission $permission)
    {
        return view('permissions.edit', compact('permission'));
    }

    public function update(UpdatePermissionRequest $request, Permission $permission)
    {
        $permission->update(['name' => $request->name]);
        return redirect()->route('permissions.index')->with('success', 'Permission updated.');
    }

    public function destroy(Permission $permission)
    {
        $permission->delete();
        return redirect()->route('permissions.index')->with('success', 'Permission deleted.');
    }

    public function generatePermissions()
    {
        Artisan::call('generate:permissions');
        return back()->with('success', 'Permissions generated successfully!');
    }


    public function deleteAll()
    {
        Permission::truncate(); // deletes all records safely

        return redirect()->back()->with('success', 'All permissions deleted successfully!');
    }

}
