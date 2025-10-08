<x-guest-layout>



    <div class="row g-0">

        <div
            class="col-12 col-xl-7 col-xxl-8 auth-cover-left align-items-center justify-content-center d-none d-xl-flex border-end bg-transparent">

            <div class="card rounded-0 mb-0 border-0 shadow-none bg-transparent bg-none">
                <div class="card-body">
                    <img src="{{ asset('theme/assets/images/auth/reset-password1.png') }}"
                        class="img-fluid auth-img-cover-login" width="550" alt="">
                </div>
            </div>

        </div>

        <div class="col-12 col-xl-5 col-xxl-4 auth-cover-right align-items-center justify-content-center">
            <div class="card rounded-0 m-3 mb-0 border-0 shadow-none bg-none">
                <div class="card-body p-sm-5">
                    <center>
                        <img src="{{ asset('storage/logo/logo.png') }}" class="mb-4 text-center" width="95" alt="">
                    </center>
                    <h4 class="fw-bold">Forgot Password?</h4>
                    <p class="mb-0">No problem. Just let us know your email address and we will email you a password
                        reset link that will allow you to
                        choose a new one.</p>

                    <div class="form-body mt-4">
                        <form class="row g-4" method="POST" action="{{ route('password.email') }}">
                            @csrf
                            <div class="col-12">
                                <label class="form-label">Email id</label>
                                <input class="form-control" type="email" name="email" :value="old('email')" required
                                    autofocus placeholder="example@user.com">
                            </div>
                            <div class="col-12">
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-grd-info">Send</button>
                                    <a href="{{ route('login') }}" class="btn btn-light">Back to Login</a>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

    </div>
    <!--end row-->

    <!--authentication-->

</x-guest-layout>