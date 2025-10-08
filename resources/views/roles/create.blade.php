@extends('layouts.app')
@section('content')
    <div class="card shadow">
        <div class="card-header">
            <h5>Create Role</h5>

        </div>
        <div class="card-body">
            <div class="container mt-4">
                <form method="POST" action="{{ route('roles.store') }}" class="mt-3">
                    @csrf
                    <div class="mb-3">
                        <label class="form-label">Role Name</label>
                        <input type="text" name="name" value="{{ old('name') }}"
                            class="form-control @error('name') is-invalid @enderror">
                        @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Permissions</label>
                        <div class="row">
                            @foreach($permissions as $perm)
                                <div class="col-md-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="permissions[]"
                                            value="{{ $perm->name }}">
                                        <label class="form-check-label">{{ $perm->name }}</label>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    <button class="btn btn-primary">Save</button>
                    <a href="{{ route('roles.index') }}" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>
@endsection