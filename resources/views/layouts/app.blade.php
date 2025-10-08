<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
@include('theme.head')


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
                {{-- <span class="d-inline-block"> </span> --}}
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

    <!-- Sidebar -->
    @include('theme.sidebar')

    <!-- Main Content -->
    <div class="container-fluid">
        <div class="main-content d-flex flex-column">
            @include('theme.header')

            <!-- Page Content -->
            <div class="main-content-container overflow-hidden">
                {{-- Breadcrumbs (only shown if child pushes them) --}}
                @if (View::hasSection('breadcrumb'))
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4 mt-1">
                    <h3 class="mb-0">Patient Details</h3>

                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb align-items-center mb-0 lh-1">
                            @yield('breadcrumb')
                        </ol>
                    </nav>
                </div>
                @endif
                @yield('content')
            </div>

            @include('theme.footer')
        </div>
    </div>



    @include('theme.scripts')
</body>

</html>