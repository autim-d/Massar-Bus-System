<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('buses', function (Blueprint $table) {
            $table->id();
            $table->string('bus_name', 50)->unique();
            $table->string('plate_number', 50)->unique();
            $table->unsignedInteger('capacity');
            $table->enum('status', ['active', 'maintenance', 'retired'])->default('active');
            $table->timestamps();
            $table->softDeletes();
            
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('buses');
    }
};
