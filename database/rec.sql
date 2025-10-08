BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "migrations" (
	"id"	integer NOT NULL,
	"migration"	varchar NOT NULL,
	"batch"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"email"	varchar NOT NULL,
	"email_verified_at"	datetime,
	"password"	varchar NOT NULL,
	"remember_token"	varchar,
	"created_at"	datetime,
	"updated_at"	datetime,
	"profile_photo"	varchar,
	"theme"	varchar NOT NULL DEFAULT 'BlueTheme',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "password_reset_tokens" (
	"email"	varchar NOT NULL,
	"token"	varchar NOT NULL,
	"created_at"	datetime,
	PRIMARY KEY("email")
);
CREATE TABLE IF NOT EXISTS "sessions" (
	"id"	varchar NOT NULL,
	"user_id"	integer,
	"ip_address"	varchar,
	"user_agent"	text,
	"payload"	text NOT NULL,
	"last_activity"	integer NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "cache" (
	"key"	varchar NOT NULL,
	"value"	text NOT NULL,
	"expiration"	integer NOT NULL,
	PRIMARY KEY("key")
);
CREATE TABLE IF NOT EXISTS "cache_locks" (
	"key"	varchar NOT NULL,
	"owner"	varchar NOT NULL,
	"expiration"	integer NOT NULL,
	PRIMARY KEY("key")
);
CREATE TABLE IF NOT EXISTS "jobs" (
	"id"	integer NOT NULL,
	"queue"	varchar NOT NULL,
	"payload"	text NOT NULL,
	"attempts"	integer NOT NULL,
	"reserved_at"	integer,
	"available_at"	integer NOT NULL,
	"created_at"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "job_batches" (
	"id"	varchar NOT NULL,
	"name"	varchar NOT NULL,
	"total_jobs"	integer NOT NULL,
	"pending_jobs"	integer NOT NULL,
	"failed_jobs"	integer NOT NULL,
	"failed_job_ids"	text NOT NULL,
	"options"	text,
	"cancelled_at"	integer,
	"created_at"	integer NOT NULL,
	"finished_at"	integer,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "failed_jobs" (
	"id"	integer NOT NULL,
	"uuid"	varchar NOT NULL,
	"connection"	text NOT NULL,
	"queue"	text NOT NULL,
	"payload"	text NOT NULL,
	"exception"	text NOT NULL,
	"failed_at"	datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "permissions" (
	"id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"guard_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "roles" (
	"id"	integer NOT NULL,
	"name"	varchar NOT NULL,
	"guard_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "model_has_permissions" (
	"permission_id"	integer NOT NULL,
	"model_type"	varchar NOT NULL,
	"model_id"	integer NOT NULL,
	PRIMARY KEY("permission_id","model_id","model_type"),
	FOREIGN KEY("permission_id") REFERENCES "permissions"("id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "model_has_roles" (
	"role_id"	integer NOT NULL,
	"model_type"	varchar NOT NULL,
	"model_id"	integer NOT NULL,
	PRIMARY KEY("role_id","model_id","model_type"),
	FOREIGN KEY("role_id") REFERENCES "roles"("id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "role_has_permissions" (
	"permission_id"	integer NOT NULL,
	"role_id"	integer NOT NULL,
	PRIMARY KEY("permission_id","role_id"),
	FOREIGN KEY("role_id") REFERENCES "roles"("id") on delete cascade,
	FOREIGN KEY("permission_id") REFERENCES "permissions"("id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "zones" (
	"zone_id"	integer NOT NULL,
	"zone_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("zone_id" AUTOINCREMENT),
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "sub_zones" (
	"sub_zone_id"	integer NOT NULL,
	"zone_id"	integer NOT NULL,
	"sub_zone_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("sub_zone_id" AUTOINCREMENT),
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("zone_id") REFERENCES "zones"("zone_id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "teams" (
	"team_id"	integer NOT NULL,
	"supervisor_id"	integer NOT NULL,
	"team_name"	varchar NOT NULL,
	"vehicle_no"	varchar,
	"tech_lead_phone"	varchar,
	"on_duty"	tinyint(1) NOT NULL DEFAULT '1',
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("team_id" AUTOINCREMENT),
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("supervisor_id") REFERENCES "users"("id") on delete restrict,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "customers" (
	"customer_id"	integer NOT NULL,
	"sub_zone_id"	integer NOT NULL,
	"supply_no"	varchar NOT NULL,
	"meter_no"	varchar NOT NULL,
	"full_name"	varchar NOT NULL,
	"phone"	varchar NOT NULL,
	"address"	varchar,
	"gps_lat"	numeric,
	"gps_lng"	numeric,
	"connection_date"	date,
	"status"	varchar NOT NULL DEFAULT 'Active' CHECK("status" IN ('Active', 'Disconnected')),
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("customer_id" AUTOINCREMENT),
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("sub_zone_id") REFERENCES "sub_zones"("sub_zone_id") on delete cascade,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "team_members" (
	"member_id"	integer NOT NULL,
	"team_id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"is_leader"	tinyint(1) NOT NULL DEFAULT '0',
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("member_id" AUTOINCREMENT),
	FOREIGN KEY("team_id") REFERENCES "teams"("team_id") on delete cascade,
	FOREIGN KEY("user_id") REFERENCES "users"("id") on delete cascade,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "asset_categories" (
	"cat_id"	integer NOT NULL,
	"cat_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("cat_id" AUTOINCREMENT),
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "assets" (
	"asset_id"	integer NOT NULL,
	"cat_id"	integer NOT NULL,
	"asset_tag"	varchar NOT NULL,
	"serial_no"	varchar,
	"manufacturer"	varchar,
	"install_date"	date,
	"status"	varchar NOT NULL DEFAULT 'In-Service' CHECK("status" IN ('In-Service', 'Spare', 'Scrapped')),
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("asset_id" AUTOINCREMENT),
	FOREIGN KEY("cat_id") REFERENCES "asset_categories"("cat_id") on delete cascade,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "stations" (
	"station_id"	integer NOT NULL,
	"station_name"	varchar NOT NULL,
	"lat"	numeric,
	"lng"	numeric,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("station_id" AUTOINCREMENT),
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "mv_lines" (
	"mv_line_id"	integer NOT NULL,
	"station_id"	integer NOT NULL,
	"from_sub_station_id"	integer,
	"code"	varchar NOT NULL,
	"mv_from_id"	integer,
	"commissioning_date"	date,
	"lat"	numeric,
	"lng"	numeric,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("mv_line_id" AUTOINCREMENT),
	FOREIGN KEY("mv_from_id") REFERENCES "mv_lines"("mv_line_id") on delete set null,
	FOREIGN KEY("from_sub_station_id") REFERENCES "sub_stations"("sub_station_id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("station_id") REFERENCES "stations"("station_id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "sub_stations" (
	"sub_station_id"	integer NOT NULL,
	"station_id"	integer NOT NULL,
	"sub_station_code"	varchar NOT NULL,
	"sub_station_name"	varchar NOT NULL,
	"mv_from_id"	integer,
	"breaking_capacity_kA"	numeric,
	"lat"	numeric,
	"lng"	numeric,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("sub_station_id" AUTOINCREMENT),
	FOREIGN KEY("mv_from_id") REFERENCES "mv_lines"("mv_line_id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("station_id") REFERENCES "stations"("station_id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "dt_lines" (
	"dt_line_id"	integer NOT NULL,
	"transformer_id"	integer NOT NULL,
	"dt_from_id"	integer,
	"code"	varchar NOT NULL,
	"type"	varchar NOT NULL DEFAULT 'Pole' CHECK("type" IN ('Pole', 'Ground', 'Kiosk')),
	"power_kva"	integer NOT NULL,
	"phase_A_capacity_A"	integer NOT NULL DEFAULT '100',
	"phase_B_capacity_A"	integer NOT NULL DEFAULT '100',
	"phase_C_capacity_A"	integer NOT NULL DEFAULT '100',
	"neutral_size_mm2"	numeric NOT NULL DEFAULT '50',
	"commissioning_date"	date,
	"lat"	numeric,
	"lng"	numeric,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("dt_line_id" AUTOINCREMENT),
	FOREIGN KEY("transformer_id") REFERENCES "transformers"("transformer_id") on delete cascade,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("dt_from_id") REFERENCES "dt_lines"("dt_line_id") on delete set null
);
CREATE TABLE IF NOT EXISTS "transformers" (
	"transformer_id"	integer NOT NULL,
	"mv_line_id"	integer NOT NULL,
	"code"	varchar NOT NULL,
	"power_kva"	integer NOT NULL,
	"commissioning_date"	date,
	"lat"	numeric,
	"lng"	numeric,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("transformer_id" AUTOINCREMENT),
	FOREIGN KEY("mv_line_id") REFERENCES "mv_lines"("mv_line_id") on delete cascade,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "maintenance_types" (
	"type_id"	integer NOT NULL,
	"type_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("type_id" AUTOINCREMENT),
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "service_drops" (
	"drop_id"	integer NOT NULL,
	"dt_line_id"	integer NOT NULL,
	"customer_id"	integer NOT NULL,
	"length_m"	integer NOT NULL,
	"phase_connected"	varchar NOT NULL DEFAULT 'A' CHECK("phase_connected" IN ('A', 'B', 'C', 'A+B', 'A+C', 'B+C', 'A+B+C')),
	"neutral_connected"	tinyint(1) NOT NULL DEFAULT '1',
	"install_date"	date,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("drop_id" AUTOINCREMENT),
	FOREIGN KEY("dt_line_id") REFERENCES "dt_lines"("dt_line_id") on delete cascade,
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id") on delete cascade,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "maintenance_tasks" (
	"task_id"	integer NOT NULL,
	"asset_id"	integer NOT NULL,
	"type_id"	integer NOT NULL,
	"team_id"	integer,
	"summary"	varchar NOT NULL,
	"scheduled_date"	date,
	"done_date"	date,
	"outcome"	varchar NOT NULL DEFAULT 'Pending' CHECK("outcome" IN ('Done', 'Pending', 'Failed')),
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("task_id" AUTOINCREMENT),
	FOREIGN KEY("type_id") REFERENCES "maintenance_types"("type_id") on delete cascade,
	FOREIGN KEY("asset_id") REFERENCES "assets"("asset_id") on delete cascade,
	FOREIGN KEY("team_id") REFERENCES "teams"("team_id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "spare_parts" (
	"part_id"	integer NOT NULL,
	"part_code"	varchar NOT NULL,
	"description"	varchar,
	"stock_qty"	integer NOT NULL DEFAULT '0',
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("part_id" AUTOINCREMENT),
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "task_parts" (
	"id"	integer NOT NULL,
	"task_id"	integer NOT NULL,
	"part_id"	integer NOT NULL,
	"qty"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("task_id") REFERENCES "maintenance_tasks"("task_id") on delete cascade,
	FOREIGN KEY("part_id") REFERENCES "spare_parts"("part_id") on delete cascade
);
CREATE TABLE IF NOT EXISTS "ticket_priorities" (
	"priority_id"	integer NOT NULL,
	"priority_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	PRIMARY KEY("priority_id" AUTOINCREMENT),
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null
);
CREATE TABLE IF NOT EXISTS "ticket_status_types" (
	"status_id"	integer NOT NULL,
	"status_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	PRIMARY KEY("status_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ticket_histories" (
	"ticket_his_id"	integer NOT NULL,
	"ticket_id"	integer NOT NULL,
	"status_id"	integer NOT NULL,
	"remarks"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	FOREIGN KEY("ticket_id") REFERENCES "tickets"("ticket_id") on delete cascade,
	FOREIGN KEY("status_id") REFERENCES "ticket_status_types"("status_id") on delete restrict,
	PRIMARY KEY("ticket_his_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tickets" (
	"ticket_id"	integer NOT NULL,
	"service_type"	varchar NOT NULL CHECK("service_type" IN ('Billing', 'Technical')),
	"customer_id"	integer NOT NULL,
	"team_id"	integer,
	"priority_id"	integer NOT NULL,
	"status_id"	integer NOT NULL,
	"supervisor_id"	integer,
	"issue"	varchar NOT NULL,
	"agent_id"	integer NOT NULL,
	"open_date"	date NOT NULL,
	"dispatch_time"	datetime,
	"cust_comment"	text,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	FOREIGN KEY("team_id") REFERENCES "teams"("team_id") on delete set null,
	FOREIGN KEY("agent_id") REFERENCES "users"("id") on delete restrict,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id") on delete cascade,
	FOREIGN KEY("priority_id") REFERENCES "ticket_priorities"("priority_id") on delete restrict,
	FOREIGN KEY("status_id") REFERENCES "ticket_status_types"("status_id") on delete restrict,
	FOREIGN KEY("supervisor_id") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	PRIMARY KEY("ticket_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "event_types" (
	"event_type_id"	integer NOT NULL,
	"event_type_name"	varchar NOT NULL,
	"created_at"	datetime,
	"updated_at"	datetime,
	"created_by"	integer,
	"updated_by"	integer,
	FOREIGN KEY("created_by") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("updated_by") REFERENCES "users"("id") on delete set null,
	PRIMARY KEY("event_type_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tracking_events" (
	"event_id"	integer NOT NULL,
	"ticket_id"	integer NOT NULL,
	"user_id"	integer,
	"event_type_id"	integer,
	"ip_address"	varchar,
	"notes"	text,
	"created_at"	datetime,
	"updated_at"	datetime,
	FOREIGN KEY("ticket_id") REFERENCES "tickets"("ticket_id") on delete cascade,
	FOREIGN KEY("user_id") REFERENCES "users"("id") on delete set null,
	FOREIGN KEY("event_type_id") REFERENCES "event_types"("event_type_id") on delete set null,
	PRIMARY KEY("event_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "sms_outboxes" (
	"sms_id"	integer NOT NULL,
	"ticket_id"	integer NOT NULL,
	"to_phone"	varchar NOT NULL,
	"body"	varchar NOT NULL,
	"sent_at"	datetime,
	FOREIGN KEY("ticket_id") REFERENCES "tickets"("ticket_id") on delete cascade,
	PRIMARY KEY("sms_id" AUTOINCREMENT)
);
INSERT INTO "migrations" ("id","migration","batch") VALUES (1,'0001_01_01_000000_create_users_table',1),
 (2,'0001_01_01_000001_create_cache_table',1),
 (3,'0001_01_01_000002_create_jobs_table',1),
 (4,'2025_08_20_083753_create_permission_tables',1),
 (5,'2025_08_21_071833_add_profile_photo_to_users_table',1),
 (6,'2025_08_24_071058_add_theme_to_users_table',1),
 (7,'2025_09_23_211831_create_zones_table',1),
 (8,'2025_09_23_211912_create_sub_zones_table',1),
 (9,'2025_09_23_211922_create_teams_table',1),
 (10,'2025_09_23_211923_create_customers_table',1),
 (11,'2025_09_23_211923_create_team_members_table',1),
 (12,'2025_09_23_211924_create_asset_categories_table',1),
 (13,'2025_09_23_211924_create_assets_table',1),
 (14,'2025_09_23_211925_create_stations_table',1),
 (15,'2025_09_23_211926_create_mv_lines_table',1),
 (16,'2025_09_23_211926_create_sub_stations_table',1),
 (17,'2025_09_23_211927_create_dt_lines_table',1),
 (18,'2025_09_23_211927_create_transformers_table',1),
 (19,'2025_09_23_211928_create_maintenance_types_table',1),
 (20,'2025_09_23_211928_create_service_drops_table',1),
 (21,'2025_09_23_211929_create_maintenance_tasks_table',1),
 (22,'2025_09_23_211930_create_spare_parts_table',1),
 (23,'2025_09_23_211930_create_task_parts_table',1),
 (24,'2025_09_23_211931_create_ticket_priorities_table',1),
 (25,'2025_09_23_211931_create_ticket_status_types_table',1),
 (26,'2025_09_23_211932_create_ticket_histories_table',1),
 (27,'2025_09_23_211932_create_tickets_table',1),
 (28,'2025_09_23_211933_create_event_types_table',1),
 (29,'2025_09_23_211933_create_tracking_events_table',1),
 (30,'2025_09_23_211934_create_sms_outboxes_table',1);
INSERT INTO "users" ("id","name","email","email_verified_at","password","remember_token","created_at","updated_at","profile_photo","theme") VALUES (1,'Admin','admin@gmail.com',NULL,'$2y$12$kixP4PLXoGk0no27QTAOK.a0gyKY.WGwsSdUWwC31MAjnRoxZ3cNa',NULL,'2025-09-24 07:17:31','2025-09-24 07:17:31',NULL,'BlueTheme');
INSERT INTO "sessions" ("id","user_id","ip_address","user_agent","payload","last_activity") VALUES ('shR7RATP8v3q6IbvYmt42609ZkNEDHyHBXOMSRip',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUTE0VmdNdkpFd2d4Zk5YdU1keEdROVVsSzBOZnRZeENlRFUzc0tYZSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQ1OiJodHRwOi8vYXdkYWwtZWxlY3RyaWNpdHkudGVzdC9tdi1saW5lcy9jcmVhdGUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=',1758721734);
INSERT INTO "cache" ("key","value","expiration") VALUES ('crud-app-cache-spatie.permission.cache','a:3:{s:5:"alias";a:4:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";s:1:"r";s:5:"roles";}s:11:"permissions";a:162:{i:0;a:4:{s:1:"a";i:1;s:1:"b";s:12:"create-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:1;a:4:{s:1:"a";i:2;s:1:"b";s:10:"read-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:2;a:4:{s:1:"a";i:3;s:1:"b";s:12:"update-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:3;a:4:{s:1:"a";i:4;s:1:"b";s:10:"edit-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:4;a:4:{s:1:"a";i:5;s:1:"b";s:12:"delete-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:5;a:4:{s:1:"a";i:6;s:1:"b";s:10:"view-users";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:6;a:4:{s:1:"a";i:7;s:1:"b";s:18:"create-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:7;a:4:{s:1:"a";i:8;s:1:"b";s:16:"read-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:8;a:4:{s:1:"a";i:9;s:1:"b";s:18:"update-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:9;a:4:{s:1:"a";i:10;s:1:"b";s:16:"edit-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:10;a:4:{s:1:"a";i:11;s:1:"b";s:18:"delete-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:11;a:4:{s:1:"a";i:12;s:1:"b";s:16:"view-permissions";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:12;a:4:{s:1:"a";i:13;s:1:"b";s:12:"create-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:13;a:4:{s:1:"a";i:14;s:1:"b";s:10:"read-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:14;a:4:{s:1:"a";i:15;s:1:"b";s:12:"update-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:15;a:4:{s:1:"a";i:16;s:1:"b";s:10:"edit-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:16;a:4:{s:1:"a";i:17;s:1:"b";s:12:"delete-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:17;a:4:{s:1:"a";i:18;s:1:"b";s:10:"view-roles";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:18;a:4:{s:1:"a";i:19;s:1:"b";s:12:"create-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:19;a:4:{s:1:"a";i:20;s:1:"b";s:10:"read-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:20;a:4:{s:1:"a";i:21;s:1:"b";s:12:"update-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:21;a:4:{s:1:"a";i:22;s:1:"b";s:10:"edit-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:22;a:4:{s:1:"a";i:23;s:1:"b";s:12:"delete-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:23;a:4:{s:1:"a";i:24;s:1:"b";s:10:"view-zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:24;a:4:{s:1:"a";i:25;s:1:"b";s:16:"create-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:25;a:4:{s:1:"a";i:26;s:1:"b";s:14:"read-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:26;a:4:{s:1:"a";i:27;s:1:"b";s:16:"update-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:27;a:4:{s:1:"a";i:28;s:1:"b";s:14:"edit-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:28;a:4:{s:1:"a";i:29;s:1:"b";s:16:"delete-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:29;a:4:{s:1:"a";i:30;s:1:"b";s:14:"view-sub_zones";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:30;a:4:{s:1:"a";i:31;s:1:"b";s:12:"create-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:31;a:4:{s:1:"a";i:32;s:1:"b";s:10:"read-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:32;a:4:{s:1:"a";i:33;s:1:"b";s:12:"update-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:33;a:4:{s:1:"a";i:34;s:1:"b";s:10:"edit-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:34;a:4:{s:1:"a";i:35;s:1:"b";s:12:"delete-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:35;a:4:{s:1:"a";i:36;s:1:"b";s:10:"view-teams";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:36;a:4:{s:1:"a";i:37;s:1:"b";s:16:"create-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:37;a:4:{s:1:"a";i:38;s:1:"b";s:14:"read-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:38;a:4:{s:1:"a";i:39;s:1:"b";s:16:"update-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:39;a:4:{s:1:"a";i:40;s:1:"b";s:14:"edit-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:40;a:4:{s:1:"a";i:41;s:1:"b";s:16:"delete-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:41;a:4:{s:1:"a";i:42;s:1:"b";s:14:"view-customers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:42;a:4:{s:1:"a";i:43;s:1:"b";s:19:"create-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:43;a:4:{s:1:"a";i:44;s:1:"b";s:17:"read-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:44;a:4:{s:1:"a";i:45;s:1:"b";s:19:"update-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:45;a:4:{s:1:"a";i:46;s:1:"b";s:17:"edit-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:46;a:4:{s:1:"a";i:47;s:1:"b";s:19:"delete-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:47;a:4:{s:1:"a";i:48;s:1:"b";s:17:"view-team_members";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:48;a:4:{s:1:"a";i:49;s:1:"b";s:23:"create-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:49;a:4:{s:1:"a";i:50;s:1:"b";s:21:"read-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:50;a:4:{s:1:"a";i:51;s:1:"b";s:23:"update-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:51;a:4:{s:1:"a";i:52;s:1:"b";s:21:"edit-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:52;a:4:{s:1:"a";i:53;s:1:"b";s:23:"delete-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:53;a:4:{s:1:"a";i:54;s:1:"b";s:21:"view-asset_categories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:54;a:4:{s:1:"a";i:55;s:1:"b";s:13:"create-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:55;a:4:{s:1:"a";i:56;s:1:"b";s:11:"read-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:56;a:4:{s:1:"a";i:57;s:1:"b";s:13:"update-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:57;a:4:{s:1:"a";i:58;s:1:"b";s:11:"edit-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:58;a:4:{s:1:"a";i:59;s:1:"b";s:13:"delete-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:59;a:4:{s:1:"a";i:60;s:1:"b";s:11:"view-assets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:60;a:4:{s:1:"a";i:61;s:1:"b";s:15:"create-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:61;a:4:{s:1:"a";i:62;s:1:"b";s:13:"read-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:62;a:4:{s:1:"a";i:63;s:1:"b";s:15:"update-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:63;a:4:{s:1:"a";i:64;s:1:"b";s:13:"edit-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:64;a:4:{s:1:"a";i:65;s:1:"b";s:15:"delete-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:65;a:4:{s:1:"a";i:66;s:1:"b";s:13:"view-stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:66;a:4:{s:1:"a";i:67;s:1:"b";s:15:"create-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:67;a:4:{s:1:"a";i:68;s:1:"b";s:13:"read-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:68;a:4:{s:1:"a";i:69;s:1:"b";s:15:"update-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:69;a:4:{s:1:"a";i:70;s:1:"b";s:13:"edit-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:70;a:4:{s:1:"a";i:71;s:1:"b";s:15:"delete-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:71;a:4:{s:1:"a";i:72;s:1:"b";s:13:"view-mv_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:72;a:4:{s:1:"a";i:73;s:1:"b";s:19:"create-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:73;a:4:{s:1:"a";i:74;s:1:"b";s:17:"read-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:74;a:4:{s:1:"a";i:75;s:1:"b";s:19:"update-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:75;a:4:{s:1:"a";i:76;s:1:"b";s:17:"edit-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:76;a:4:{s:1:"a";i:77;s:1:"b";s:19:"delete-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:77;a:4:{s:1:"a";i:78;s:1:"b";s:17:"view-sub_stations";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:78;a:4:{s:1:"a";i:79;s:1:"b";s:15:"create-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:79;a:4:{s:1:"a";i:80;s:1:"b";s:13:"read-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:80;a:4:{s:1:"a";i:81;s:1:"b";s:15:"update-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:81;a:4:{s:1:"a";i:82;s:1:"b";s:13:"edit-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:82;a:4:{s:1:"a";i:83;s:1:"b";s:15:"delete-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:83;a:4:{s:1:"a";i:84;s:1:"b";s:13:"view-dt_lines";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:84;a:4:{s:1:"a";i:85;s:1:"b";s:19:"create-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:85;a:4:{s:1:"a";i:86;s:1:"b";s:17:"read-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:86;a:4:{s:1:"a";i:87;s:1:"b";s:19:"update-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:87;a:4:{s:1:"a";i:88;s:1:"b";s:17:"edit-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:88;a:4:{s:1:"a";i:89;s:1:"b";s:19:"delete-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:89;a:4:{s:1:"a";i:90;s:1:"b";s:17:"view-transformers";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:90;a:4:{s:1:"a";i:91;s:1:"b";s:24:"create-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:91;a:4:{s:1:"a";i:92;s:1:"b";s:22:"read-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:92;a:4:{s:1:"a";i:93;s:1:"b";s:24:"update-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:93;a:4:{s:1:"a";i:94;s:1:"b";s:22:"edit-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:94;a:4:{s:1:"a";i:95;s:1:"b";s:24:"delete-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:95;a:4:{s:1:"a";i:96;s:1:"b";s:22:"view-maintenance_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:96;a:4:{s:1:"a";i:97;s:1:"b";s:20:"create-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:97;a:4:{s:1:"a";i:98;s:1:"b";s:18:"read-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:98;a:4:{s:1:"a";i:99;s:1:"b";s:20:"update-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:99;a:4:{s:1:"a";i:100;s:1:"b";s:18:"edit-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:100;a:4:{s:1:"a";i:101;s:1:"b";s:20:"delete-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:101;a:4:{s:1:"a";i:102;s:1:"b";s:18:"view-service_drops";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:102;a:4:{s:1:"a";i:103;s:1:"b";s:24:"create-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:103;a:4:{s:1:"a";i:104;s:1:"b";s:22:"read-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:104;a:4:{s:1:"a";i:105;s:1:"b";s:24:"update-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:105;a:4:{s:1:"a";i:106;s:1:"b";s:22:"edit-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:106;a:4:{s:1:"a";i:107;s:1:"b";s:24:"delete-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:107;a:4:{s:1:"a";i:108;s:1:"b";s:22:"view-maintenance_tasks";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:108;a:4:{s:1:"a";i:109;s:1:"b";s:18:"create-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:109;a:4:{s:1:"a";i:110;s:1:"b";s:16:"read-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:110;a:4:{s:1:"a";i:111;s:1:"b";s:18:"update-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:111;a:4:{s:1:"a";i:112;s:1:"b";s:16:"edit-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:112;a:4:{s:1:"a";i:113;s:1:"b";s:18:"delete-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:113;a:4:{s:1:"a";i:114;s:1:"b";s:16:"view-spare_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:114;a:4:{s:1:"a";i:115;s:1:"b";s:17:"create-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:115;a:4:{s:1:"a";i:116;s:1:"b";s:15:"read-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:116;a:4:{s:1:"a";i:117;s:1:"b";s:17:"update-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:117;a:4:{s:1:"a";i:118;s:1:"b";s:15:"edit-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:118;a:4:{s:1:"a";i:119;s:1:"b";s:17:"delete-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:119;a:4:{s:1:"a";i:120;s:1:"b";s:15:"view-task_parts";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:120;a:4:{s:1:"a";i:121;s:1:"b";s:24:"create-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:121;a:4:{s:1:"a";i:122;s:1:"b";s:22:"read-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:122;a:4:{s:1:"a";i:123;s:1:"b";s:24:"update-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:123;a:4:{s:1:"a";i:124;s:1:"b";s:22:"edit-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:124;a:4:{s:1:"a";i:125;s:1:"b";s:24:"delete-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:125;a:4:{s:1:"a";i:126;s:1:"b";s:22:"view-ticket_priorities";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:126;a:4:{s:1:"a";i:127;s:1:"b";s:26:"create-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:127;a:4:{s:1:"a";i:128;s:1:"b";s:24:"read-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:128;a:4:{s:1:"a";i:129;s:1:"b";s:26:"update-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:129;a:4:{s:1:"a";i:130;s:1:"b";s:24:"edit-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:130;a:4:{s:1:"a";i:131;s:1:"b";s:26:"delete-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:131;a:4:{s:1:"a";i:132;s:1:"b";s:24:"view-ticket_status_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:132;a:4:{s:1:"a";i:133;s:1:"b";s:23:"create-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:133;a:4:{s:1:"a";i:134;s:1:"b";s:21:"read-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:134;a:4:{s:1:"a";i:135;s:1:"b";s:23:"update-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:135;a:4:{s:1:"a";i:136;s:1:"b";s:21:"edit-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:136;a:4:{s:1:"a";i:137;s:1:"b";s:23:"delete-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:137;a:4:{s:1:"a";i:138;s:1:"b";s:21:"view-ticket_histories";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:138;a:4:{s:1:"a";i:139;s:1:"b";s:14:"create-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:139;a:4:{s:1:"a";i:140;s:1:"b";s:12:"read-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:140;a:4:{s:1:"a";i:141;s:1:"b";s:14:"update-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:141;a:4:{s:1:"a";i:142;s:1:"b";s:12:"edit-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:142;a:4:{s:1:"a";i:143;s:1:"b";s:14:"delete-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:143;a:4:{s:1:"a";i:144;s:1:"b";s:12:"view-tickets";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:144;a:4:{s:1:"a";i:145;s:1:"b";s:18:"create-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:145;a:4:{s:1:"a";i:146;s:1:"b";s:16:"read-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:146;a:4:{s:1:"a";i:147;s:1:"b";s:18:"update-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:147;a:4:{s:1:"a";i:148;s:1:"b";s:16:"edit-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:148;a:4:{s:1:"a";i:149;s:1:"b";s:18:"delete-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:149;a:4:{s:1:"a";i:150;s:1:"b";s:16:"view-event_types";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:150;a:4:{s:1:"a";i:151;s:1:"b";s:22:"create-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:151;a:4:{s:1:"a";i:152;s:1:"b";s:20:"read-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:152;a:4:{s:1:"a";i:153;s:1:"b";s:22:"update-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:153;a:4:{s:1:"a";i:154;s:1:"b";s:20:"edit-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:154;a:4:{s:1:"a";i:155;s:1:"b";s:22:"delete-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:155;a:4:{s:1:"a";i:156;s:1:"b";s:20:"view-tracking_events";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:156;a:4:{s:1:"a";i:157;s:1:"b";s:19:"create-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:157;a:4:{s:1:"a";i:158;s:1:"b";s:17:"read-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:158;a:4:{s:1:"a";i:159;s:1:"b";s:19:"update-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:159;a:4:{s:1:"a";i:160;s:1:"b";s:17:"edit-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:160;a:4:{s:1:"a";i:161;s:1:"b";s:19:"delete-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}i:161;a:4:{s:1:"a";i:162;s:1:"b";s:17:"view-sms_outboxes";s:1:"c";s:3:"web";s:1:"r";a:1:{i:0;i:1;}}}s:5:"roles";a:1:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:5:"admin";s:1:"c";s:3:"web";}}}',1758784708);
INSERT INTO "permissions" ("id","name","guard_name","created_at","updated_at") VALUES (1,'create-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (2,'read-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (3,'update-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (4,'edit-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (5,'delete-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (6,'view-users','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (7,'create-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (8,'read-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (9,'update-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (10,'edit-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (11,'delete-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (12,'view-permissions','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (13,'create-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (14,'read-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (15,'update-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (16,'edit-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (17,'delete-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (18,'view-roles','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (19,'create-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (20,'read-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (21,'update-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (22,'edit-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (23,'delete-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (24,'view-zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (25,'create-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (26,'read-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (27,'update-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (28,'edit-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (29,'delete-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (30,'view-sub_zones','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (31,'create-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (32,'read-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (33,'update-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (34,'edit-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (35,'delete-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (36,'view-teams','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (37,'create-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (38,'read-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (39,'update-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (40,'edit-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (41,'delete-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (42,'view-customers','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (43,'create-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (44,'read-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (45,'update-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (46,'edit-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (47,'delete-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (48,'view-team_members','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (49,'create-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (50,'read-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (51,'update-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (52,'edit-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (53,'delete-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (54,'view-asset_categories','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (55,'create-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (56,'read-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (57,'update-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (58,'edit-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (59,'delete-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (60,'view-assets','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (61,'create-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (62,'read-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (63,'update-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (64,'edit-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (65,'delete-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (66,'view-stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (67,'create-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (68,'read-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (69,'update-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (70,'edit-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (71,'delete-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (72,'view-mv_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (73,'create-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (74,'read-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (75,'update-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (76,'edit-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (77,'delete-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (78,'view-sub_stations','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (79,'create-dt_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (80,'read-dt_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (81,'update-dt_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (82,'edit-dt_lines','web','2025-09-24 07:17:29','2025-09-24 07:17:29'),
 (83,'delete-dt_lines','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (84,'view-dt_lines','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (85,'create-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (86,'read-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (87,'update-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (88,'edit-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (89,'delete-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (90,'view-transformers','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (91,'create-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (92,'read-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (93,'update-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (94,'edit-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (95,'delete-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (96,'view-maintenance_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (97,'create-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (98,'read-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (99,'update-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (100,'edit-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (101,'delete-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (102,'view-service_drops','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (103,'create-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (104,'read-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (105,'update-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (106,'edit-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (107,'delete-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (108,'view-maintenance_tasks','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (109,'create-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (110,'read-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (111,'update-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (112,'edit-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (113,'delete-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (114,'view-spare_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (115,'create-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (116,'read-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (117,'update-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (118,'edit-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (119,'delete-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (120,'view-task_parts','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (121,'create-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (122,'read-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (123,'update-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (124,'edit-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (125,'delete-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (126,'view-ticket_priorities','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (127,'create-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (128,'read-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (129,'update-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (130,'edit-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (131,'delete-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (132,'view-ticket_status_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (133,'create-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (134,'read-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (135,'update-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (136,'edit-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (137,'delete-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (138,'view-ticket_histories','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (139,'create-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (140,'read-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (141,'update-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (142,'edit-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (143,'delete-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (144,'view-tickets','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (145,'create-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (146,'read-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (147,'update-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (148,'edit-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (149,'delete-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (150,'view-event_types','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (151,'create-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (152,'read-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (153,'update-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (154,'edit-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (155,'delete-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (156,'view-tracking_events','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (157,'create-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (158,'read-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (159,'update-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (160,'edit-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (161,'delete-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30'),
 (162,'view-sms_outboxes','web','2025-09-24 07:17:30','2025-09-24 07:17:30');
INSERT INTO "roles" ("id","name","guard_name","created_at","updated_at") VALUES (1,'admin','web','2025-09-24 07:17:29','2025-09-24 07:17:29');
INSERT INTO "model_has_roles" ("role_id","model_type","model_id") VALUES (1,'App\Models\User',1);
INSERT INTO "role_has_permissions" ("permission_id","role_id") VALUES (1,1),
 (2,1),
 (3,1),
 (4,1),
 (5,1),
 (6,1),
 (7,1),
 (8,1),
 (9,1),
 (10,1),
 (11,1),
 (12,1),
 (13,1),
 (14,1),
 (15,1),
 (16,1),
 (17,1),
 (18,1),
 (19,1),
 (20,1),
 (21,1),
 (22,1),
 (23,1),
 (24,1),
 (25,1),
 (26,1),
 (27,1),
 (28,1),
 (29,1),
 (30,1),
 (31,1),
 (32,1),
 (33,1),
 (34,1),
 (35,1),
 (36,1),
 (37,1),
 (38,1),
 (39,1),
 (40,1),
 (41,1),
 (42,1),
 (43,1),
 (44,1),
 (45,1),
 (46,1),
 (47,1),
 (48,1),
 (49,1),
 (50,1),
 (51,1),
 (52,1),
 (53,1),
 (54,1),
 (55,1),
 (56,1),
 (57,1),
 (58,1),
 (59,1),
 (60,1),
 (61,1),
 (62,1),
 (63,1),
 (64,1),
 (65,1),
 (66,1),
 (67,1),
 (68,1),
 (69,1),
 (70,1),
 (71,1),
 (72,1),
 (73,1),
 (74,1),
 (75,1),
 (76,1),
 (77,1),
 (78,1),
 (79,1),
 (80,1),
 (81,1),
 (82,1),
 (83,1),
 (84,1),
 (85,1),
 (86,1),
 (87,1),
 (88,1),
 (89,1),
 (90,1),
 (91,1),
 (92,1),
 (93,1),
 (94,1),
 (95,1),
 (96,1),
 (97,1),
 (98,1),
 (99,1),
 (100,1),
 (101,1),
 (102,1),
 (103,1),
 (104,1),
 (105,1),
 (106,1),
 (107,1),
 (108,1),
 (109,1),
 (110,1),
 (111,1),
 (112,1),
 (113,1),
 (114,1),
 (115,1),
 (116,1),
 (117,1),
 (118,1),
 (119,1),
 (120,1),
 (121,1),
 (122,1),
 (123,1),
 (124,1),
 (125,1),
 (126,1),
 (127,1),
 (128,1),
 (129,1),
 (130,1),
 (131,1),
 (132,1),
 (133,1),
 (134,1),
 (135,1),
 (136,1),
 (137,1),
 (138,1),
 (139,1),
 (140,1),
 (141,1),
 (142,1),
 (143,1),
 (144,1),
 (145,1),
 (146,1),
 (147,1),
 (148,1),
 (149,1),
 (150,1),
 (151,1),
 (152,1),
 (153,1),
 (154,1),
 (155,1),
 (156,1),
 (157,1),
 (158,1),
 (159,1),
 (160,1),
 (161,1),
 (162,1);
INSERT INTO "zones" ("zone_id","zone_name","created_at","updated_at","created_by","updated_by") VALUES (1,'A','2025-09-24 07:29:28','2025-09-24 07:29:28',1,NULL),
 (2,'B','2025-09-24 07:29:40','2025-09-24 07:29:40',1,NULL);
INSERT INTO "sub_zones" ("sub_zone_id","zone_id","sub_zone_name","created_at","updated_at","created_by","updated_by") VALUES (1,1,'1','2025-09-24 07:29:49','2025-09-24 07:29:49',1,NULL);
INSERT INTO "stations" ("station_id","station_name","lat","lng","created_at","updated_at","created_by","updated_by") VALUES (1,'aloog East Station',9.953228,43.212922,'2025-09-24 07:18:45','2025-09-24 07:18:45',1,NULL),
 (2,'Telesom West Station',9.936882,43.147731,'2025-09-24 10:45:44','2025-09-24 10:45:44',1,NULL);
INSERT INTO "mv_lines" ("mv_line_id","station_id","from_sub_station_id","code","mv_from_id","commissioning_date","lat","lng","created_at","updated_at","created_by","updated_by") VALUES (1,1,NULL,'mv-001',NULL,'2025-09-24',9.953547,43.212303,'2025-09-24 07:22:59','2025-09-24 07:22:59',1,NULL),
 (2,1,NULL,'mv-002',1,'2025-09-24',9.952852,43.211044,'2025-09-24 07:28:28','2025-09-24 07:28:28',1,NULL),
 (3,1,NULL,'mv-003',2,NULL,9.952328,43.209648,'2025-09-24 09:58:11','2025-09-24 10:40:49',1,1),
 (5,1,1,'mv-004',NULL,'2025-09-24',9.946076,43.202021,'2025-09-24 11:35:42','2025-09-24 11:35:42',1,NULL),
 (6,1,NULL,'mv-005',3,'2025-09-24',9.949965,43.204338,'2025-09-24 13:41:10','2025-09-24 13:41:10',1,NULL);
INSERT INTO "sub_stations" ("sub_station_id","station_id","sub_station_code","sub_station_name","mv_from_id","breaking_capacity_kA","lat","lng","created_at","updated_at","created_by","updated_by") VALUES (1,2,'Sub-S-001','fardaha',6,443453,9.947568,43.205078,'2025-09-24 11:21:48','2025-09-24 13:41:43',1,1);
CREATE UNIQUE INDEX IF NOT EXISTS "users_email_unique" ON "users" (
	"email"
);
CREATE INDEX IF NOT EXISTS "sessions_user_id_index" ON "sessions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "sessions_last_activity_index" ON "sessions" (
	"last_activity"
);
CREATE INDEX IF NOT EXISTS "jobs_queue_index" ON "jobs" (
	"queue"
);
CREATE UNIQUE INDEX IF NOT EXISTS "failed_jobs_uuid_unique" ON "failed_jobs" (
	"uuid"
);
CREATE UNIQUE INDEX IF NOT EXISTS "permissions_name_guard_name_unique" ON "permissions" (
	"name",
	"guard_name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "roles_name_guard_name_unique" ON "roles" (
	"name",
	"guard_name"
);
CREATE INDEX IF NOT EXISTS "model_has_permissions_model_id_model_type_index" ON "model_has_permissions" (
	"model_id",
	"model_type"
);
CREATE INDEX IF NOT EXISTS "model_has_roles_model_id_model_type_index" ON "model_has_roles" (
	"model_id",
	"model_type"
);
CREATE UNIQUE INDEX IF NOT EXISTS "zones_zone_name_unique" ON "zones" (
	"zone_name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "sub_zones_zone_id_sub_zone_name_unique" ON "sub_zones" (
	"zone_id",
	"sub_zone_name"
);
CREATE INDEX IF NOT EXISTS "teams_supervisor_id_index" ON "teams" (
	"supervisor_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "customers_supply_no_unique" ON "customers" (
	"supply_no"
);
CREATE UNIQUE INDEX IF NOT EXISTS "customers_meter_no_unique" ON "customers" (
	"meter_no"
);
CREATE UNIQUE INDEX IF NOT EXISTS "team_members_team_id_user_id_unique" ON "team_members" (
	"team_id",
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "asset_categories_cat_name_unique" ON "asset_categories" (
	"cat_name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "assets_asset_tag_unique" ON "assets" (
	"asset_tag"
);
CREATE UNIQUE INDEX IF NOT EXISTS "stations_station_name_unique" ON "stations" (
	"station_name"
);
CREATE INDEX IF NOT EXISTS "mv_lines_asset_id_station_id_from_sub_station_id_mv_from_id_index" ON "mv_lines" (
	"asset_id",
	"station_id",
	"from_sub_station_id",
	"mv_from_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "mv_lines_code_unique" ON "mv_lines" (
	"code"
);
CREATE INDEX IF NOT EXISTS "sub_stations_mv_from_id_index" ON "sub_stations" (
	"mv_from_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "sub_stations_sub_station_code_unique" ON "sub_stations" (
	"sub_station_code"
);
CREATE UNIQUE INDEX IF NOT EXISTS "dt_lines_code_unique" ON "dt_lines" (
	"code"
);
CREATE UNIQUE INDEX IF NOT EXISTS "transformers_code_unique" ON "transformers" (
	"code"
);
CREATE UNIQUE INDEX IF NOT EXISTS "maintenance_types_type_name_unique" ON "maintenance_types" (
	"type_name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "spare_parts_part_code_unique" ON "spare_parts" (
	"part_code"
);
CREATE UNIQUE INDEX IF NOT EXISTS "ticket_priorities_priority_name_unique" ON "ticket_priorities" (
	"priority_name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "ticket_status_types_status_name_unique" ON "ticket_status_types" (
	"status_name"
);
CREATE INDEX IF NOT EXISTS "tickets_customer_id_team_id_priority_id_status_id_agent_id_supervisor_id_index" ON "tickets" (
	"customer_id",
	"team_id",
	"priority_id",
	"status_id",
	"agent_id",
	"supervisor_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "event_types_event_type_name_unique" ON "event_types" (
	"event_type_name"
);
CREATE INDEX IF NOT EXISTS "tracking_events_ticket_id_user_id_event_type_id_index" ON "tracking_events" (
	"ticket_id",
	"user_id",
	"event_type_id"
);
COMMIT;
