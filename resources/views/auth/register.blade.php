<x-guest-layout>
    <!--authentication-->

    <div class="row g-0">

        <div
            class="col-12 col-xl-7 col-xxl-8 auth-cover-left align-items-center justify-content-center d-none d-xl-flex border-end bg-transparent">

            <div class="card rounded-0 mb-0 border-0 shadow-none bg-transparent bg-none">
                <div class="card-body">
                    <img src="{{ asset('theme/assets/images/auth/register1.png') }}" class="img-fluid auth-img-cover-login" width="500"
                        alt="">
                </div>
            </div>

        </div>

        <div class="col-12 col-xl-5 col-xxl-4 auth-cover-right align-items-center justify-content-center">
            <div class="card rounded-0 m-3 border-0 shadow-none bg-none">
                <div class="card-body p-sm-5">
                    <center> 
                    <img src="{{ asset('storage/logo/logo.png') }}" class="mb-4 text-center" width="95" alt="">
                         </center>
                    <h4 class="fw-bold">Get Started Now</h4>
                    <p class="mb-0">Enter your credentials to create your account</p>



                    <div class="form-body mt-4">
                        <form class="row g-3" method="POST" action="{{ route('register') }}">
                            @csrf
                            <div class="col-12">
                                <label for="name" class="form-label">Name</label>
                                <input class="form-control" id="name" type="text" name="name" :value="old('name')"
                                    required autofocus autocomplete="name">
                                <x-input-error :messages="$errors->get('name')" class="mt-2" />
                            </div>
                            <div class="col-12">
                                <label for="email" class="form-label">Email</label>
                                <input class="form-control" id="email" type="email" name="email" :value="old('email')"
                                    required autocomplete="username">
                                <x-input-error :messages="$errors->get('name')" class="mt-2" />
                            </div>

                            <div class="col-12">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group" id="show_hide_password">
                                    <input type="password" class="form-control" id="password" type="password"
                                        name="password" required autocomplete="new-password">
                                    <a href="javascript:;" class="input-group-text bg-transparent"><i
                                            class="bi bi-eye-slash-fill"></i></a>
                                    <x-input-error :messages="$errors->get('password')" class="mt-2" />
                                </div>
                            </div>


                            <div class="col-12">
                                <label for="password_confirmation" class="form-label">Confirm Password</label>
                                <div class="input-group" id="show_hide_password">
                                    <input type="password" class="form-control" id="password_confirmation"
                                        type="password" name="password_confirmation" required
                                        autocomplete="new-password">
                                    <a href="javascript:;" class="input-group-text bg-transparent"><i
                                            class="bi bi-eye-slash-fill"></i></a>
                                    <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked">
                                    <label class="form-check-label" for="flexSwitchCheckChecked">I read and
                                        agree to
                                        Terms &amp; Conditions</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-grd-danger">Register</button>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="text-start">
                                    <p class="mb-0">Already have an account? <a href="{{ route('login') }}">Sign in
                                            here</a></p>
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