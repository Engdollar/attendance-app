<!-- Start Sidebar Area -->
<div class="sidebar-area" id="sidebar-area">
    <div class="logo position-relative d-flex align-items-center justify-content-between">
        <a href="{{ route('dashboard') }}" class="d-block text-decoration-none position-relative">
            <img src="{{ asset('theme/assets/images/icon-logo.png') }}" width="39px;" alt="logo-icon">
            <span class="logo-text text-secondary fw-semibold">AE</span>
        </a>
        <button
            class="sidebar-burger-menu-close bg-transparent py-3 border-0 opacity-0 z-n1 position-absolute top-50 end-0 translate-middle-y"
            id="sidebar-burger-menu-close">
            <span class="border-1 d-block for-dark-burger"
                style="border-bottom: 1px solid #475569; height: 1px; width: 25px; transform: rotate(45deg);"></span>
            <span class="border-1 d-block for-dark-burger"
                style="border-bottom: 1px solid #475569; height: 1px; width: 25px; transform: rotate(-45deg);"></span>
        </button>
        <button class="sidebar-burger-menu bg-transparent p-0 border-0" id="sidebar-burger-menu">
            <span class="border-1 d-block for-dark-burger"
                style="border-bottom: 1px solid #475569; height: 1px; width: 25px;"></span>
            <span class="border-1 d-block for-dark-burger"
                style="border-bottom: 1px solid #475569; height: 1px; width: 25px; margin: 6px 0;"></span>
            <span class="border-1 d-block for-dark-burger"
                style="border-bottom: 1px solid #475569; height: 1px; width: 25px;"></span>
        </button>
    </div>

    <aside id="layout-menu" class="layout-menu menu-vertical menu active" data-simplebar>
        <ul class="menu-inner">
            <li class="menu-title small text-uppercase">
                <span class="menu-title-text">MAIN</span>
            </li>
            <li class="menu-item open">
                <a href="javascript:void(0);" class="menu-link menu-toggle active">
                    <span class="material-symbols-outlined menu-icon">dashboard</span>
                    <span class="title">Dashboard</span>
                    <span class="count">2</span>
                </a>

                <ul class="menu-sub">
                    <li class="menu-item">
                        <a href="{{ route('dashboard') }}"
                            class="menu-link active">
                            E-Network
                        </a>
                    </li>
                    <li class="menu-item">
                        <a href="" class="menu-link ">
                            CRM
                        </a>
                    </li>

                </ul>
            </li>



            {{-- <li class="menu-title small text-uppercase">
                <span class="menu-title-text">PAGES</span>
            </li> --}}


           











            <!-- ADMIN -->
            @canany(['view-users', 'view-roles', 'view-permissions'])
                <li class="menu-title small text-uppercase">
                    <span class="menu-title-text">Admin</span>
                </li>
            @endcanany

            {{-- Users dropdown --}}
            @can('view-users')
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <span class="material-symbols-outlined menu-icon">badge</span>
                        <span class="title">Users</span>
                    </a>
                    <ul class="menu-sub">
                        @can('view-users')
                            <li class="menu-item"><a class="menu-link" href="{{ url('users') }}">List</a></li>
                        @endcan
                        @can('create-users')
                            <li class="menu-item"><a class="menu-link" href="{{ url('users/create') }}">Create</a></li>
                        @endcan
                    </ul>
                </li>
            @endcan

            {{-- Roles dropdown --}}
            @can('view-roles')
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <span class="material-symbols-outlined menu-icon">verified_user</span>
                        <span class="title">Roles</span>
                    </a>
                    <ul class="menu-sub">
                        @can('view-roles')
                            <li class="menu-item"><a class="menu-link" href="{{ url('roles') }}">List</a></li>
                        @endcan
                        @can('create-roles')
                            <li class="menu-item"><a class="menu-link" href="{{ url('roles/create') }}">Create</a></li>
                        @endcan
                    </ul>
                </li>
            @endcan

            {{-- Permissions dropdown --}}
            @can('view-permissions')
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <span class="material-symbols-outlined menu-icon">lock</span>
                        <span class="title">Permissions</span>
                    </a>
                    <ul class="menu-sub">
                        @can('view-permissions')
                            <li class="menu-item"><a class="menu-link" href="{{ url('permissions') }}">List</a></li>
                        @endcan
                        @can('create-permissions')
                            <li class="menu-item"><a class="menu-link" href="{{ url('permissions/create') }}">Create</a></li>
                        @endcan
                    </ul>
                </li>
            @endcan

            <!-- Logout -->
            <li class="menu-item">
                <a href="{{ route('logout') }}" class="menu-link"
                    onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                    <span class="material-symbols-outlined menu-icon">logout</span>
                    <span class="title">Logout</span>
                </a>
                <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                    @csrf
                </form>
            </li>
        </ul>
    </aside>
</div>
<!-- End Sidebar Area -->