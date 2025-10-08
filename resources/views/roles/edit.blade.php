@extends('layouts.app')
@section('content')
    <div class="container mt-4">
        <div class="card shadow">
            <div class="card-header">
                <h4>Edit Role</h4>
            </div>
            <div class="card-body">
                
        <form method="POST" action="{{ route('roles.update', $role) }}" class="mt-3">
            @csrf @method('PUT')
            <div class="mb-3">
                <label class="form-label">Role Name</label>
                <input type="text" name="name" value="{{ old('name', $role->name) }}"
                    class="form-control @error('name') is-invalid @enderror">
                @error('name')
                    <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>

            @php
                // Works for both create (no $role) and edit (has $role)
                $selected = isset($role) ? $role->permissions->pluck('name')->toArray() : [];
            @endphp

            <div class="mb-3">
                <label class="form-label">Permissions</label>

                {{-- Global Select All --}}
                <div class="form-check mb-3">
                    <input type="checkbox" id="selectAll" class="form-check-input">
                    <label for="selectAll" class="form-check-label fw-bold">Select All Permissions</label>
                </div>

                @foreach ($groupedPermissions as $table => $perms)
                    <div class="card mb-3">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <strong>{{ ucfirst($table) }} Permissions</strong>
                            <div class="form-check m-0">
                                <input type="checkbox" class="form-check-input select-group"
                                    data-group="{{ $table }}" id="select-{{ $table }}">
                                <label for="select-{{ $table }}" class="form-check-label">Select All</label>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                @foreach ($perms as $perm)
                                    <div class="col-md-3">
                                        <div class="form-check">
                                            <input class="form-check-input perm-checkbox group-{{ $table }}"
                                                type="checkbox" name="permissions[]" value="{{ $perm->name }}"
                                                {{ in_array($perm->name, $selected) ? 'checked' : '' }}>
                                            <label class="form-check-label">{{ $perm->name }}</label>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>




            @can('update-roles')
                <button class="btn btn-primary">Update</button>
            @endcan
            <a href="{{ route('roles.index') }}" class="btn btn-secondary">Cancel</a>
        </form>
            </div>
        </div>
    </div>
@endsection
