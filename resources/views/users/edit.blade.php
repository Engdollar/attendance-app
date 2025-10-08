@extends('layouts.app')
@section('content')
    <div class="container mt-4">
        <div class="card shadow">
            <div class="card-header">
                <h4>Edit User</h4>
            </div>
            <div class="card-body">
                <div class="card shadow">
                    <div class="card-header">
                    </div>
                    <div class="card-body">
                        <form method="POST" action="{{ route('users.update', $user) }}" class="mt-3">
                            @csrf @method('PUT')

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Name</label>
                                    <input name="name" value="{{ old('name', $user->name) }}"
                                        class="form-control @error('name') is-invalid @enderror">
                                    @error('name')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email</label>
                                    <input name="email" value="{{ old('email', $user->email) }}"
                                        class="form-control @error('email') is-invalid @enderror">
                                    @error('email')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">New Password (optional)</label>
                                    <input type="password" name="password"
                                        class="form-control @error('password') is-invalid @enderror">
                                    @error('password')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                    @enderror
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Confirm Password</label>
                                    <input type="password" name="password_confirmation" class="form-control">
                                </div>
                            </div>

                            <div class="mb-3 col-4">
                                <label class="form-label">Assign Roles</label>
                                <select name="roles[]" class="form-select" multiple>
                                    @foreach ($roles as $r)
                                        <option value="{{ $r->name }}"
                                            {{ $user->roles->pluck('name')->contains($r->name) ? 'selected' : '' }}>
                                            {{ $r->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>

                            @can('update-users')
                                <button class="btn btn-primary">Update</button>
                            @endcan

                            <a href="{{ route('users.index') }}" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
