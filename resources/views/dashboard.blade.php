@extends('layouts.app')

@section('title', 'E-Network Dashboard')

@section('content')
<!-- top widgets rows -->
<div class="row">
    <div class="col-lg-6">
        <div class="card bg-white p-20 rounded-10 border border-white mb-4">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <h3>Total Sales</h3>
                <div class="dropdown select-dropdown without-border">
                    <button class="dropdown-toggle bg-transparent text-secondary fs-15">
                        Year 2025
                    </button>
                </div>
            </div>
            <div id="total_sales_chart"></div>
        </div>
    </div>

    <!-- copy the rest of the HTML chunks here -->
    <!-- keep only the inside of <div class="row">…</div> -->
</div>
@endsection

@push('scripts')
<script>
    /* Init charts when DOM ready */
    document.addEventListener('DOMContentLoaded', function () {
        if (typeof initTotalSalesChart === 'function') initTotalSalesChart();
        if (typeof initProfitChart === 'function') initProfitChart();
        // …other chart inits…
    });
</script>
@endpush