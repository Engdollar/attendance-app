<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Fila – Laravel')</title>

    <link href="https://fonts.googleapis.com/css?family=Material+Icons+Outlined" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="{{ asset('theme/assets/css/sidebar-menu.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/simplebar.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/prism.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/quill.snow.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/remixicon.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/swiper-bundle.min.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/jsvectormap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('theme/assets/css/style.css') }}">


    <!-- core BS-5 styling -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <!-- extra skin: rounded, borders, hover-shadow -->
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">


    <!-- SweetAlert2 CSS & JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="{{ asset('theme/assets/images/icon-logo.png') }}">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

    <!-- Existing Breeze CSS -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <style>
        /* Uniform smaller buttons project-wide */
        .btn {
            font-size: 13px;
            /* default is 16px – pick your sweet spot */
            padding: 0.25rem 0.5rem;
            /* tighter vertical / horizontal */
            border-radius: 0.2rem;
            /* optional: slightly sharper corners */
            color: white;
        }

        .table .btn {
            font-size: 13px;
            padding: 0.25rem 0.5rem;
        }

        .card {
            background-color: white;
        }

        .card .card-header .btn {
            font-size: 12px;
            padding: 0.2rem 0.4rem;
        }

        .card .card-body .btn {
            font-size: 12px;
            padding: 0.2rem 0.4rem;
        }

        .card table {
            background-color: white;
        }
    </style>
    @stack('styles')
</head>