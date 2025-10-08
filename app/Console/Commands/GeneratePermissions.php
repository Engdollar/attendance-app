<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;

class GeneratePermissions extends Command
{
    protected $signature = 'generate:permissions';
    protected $description = 'Generate CRUD permissions from database tables';

    public function handle()
    {
        // detect database driver
        $driver = DB::getDriverName();

        if ($driver === 'sqlite') {
            // SQLite: fetch all table names
            $tables = DB::select("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
            $tables = array_map(fn($table) => $table->name, $tables);
        } elseif ($driver === 'mysql') {
            // MySQL
            $database = DB::getDatabaseName();
            $tables = DB::select("SHOW TABLES");
            $tables = array_map(fn($table) => $table->{"Tables_in_$database"}, $tables);
        } else {
            $this->error("❌ Database driver [$driver] not supported yet.");
            return;
        }

        // Tables to ignore
        $excludedTables = [
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

        // CRUD actions
        $actions = ['create', 'read', 'update','edit', 'delete', 'view'];

        foreach ($tables as $table) {
            if (in_array($table, $excludedTables)) {
                $this->warn("⚠️ Skipped table: {$table}");
                continue;
            }

            foreach ($actions as $action) {
                $permissionName = "{$action}-{$table}";
                if (Permission::where('name', $permissionName)->exists()) {
                    $this->warn("⚠️ Already exists: {$permissionName}");
                } else {
                    try {
                        Permission::create(['name' => $permissionName]);
                        $this->info("✅ Created permission: {$permissionName}");
                    } catch (\Exception $e) {
                        $this->error("❌ Failed to create: {$permissionName} | Error: " . $e->getMessage());
                    }
                }
            }
        }

        $this->info('🎉 Permissions generation completed successfully.');
    }
}
