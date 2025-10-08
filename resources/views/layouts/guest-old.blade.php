<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" data-bs-theme="blue-theme">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!--favicon-->
    <link rel="icon" href="{{ asset('theme/assets/images/favicon-32x32.png') }}" type="image/png">
    <!-- loader-->
    <link href="{{ asset('theme/assets/css/pace.min.css') }}" rel="stylesheet">
    <script src="{{ asset('theme/assets/js/pace.min.js') }}"></script>

    <!--plugins-->
    <link href="{{ asset('theme/assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css') }}" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{{ asset('theme/assets/plugins/metismenu/metisMenu.min.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('theme/assets/plugins/metismenu/mm-vertical.css') }}">
    <!--bootstrap css-->
    <link href="{{ asset('theme/assets/css/bootstrap.min.css') }}" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Material+Icons+Outlined" rel="stylesheet">
    <!--main css-->
    <link href="{{ asset('theme/assets/css/bootstrap-extended.css') }}" rel="stylesheet">
    <link href="{{ asset('theme/sass/main.css') }}" rel="stylesheet">
    <link href="{{ asset('theme/sass/dark-theme.css') }}" rel="stylesheet">
    <link href="{{ asset('theme/sass/blue-theme.css') }}" rel="stylesheet">
    <link href="{{ asset('theme/sass/responsive.css') }}" rel="stylesheet">

</head>

<body>


    <!--authentication-->

    <div class="section-authentication-cover">
        <div class="">
            {{ $slot }}
            <!--end row-->
        </div>
    </div>

    <!--authentication-->




    <!--plugins-->
    <script src="{{ asset('theme/assets/js/jquery.min.js') }}"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        $(document).ready(function () {
            $("#show_hide_password a").on('click', function (event) {
                event.preventDefault();
                if ($('#show_hide_password input').attr("type") == "text") {
                    $('#show_hide_password input').attr('type', 'password');
                    $('#show_hide_password i').addClass("bi-eye-slash-fill");
                    $('#show_hide_password i').removeClass("bi-eye-fill");
                } else if ($('#show_hide_password input').attr("type") == "password") {
                    $('#show_hide_password input').attr('type', 'text');
                    $('#show_hide_password i').removeClass("bi-eye-slash-fill");
                    $('#show_hide_password i').addClass("bi-eye-fill");
                }
            });
        });
    </script>


    <script>
        @if(session('success'))
            Swal.fire({
                icon: 'success',
                title: 'Success!',
                text: '{{ session('success') }}',
                timer: 3000,
                timerProgressBar: true,
                showConfirmButton: false
            });
        @endif

        @if(session('error'))
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: '{{ session('error') }}',
                timer: 3000,
                timerProgressBar: true,
                showConfirmButton: false
            });
        @endif
    </script>

</body>

</html>