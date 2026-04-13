<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Station;
use App\Http\Resources\StationResource;

class StationController extends Controller
{
    public function index()
    {
        return StationResource::collection(Station::all());
    }
}
