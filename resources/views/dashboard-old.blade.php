@extends('layouts.app')

@section('content')
<div class="row d-flex justify-content-center">
    <div class="col-md-11">
        <div class="card shadow">
            <div class="card-body">
                @include('partials.leaflet-map')
            </div>
        </div>
    </div>
</div>
@endsection