@extends('layouts.app')
@section('content')
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header">
            <h4>Create Permission</h4>
        </div>
        <div class="card-body">
            <form method="POST" action="{{ route('permissions.store') }}" class="mt-3">
                @csrf
                <div class="mb-3">
                    <label class="form-label">Permission Name</label>
                    <input type="text" name="name" value="{{ old('name') }}"
                        class="form-control @error('name') is-invalid @enderror">
                    @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <button class="btn btn-primary">Save</button>
                <a href="{{ route('permissions.index') }}" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>
</div>
@endsection