<?php

namespace App\View\Components;

use App\Models\Customer;
use Illuminate\View\Component;

class TopBar extends Component
{
    public function __construct(public Customer $customer)
    {
    }   // ← match the prop you passed

    public function render()
    {
        return view('components.top-bar');
    }
}