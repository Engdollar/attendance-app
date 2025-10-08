<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>@yield('title', 'Fila – Admin Dashboard')</title>

    <!-- CSS -->
    <link rel="stylesheet" href="{{ asset('theme/assets/css/sidebar-menu.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/simplebar.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/prism.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/quill.snow.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/remixicon.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/swiper-bundle.min.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/jsvectormap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/style.css') }}">

    


    <!-- Favicon -->
    <link rel="icon" type="image/png" href="{{ asset('theme/assets/images/icon-logo.png') }}">
    @stack('styles')
</head>

<body class="bg-body-bg">
    <!-- Preloader -->
    <div class="preloader" id="preloader">
        <div class="preloader">
            <div class="waviy position-relative">
                <span class="d-inline-block">A</span>
                <span class="d-inline-block">W</span>
                <span class="d-inline-block">D</span>
                <span class="d-inline-block">A</span>
                <span class="d-inline-block">L</span>
                <span class="d-inline-block"> </span>
                <span class="d-inline-block">E</span>
                <span class="d-inline-block">L</span>
                <span class="d-inline-block">E</span>
                <span class="d-inline-block">C</span>
                <span class="d-inline-block">T</span>
                <span class="d-inline-block">R</span>
                <span class="d-inline-block">I</span>
                <span class="d-inline-block">C</span>
                <span class="d-inline-block">I</span>
                <span class="d-inline-block">T</span>
                <span class="d-inline-block">Y</span>
            </div>
        </div>
    </div>

    <!-- Page Content -->
    @yield('content')

    


    <!-- Link Of JS File -->
    <script src="{{ asset('theme/assets/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/sidebar-menu.js') }}"></script>
    <script src="{{ asset('theme/assets/js/quill.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/data-table.js') }}"></script>
    <script src="{{ asset('theme/assets/js/prism.js') }}"></script>
    <script src="{{ asset('theme/assets/js/clipboard.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/simplebar.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/apexcharts.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/echarts.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/swiper-bundle.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/fullcalendar.main.js') }}"></script>
    <script src="{{ asset('theme/assets/js/jsvectormap.min.js') }}"></script>
    <script src="{{ asset('theme/assets/js/world-merc.js') }}"></script>
    <script src="{{ asset('theme/assets/js/custom/apexcharts.js') }}"></script>
    <script src="{{ asset('theme/assets/js/custom/echarts.js') }}"></script>
    <script src="{{ asset('theme/assets/js/custom/maps.js') }}"></script>
    <script src="{{ asset('theme/assets/js/custom/custom.js') }}"></script>



    @stack('scripts')
</body>

</html>