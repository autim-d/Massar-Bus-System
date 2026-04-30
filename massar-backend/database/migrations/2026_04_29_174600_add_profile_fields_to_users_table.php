<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // Rename phone_number to phone
            $table->renameColumn('phone_number', 'phone');
            
            // Add gender and location
            $table->string('gender', 20)->nullable()->after('phone_number'); // it will be after the renamed column 'phone' usually, or we can just use after('email')
            $table->string('location', 255)->nullable()->after('gender');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->renameColumn('phone', 'phone_number');
            $table->dropColumn(['gender', 'location']);
        });
    }
};
