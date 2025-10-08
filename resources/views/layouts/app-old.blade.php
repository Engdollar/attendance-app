<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" data-bs-theme="light">

<!-- start head -->
@include('theme.head')
<!-- end  head -->

<body>

    <!--start header-->
    @include('theme.header')
    <!--end top header-->


    <!--start sidebar-->
    @include('theme.sidebar')

    <!--end sidebar-->

    <!--start main wrapper-->
    <main class="main-wrapper">
        <div class="main-content">
            
            @yield('content')
        </div>
    </main>
    <!--end main wrapper-->

    <!--start overlay-->
    <div class="overlay btn-toggle"></div>
    <!--end overlay-->

    <!--start footer-->
    @include('theme.footer')

    <!--end footer-->


    <!--start switcher-->
    {{-- @include('theme.customizer') --}}

    <!--start switcher-->


    @include('theme.scripts')
 

    {{-- CHILD VIEWS PUSH THEIR OWN SCRIPTS HERE --}}
    @stack('scripts')

</body>

</html>