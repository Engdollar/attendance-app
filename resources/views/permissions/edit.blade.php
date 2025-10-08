@extends('layouts.app')
@section('content')
    <div class="container mt-4">
        <h3>Edit Permission</h3>
        <form method="POST" action="{{ route('permissions.update', $permission) }}" class="mt-3">
            @csrf @method('PUT')
            <div class="mb-3">
                <label class="form-label">Permission Name</label>
                <input type="text" name="name" value="{{ old('name', $permission->name) }}"
                    class="form-control @error('name') is-invalid @enderror">
                @error('name')
                    <div class="invalid-feedback">{{ $message }}</div>
                @enderror
            </div>
            @can('update-permissions')
                <button class="btn btn-primary">Update</button>
            @endcan
            <a href="{{ route('permissions.index') }}" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
@endsection
