@extends('layouts.app')

@section('content')
    <div class="container mt-4">


        <div class="card shadow">
            <div class="card-header">
                <div class="d-flex justify-content-between mb-3 align-items-center">
                    <h5>Roles</h5>
                    @can('create-roles')
                    <a href="{{ route('roles.create') }}" class="btn btn-primary">Add Role</a>
                    @endcan
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="example" class="table table-bordered table-striped table-hover align-middle">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                @can('view-permissions')
                                    <th>Permissions</th>
                                @endcan
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($roles as $i => $role)
                                <tr>
                                    <td>{{ $loop->index + 1 }}</td>
                                    <td>{{ $role->name }}</td>
                                    @can('view-permissions')
                                        <td>
                                            <!-- Button to toggle permissions -->
                                            <button class="btn btn-sm btn-info btn-sm" type="button" data-bs-toggle="collapse"
                                                data-bs-target="#perms-{{ $role->id }}">
                                                <i class="fadeIn animated bx bx-show-alt">view</i>
                                            </button>

                                            <!-- Collapsible div -->
                                            <div class="collapse mt-2" id="perms-{{ $role->id }}">
                                                @forelse($role->permissions as $perm)
                                                    <span class="badge bg-secondary mb-1">{{ $perm->name }}</span>
                                                @empty
                                                    <span class="text-muted">— No permissions assigned —</span>
                                                @endforelse
                                            </div>
                                        </td>
                                    @endcan

                                    <td class="text-end">
                                        @can('edit-roles')
                                            <a href="{{ route('roles.edit', $role) }}" class="btn btn-sm btn-warning "><i
                                                    class="material-icons-outlined">edit</i></a>
                                        @endcan
                                        @can('delete-roles')
                                            <form action="{{ route('roles.destroy', $role) }}" method="POST"
                                                class="d-inline delete-form">
                                                @csrf
                                                @method('DELETE')
                                                <button type="button" class="btn btn-sm btn-danger btn-delete "><i
                                                        class="material-icons-outlined">delete</i></button>
                                            </form>
                                        @endcan
                                    </td>
                                </tr>
                                @empty
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">No roles found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    @endsection
