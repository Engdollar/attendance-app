@extends('layouts.app')

@section('content')
    <div class="container mt-4">
        <div class="card shadow">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6>Users</h6>
                    @can('create-users')
                        <a href="{{ route('users.create') }}" class="btn btn-primary btn-sm">Add User</a>
                    @endcan
                </div>
            </div>
            <div class="card-body ">
                <div class="table-responsive">
                    <table id="example" class="table table-striped table-hover align-middle">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Roles</th>
                                @can('view-permissions')
                                    <th>Permissions</th>
                                @endcan
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($users as $i => $u)
                                <tr>
                                    <td>{{ $loop->index + 1 }}</td>
                                    <td>{{ $u->name }}</td>
                                    <td>{{ $u->email }}</td>
                                    <td>
                                        @forelse($u->roles as $r)
                                            <span class="badge bg-info text-dark mb-1">{{ $r->name }}</span>
                                        @empty
                                            <span class="text-muted">—</span>
                                        @endforelse
                                    </td>

                                    @can('view-permissions')
                                        <td>


                                            <!-- Button to toggle permissions -->
                                            <button class="btn btn-sm btn-info" type="button" data-bs-toggle="collapse"
                                                data-bs-target="#perms-{{ $u->id }}">
                                                View Permissions
                                            </button>

                                            <!-- Collapsible div -->
                                            <div class="collapse mt-2" id="perms-{{ $u->id }}">
                                                @forelse($u->permissions as $perm)
                                                    <span class="badge bg-secondary mb-1">{{ $perm->name }}</span>
                                                @empty
                                                    <span class="text-muted">— No permissions assigned —</span>
                                                @endforelse
                                            </div>
                                        </td>
                                    @endcan

                                    <td class="text-end">
                                        @can('edit-users')
                                            <a href="{{ route('users.edit', $u) }}" class="btn btn-sm btn-outline-warning  "><i
                                                    class="material-icons-outlined">edit</i></a>
                                        @endcan

                                        @can('delete-users')
                                            <form action="{{ route('users.destroy', $u) }}" method="POST"
                                                class="d-inline delete-form">
                                                @csrf @method('DELETE')
                                                <button type="button" class="btn btn-sm btn-outline-danger btn-delete"><i
                                                        class="material-icons-outlined">delete</i></button>
                                            </form>
                                        @endcan


                                    </td>
                                </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">No users found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    @endsection

    @section('some_scripts')
        <script>
            $(document).ready(function() {
                $('#example').DataTable();
            });
        </script>
    @endsection
