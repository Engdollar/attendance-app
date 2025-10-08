@extends('layouts.app')
@section('content')
    <div class="container mt-4">
        <div class="card shadow">
            <div class="card-header">
                <h5>Permissions</h5>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-around mb-3">
                    <div>
                        @can('create-permissions')
                            <a href="{{ route('permissions.create') }}" class="btn btn-sm btn-primary">
                                <i class="material-icons-outlined">add</i>
                            </a>
                        @endcan
                    </div>
                    <div>
                        @can('create-permissions')
                            <form action="{{ route('permissions.generate') }}" method="get">
                                @csrf
                                <button type="submit" class="btn btn-primary">
                                    <i class="material-icons-outlined">generate</i>
                                </button>
                            </form>
                        @endcan
                    </div>
                    <div>
                        @can('delete-permissions')
                            <form action="{{ route('permissions.deleteAll') }}" method="POST" class="d-inline delete-all-form">
                                @csrf
                                @method('DELETE')
                                <button type="button" class="btn btn-danger btn-delete-all"><i
                                        class="material-icons-outlined">delete</i></button>
                            </form>
                        @endcan

                    </div>
                </div>


                <div class="table-responsive">
                    <table id="example" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($permissions as $i => $permission)
                                <tr>
                                    <td>{{ $loop->index + 1 }}</td>
                                    <td>{{ $permission->name }}</td>
                                    <td class="text-end">
                                        @can('edit-permissions')
                                            <a href="{{ route('permissions.edit', $permission) }}"
                                                class="btn btn-sm btn-warning"><i class="material-icons-outlined">edit</i></a>
                                        @endcan
                                        @can('delete-permissions')
                                            <form action="{{ route('permissions.destroy', $permission) }}" method="POST"
                                                class="d-inline delete-form">
                                                @csrf @method('DELETE')
                                                <button type="button" class="btn btn-sm btn-danger btn-delete"><i
                                                        class="material-icons-outlined">delete</i></button>
                                            </form>
                                        @endcan


                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="text-center text-muted">No permissions found.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
@endsection
