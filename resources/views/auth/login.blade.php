@extends('layouts.guest')

@section('title', 'Sign In')

@section('content')
<div class="container-fluid">
    <div class="main-content d-flex flex-column p-0">
        <div class="m-lg-auto my-auto w-930 py-4">
            <div class="card bg-white border rounded-10 border-white py-100 px-130">
                <div class="p-md-5 p-4 p-lg-0">

                    {{-- Heading --}}
                    <div class="text-center mb-4">
                        <a href="{{ url('/') }}" class="d-inline-block mb-3">
                            <img src="{{ asset('theme/assets/images/icon-logo.png') }}"  width="60px"  alt="">
                        </a>
                        <h3 class="fs-26 fw-medium mb-1">Sign In</h3>
                        <p class="fs-16 text-secondary">
                            Try to access unlimited content <br>
                            Discover new ideas
                            
                        </p>
                    </div>

                    {{-- Session status --}}
                    <x-auth-session-status class="mb-3" :status="session('status')" />

                    {{-- Form --}}
                    <form method="POST" action="{{ route('login') }}">
                        @csrf

                        {{-- Email --}}
                        <div class="mb-20">
                            <label class="label fs-16 mb-2">Email Address</label>
                            <div class="form-floating">
                                <input type="email" class="form-control @error('email') is-invalid @enderror"
                                    id="floatingInput1" name="email" value="{{ old('email') }}"
                                    placeholder="Enter email address *" required autofocus>
                                <label for="floatingInput1">Enter email address *</label>
                            </div>
                            @error('email')
                            <div class="invalid-feedback d-block">{{ $message }}</div>
                            @enderror
                        </div>

                        {{-- Password --}}
                        <div class="mb-20">
                            <label class="label fs-16 mb-2">Your Password</label>
                            <div class="form-group" id="password-show-hide">
                                <div class="password-wrapper position-relative password-container">
                                    <input type="password"
                                        class="form-control text-secondary password @error('password') is-invalid @enderror"
                                        name="password" placeholder="Enter password *" required
                                        autocomplete="current-password">
                                    <i style="color: #A9A9C8; font-size: 22px; right: 15px;"
                                        class="ri-eye-off-line password-toggle-icon translate-middle-y top-50 position-absolute cursor text-secondary"
                                        aria-hidden="true"></i>
                                </div>
                            </div>
                            @error('password')
                            <div class="invalid-feedback d-block">{{ $message }}</div>
                            @enderror
                        </div>

                        {{-- Remember / Forgot --}}
                        <div class="mb-20">
                            <div class="d-flex justify-content-between align-items-center flex-wrap gap-1">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="remember" id="rememberMe">
                                    <label class="form-check-label fs-16" for="rememberMe">Remember me</label>
                                </div>
                                @if (Route::has('password.request'))
                                <a href="{{ route('password.request') }}"
                                    class="fs-16 text-primary fw-normal text-decoration-none">Forgot Password?</a>
                                @endif
                            </div>
                        </div>

                        {{-- Login button --}}
                        <div class="mb-4">
                            <button type="submit" class="btn btn-primary fw-normal text-white w-100"
                                style="padding-top: 18px; padding-bottom: 18px;">Sign In</button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
{{-- Password eye toggle --}}
<script>
    const eye = document.querySelector('.password-toggle-icon');
  const pwd = document.querySelector('.password');
  eye.addEventListener('click', () => {
    const isHidden = pwd.getAttribute('type') === 'password';
    pwd.setAttribute('type', isHidden ? 'text' : 'password');
    eye.classList.toggle('ri-eye-off-line');
    eye.classList.toggle('ri-eye-line');
  });
</script>
@endpush