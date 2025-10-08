<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    protected array $excludedTables = [
        'sessions',
        'role_has_permissions',
        'password_reset_tokens',
        'model_has_roles',
        'model_has_permissions',
        'migrations',
        'jobs',
        'job_batches',
        'failed_jobs',
        'cache_locks',
        'cache'
    ];

    protected array $actions = ['create', 'read', 'update', 'edit', 'delete', 'view'];

    public function run(): void
    {
        // 1️⃣ Create admin role
        $adminRole = Role::firstOrCreate(['name' => 'admin']);

        // 2️⃣ Generate permissions dynamically
        foreach ($this->getTables() as $table) {
            if (in_array($table, $this->excludedTables))
                continue;

            foreach ($this->actions as $action) {
                Permission::firstOrCreate(['name' => "{$action}-{$table}"]);
            }
        }

        // 3️⃣ Assign all permissions to admin role
        $adminRole->syncPermissions(Permission::all());
        $supervisorRole = Role::firstOrCreate(['name' => 'supervisor']);

        // 4️⃣ Create admin user and assign role
        User::firstOrCreate(
            ['email' => 'sakiyare123@gmail.com'],
            [
                'name' => 'Eng Abdriahman A. Dollar',
                'password' => Hash::make('password'),
            ]
        )->assignRole($adminRole);
        User::firstOrCreate(
            ['email' => 'abdirahman.dollar45@gmail.com'],
            [
                'name' => 'Eng A. Dollar',
                'password' => Hash::make('password'),
            ]
        )->assignRole($supervisorRole);

        $this->command->info("✅ Admin role, user, and permissions created successfully!");
    }

    protected function getTables(): array
    {
        $driver = DB::getDriverName();

        return match ($driver) {
            'sqlite' => array_map(fn($t) => $t->name, DB::select(
                "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
            )),
            'mysql' => array_map(fn($t) => $t->{"Tables_in_" . DB::getDatabaseName()}, DB::select("SHOW TABLES")),
            default => throw new \Exception("Database driver [$driver] not supported"),
        };
    }
}
