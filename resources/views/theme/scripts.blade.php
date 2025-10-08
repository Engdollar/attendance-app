<!-- Core JS -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
    integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<!-- optional: responsive plug-in (doesn’t hurt even if you don’t use it) -->
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>


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
<script src="{{  asset('theme/assets/js/custom/apexcharts.js') }}"></script>
<script src="{{ asset('theme/assets/js/custom/echarts.js') }}"></script>
<script src="{{ asset('theme/assets/js/custom/custom.js') }}"></script>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.full.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
@stack('scripts')


<script>
    $(document).ready(function() {
        $('#example').DataTable();
    });
</script>

<script>
    @if (session('success'))
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '{{ session('success') }}',
            timer: 3000,
            timerProgressBar: true,
            showConfirmButton: false
        });
    @endif

    @if (session('error'))
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
<script>
    document.querySelectorAll('.btn-delete').forEach(button => {
        button.addEventListener('click', function() {
            const form = this.closest('form');
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
        });
    });
</script>

<script></script>

<script>
    document.querySelectorAll('.btn-delete-all').forEach(button => {
        button.addEventListener('click', function() {
            const form = this.closest('form');
            Swal.fire({
                title: 'Are you sure?',
                text: "All permissions will be permanently deleted!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, delete all!'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
        });
    });
</script>

<script>
    // Global select all
    document.getElementById('selectAll').addEventListener('change', function() {
        const checked = this.checked;
        document.querySelectorAll('.form-check-input[type=checkbox]').forEach(cb => {
            cb.checked = checked;
        });
    });

    // Group select all
    document.querySelectorAll('.select-group').forEach(groupCheckbox => {
        groupCheckbox.addEventListener('change', function() {
            const group = this.dataset.group;
            const checked = this.checked;
            document.querySelectorAll('.group-' + group).forEach(cb => {
                cb.checked = checked;
            });
        });
    });


    document.querySelectorAll('input[name="theme-options"]').forEach(el => {
        el.addEventListener('change', function() {
            const theme = this.dataset.theme;

            fetch('{{ route('theme.update') }}', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')
                        .getAttribute('content'),
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    theme: theme
                })
            }).then(res => {
                if (res.ok) {
                    document.body.className = theme; // apply theme immediately
                }
            });
        });
    });
</script>
