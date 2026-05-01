<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('trip_id')->constrained()->restrictOnDelete();
            $table->string('booking_code', 50)->unique();
            $table->decimal('ticket_price', 10, 2);
            $table->decimal('protection_price', 10, 2)->default(0.00);
            $table->decimal('service_fee', 10, 2)->default(0.00);
            $table->decimal('total_amount', 10, 2);
            $table->enum('status', ['pending', 'paid', 'cancelled', 'refunded'])->default('pending');
            $table->string('passenger_name')->nullable();
            $table->string('passenger_phone')->nullable();
            $table->dateTime('purchased_at')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('booking_code');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};
