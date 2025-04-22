BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "frontend_exercisetype" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_musclegroup" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_video_muscles" (
	"id"	integer NOT NULL,
	"video_id"	bigint NOT NULL,
	"musclegroup_id"	bigint NOT NULL,
	FOREIGN KEY("video_id") REFERENCES "frontend_video"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("musclegroup_id") REFERENCES "frontend_musclegroup"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_video_type" (
	"id"	integer NOT NULL,
	"video_id"	bigint NOT NULL,
	"exercisetype_id"	bigint NOT NULL,
	FOREIGN KEY("exercisetype_id") REFERENCES "frontend_exercisetype"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("video_id") REFERENCES "frontend_video"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_video_dangerous" (
	"id"	integer NOT NULL,
	"video_id"	bigint NOT NULL,
	"musclegroup_id"	bigint NOT NULL,
	FOREIGN KEY("video_id") REFERENCES "frontend_video"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("musclegroup_id") REFERENCES "frontend_musclegroup"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_equipment" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_video_equipment" (
	"id"	integer NOT NULL,
	"video_id"	bigint NOT NULL,
	"equipment_id"	bigint NOT NULL,
	FOREIGN KEY("video_id") REFERENCES "frontend_video"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("equipment_id") REFERENCES "frontend_equipment"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "frontend_video" (
	"id"	integer NOT NULL,
	"url"	varchar(100),
	"name"	varchar(100) NOT NULL,
	"description"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-01-20 21:13:05.283747');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-01-20 21:13:05.349948');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-01-20 21:13:05.377802');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-01-20 21:13:05.395748');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-01-20 21:13:05.434271');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2024-01-20 21:13:05.709827');
INSERT INTO "django_migrations" VALUES (19,'frontend','0001_initial','2024-02-15 16:04:52.355255');
INSERT INTO "django_migrations" VALUES (20,'frontend','0002_rename_title_video_name_remove_video_description_and_more','2024-02-15 19:53:39.140363');
INSERT INTO "django_migrations" VALUES (21,'frontend','0003_alter_video_url','2024-03-27 20:39:18.990317');
INSERT INTO "django_migrations" VALUES (22,'frontend','0004_equipment','2024-03-27 21:45:57.128948');
INSERT INTO "django_migrations" VALUES (23,'frontend','0005_remove_video_equipment_video_equipment','2024-03-27 21:48:43.367830');
INSERT INTO "django_migrations" VALUES (24,'frontend','0006_alter_video_equipment','2024-03-27 22:06:07.511418');
INSERT INTO "django_migrations" VALUES (25,'frontend','0007_alter_video_equipment','2024-03-27 22:07:47.108371');
INSERT INTO "django_migrations" VALUES (26,'frontend','0008_alter_video_dangerous','2024-03-27 22:19:24.167739');
INSERT INTO "django_migrations" VALUES (27,'frontend','0009_video_description','2024-03-27 22:24:05.171503');
INSERT INTO "django_migrations" VALUES (28,'frontend','0010_alter_video_description','2024-03-27 22:26:00.332523');
INSERT INTO "django_migrations" VALUES (29,'frontend','0011_alter_video_description','2024-03-27 23:25:46.603827');
INSERT INTO "django_migrations" VALUES (30,'auth','0001_initial','2024-04-16 00:41:00.537515');
INSERT INTO "django_migrations" VALUES (31,'auth','0002_alter_permission_name_max_length','2024-04-16 00:41:00.558623');
INSERT INTO "django_migrations" VALUES (32,'auth','0003_alter_user_email_max_length','2024-04-16 00:41:00.578878');
INSERT INTO "django_migrations" VALUES (33,'auth','0004_alter_user_username_opts','2024-04-16 00:41:00.595981');
INSERT INTO "django_migrations" VALUES (34,'auth','0005_alter_user_last_login_null','2024-04-16 00:41:00.609242');
INSERT INTO "django_migrations" VALUES (35,'auth','0006_require_contenttypes_0002','2024-04-16 00:41:00.622177');
INSERT INTO "django_migrations" VALUES (36,'auth','0007_alter_validators_add_error_messages','2024-04-16 00:41:00.636698');
INSERT INTO "django_migrations" VALUES (37,'auth','0008_alter_user_username_max_length','2024-04-16 00:41:00.652664');
INSERT INTO "django_migrations" VALUES (38,'auth','0009_alter_user_last_name_max_length','2024-04-16 00:41:00.667785');
INSERT INTO "django_migrations" VALUES (39,'auth','0010_alter_group_name_max_length','2024-04-16 00:41:00.691441');
INSERT INTO "django_migrations" VALUES (40,'auth','0011_update_proxy_permissions','2024-04-16 00:41:00.707631');
INSERT INTO "django_migrations" VALUES (41,'auth','0012_alter_user_first_name_max_length','2024-04-16 00:41:00.723617');
INSERT INTO "django_admin_log" VALUES (1,'1','muscleGroup object (1)',1,'[{"added": {}}]',9,1,'2024-03-27 20:43:13.000846');
INSERT INTO "django_admin_log" VALUES (2,'2','muscleGroup object (2)',1,'[{"added": {}}]',9,1,'2024-03-27 20:43:26.083715');
INSERT INTO "django_admin_log" VALUES (3,'3','muscleGroup object (3)',1,'[{"added": {}}]',9,1,'2024-03-27 20:43:48.023182');
INSERT INTO "django_admin_log" VALUES (4,'3','muscleGroup object (3)',3,'',9,1,'2024-03-27 20:44:08.474656');
INSERT INTO "django_admin_log" VALUES (5,'1','Barbell',1,'[{"added": {}}]',10,1,'2024-03-27 21:49:44.714055');
INSERT INTO "django_admin_log" VALUES (6,'2','Bench',1,'[{"added": {}}]',10,1,'2024-03-27 21:50:04.969202');
INSERT INTO "django_admin_log" VALUES (7,'1','Muscle Builder',1,'[{"added": {}}]',7,1,'2024-03-27 21:50:18.394041');
INSERT INTO "django_admin_log" VALUES (8,'1','Barbell Bench Press',1,'[{"added": {}}]',8,1,'2024-03-27 21:52:37.300717');
INSERT INTO "django_admin_log" VALUES (9,'2','Incline Barbell Bench Press',1,'[{"added": {}}]',8,1,'2024-03-27 21:53:00.437031');
INSERT INTO "django_admin_log" VALUES (10,'4','Lower Back',1,'[{"added": {}}]',9,1,'2024-03-27 21:54:00.246228');
INSERT INTO "django_admin_log" VALUES (11,'3','Barbell Overhead Press',1,'[{"added": {}}]',8,1,'2024-03-27 21:54:07.668098');
INSERT INTO "django_admin_log" VALUES (12,'2','Calisthenics',1,'[{"added": {}}]',7,1,'2024-03-27 22:04:39.102043');
INSERT INTO "django_admin_log" VALUES (13,'5','Triceps',1,'[{"added": {}}]',9,1,'2024-03-27 22:04:57.698867');
INSERT INTO "django_admin_log" VALUES (14,'6','Triceps',1,'[{"added": {}}]',9,1,'2024-03-27 22:05:16.782872');
INSERT INTO "django_admin_log" VALUES (15,'6','Triceps',3,'',9,1,'2024-03-27 22:05:56.410425');
INSERT INTO "django_admin_log" VALUES (16,'4','Body-Weight Dips',1,'[{"added": {}}]',8,1,'2024-03-27 22:07:56.147991');
INSERT INTO "django_admin_log" VALUES (17,'5','Body-Weight Dips',1,'[{"added": {}}]',8,1,'2024-03-27 22:08:10.758665');
INSERT INTO "django_admin_log" VALUES (18,'6','Body-Weight Elevated Pike Press',1,'[{"added": {}}]',8,1,'2024-03-27 22:09:17.174774');
INSERT INTO "django_admin_log" VALUES (19,'7','Body-Weight Push Up',1,'[{"added": {}}]',8,1,'2024-03-27 22:10:18.509675');
INSERT INTO "django_admin_log" VALUES (20,'3','Cable Machine',1,'[{"added": {}}]',10,1,'2024-03-27 22:11:10.598366');
INSERT INTO "django_admin_log" VALUES (21,'8','Cable Chest Press',1,'[{"added": {}}]',8,1,'2024-03-27 22:11:17.802603');
INSERT INTO "django_admin_log" VALUES (22,'9','Cable Pec-Fly',1,'[{"added": {}}]',8,1,'2024-03-27 22:12:08.594511');
INSERT INTO "django_admin_log" VALUES (23,'7','Biceps',1,'[{"added": {}}]',9,1,'2024-03-27 22:12:35.323517');
INSERT INTO "django_admin_log" VALUES (24,'7','Body-Weight Push Up',2,'[{"changed": {"fields": ["Muscles"]}}]',8,1,'2024-03-27 22:12:42.060190');
INSERT INTO "django_admin_log" VALUES (25,'7','Body-Weight Push Up',2,'[]',8,1,'2024-03-27 22:12:56.211352');
INSERT INTO "django_admin_log" VALUES (26,'10','Cable Lateral Raises',1,'[{"added": {}}]',8,1,'2024-03-27 22:18:03.597287');
INSERT INTO "django_admin_log" VALUES (27,'3','Stretch',1,'[{"added": {}}]',7,1,'2024-03-27 22:21:50.105121');
INSERT INTO "django_admin_log" VALUES (28,'11','Chest Stretch One',1,'[{"added": {}}]',8,1,'2024-03-27 22:21:59.014720');
INSERT INTO "django_admin_log" VALUES (29,'1','Barbell Bench Press',2,'[]',8,1,'2024-03-27 22:26:10.070061');
INSERT INTO "django_admin_log" VALUES (30,'1','Barbell Bench Press',2,'[]',8,1,'2024-03-27 22:26:14.775279');
INSERT INTO "django_admin_log" VALUES (31,'12','Chest Stretch Two',1,'[{"added": {}}]',8,1,'2024-03-27 22:26:43.919920');
INSERT INTO "django_admin_log" VALUES (32,'13','Chest Stretch Three',1,'[{"added": {}}]',8,1,'2024-03-27 22:27:14.458337');
INSERT INTO "django_admin_log" VALUES (33,'1','Barbell Bench Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:27:38.956743');
INSERT INTO "django_admin_log" VALUES (34,'2','Incline Barbell Bench Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:28:31.784453');
INSERT INTO "django_admin_log" VALUES (35,'1','Barbell Bench Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:28:43.192795');
INSERT INTO "django_admin_log" VALUES (36,'3','Barbell Overhead Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:29:16.283160');
INSERT INTO "django_admin_log" VALUES (37,'4','Body-Weight Dips',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:30:04.653163');
INSERT INTO "django_admin_log" VALUES (38,'4','Body-Weight Dips',2,'[]',8,1,'2024-03-27 23:30:26.851847');
INSERT INTO "django_admin_log" VALUES (39,'5','Body-Weight Dips',3,'',8,1,'2024-03-27 23:30:32.043448');
INSERT INTO "django_admin_log" VALUES (40,'6','Body-Weight Elevated Pike Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:31:00.889861');
INSERT INTO "django_admin_log" VALUES (41,'7','Body-Weight Push Up',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:32:39.506535');
INSERT INTO "django_admin_log" VALUES (42,'6','Body-Weight Elevated Pike Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:32:47.266082');
INSERT INTO "django_admin_log" VALUES (43,'4','Body-Weight Dips',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:32:56.804146');
INSERT INTO "django_admin_log" VALUES (44,'3','Barbell Overhead Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:33:14.989094');
INSERT INTO "django_admin_log" VALUES (45,'8','Cable Chest Press',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:34:18.021401');
INSERT INTO "django_admin_log" VALUES (46,'9','Cable Pec-Fly',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:34:56.641546');
INSERT INTO "django_admin_log" VALUES (47,'10','Cable Lateral Raises',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:36:24.985466');
INSERT INTO "django_admin_log" VALUES (48,'12','Chest Stretch Two',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:46:23.183671');
INSERT INTO "django_admin_log" VALUES (49,'13','Chest Stretch Three',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:52:42.912604');
INSERT INTO "django_admin_log" VALUES (50,'13','Chest Stretch Three',2,'[{"changed": {"fields": ["Description"]}}]',8,1,'2024-03-27 23:53:38.327586');
INSERT INTO "django_admin_log" VALUES (51,'8','Outer Abs',1,'[{"added": {}}]',9,1,'2024-03-28 00:01:33.929628');
INSERT INTO "django_admin_log" VALUES (52,'14','Body-Weight Hand Side Plank',1,'[{"added": {}}]',8,1,'2024-03-28 00:12:19.736095');
INSERT INTO "django_admin_log" VALUES (53,'4','Dumbell',1,'[{"added": {}}]',10,1,'2024-03-28 00:13:26.687956');
INSERT INTO "django_admin_log" VALUES (54,'15','Dumbbell Russian-Twist',1,'[{"added": {}}]',8,1,'2024-03-28 00:14:42.029444');
INSERT INTO "django_admin_log" VALUES (55,'9','Elbow',1,'[{"added": {}}]',9,1,'2024-03-28 00:15:54.103209');
INSERT INTO "django_admin_log" VALUES (56,'5','Kettlebell',1,'[{"added": {}}]',10,1,'2024-03-28 00:16:54.911281');
INSERT INTO "django_admin_log" VALUES (57,'16','Kettlebell Windmill',1,'[{"added": {}}]',8,1,'2024-03-28 00:17:28.508794');
INSERT INTO "django_admin_log" VALUES (58,'15','Dumbbell Russian-Twist',2,'[{"changed": {"fields": ["Type"]}}]',8,1,'2024-03-28 00:17:34.203080');
INSERT INTO "django_admin_log" VALUES (59,'16','Kettlebell Windmill',2,'[]',8,1,'2024-03-28 00:22:42.288149');
INSERT INTO "django_admin_log" VALUES (60,'17','Cable Woodchopper',1,'[{"added": {}}]',8,1,'2024-03-28 00:23:46.697415');
INSERT INTO "django_admin_log" VALUES (61,'15','Dumbbell Russian-Twist',2,'[{"changed": {"fields": ["Type"]}}]',8,1,'2024-03-28 00:23:53.000164');
INSERT INTO "django_admin_log" VALUES (62,'18','Outer Abdominals Stretch One',1,'[{"added": {}}]',8,1,'2024-03-28 00:25:29.559832');
INSERT INTO "django_admin_log" VALUES (63,'19','Outer Abdominals Stretch Two',1,'[{"added": {}}]',8,1,'2024-03-28 00:26:18.615073');
INSERT INTO "django_admin_log" VALUES (64,'20','Shoulder Stretch One',1,'[{"added": {}}]',8,1,'2024-03-28 00:28:14.466876');
INSERT INTO "django_admin_log" VALUES (65,'21','Shoulder Stretch Two',1,'[{"added": {}}]',8,1,'2024-03-28 00:29:19.419800');
INSERT INTO "django_admin_log" VALUES (66,'5','Tricep',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-03-28 00:29:29.367713');
INSERT INTO "django_admin_log" VALUES (67,'8','Outer Ab',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-03-28 00:29:33.643082');
INSERT INTO "django_admin_log" VALUES (68,'2','Shoulder',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-03-28 00:29:38.168613');
INSERT INTO "django_admin_log" VALUES (69,'7','Bicep',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-03-28 00:29:43.211055');
INSERT INTO "django_admin_log" VALUES (70,'22','Dumbell Curl',1,'[{"added": {}}]',8,1,'2024-04-02 14:29:33.465836');
INSERT INTO "django_admin_log" VALUES (71,'23','Hammer Curl',1,'[{"added": {}}]',8,1,'2024-04-02 14:32:03.461329');
INSERT INTO "django_admin_log" VALUES (72,'24','Reverse Curl',1,'[{"added": {}}]',8,1,'2024-04-02 14:34:22.026842');
INSERT INTO "django_admin_log" VALUES (73,'25','Bicep Stretch One',1,'[{"added": {}}]',8,1,'2024-04-02 14:36:17.654838');
INSERT INTO "django_admin_log" VALUES (74,'26','Bicep Stretch Two',1,'[{"added": {}}]',8,1,'2024-04-02 14:37:26.174105');
INSERT INTO "django_admin_log" VALUES (75,'26','Bicep and Forearm Stretch Two',2,'[{"changed": {"fields": ["Name", "Muscles"]}}]',8,1,'2024-04-02 14:39:17.271146');
INSERT INTO "django_admin_log" VALUES (76,'25','Bicep and Forearm Stretch One',2,'[{"changed": {"fields": ["Name", "Muscles"]}}]',8,1,'2024-04-02 14:39:37.730853');
INSERT INTO "django_admin_log" VALUES (77,'24','Barbell Reverse Curl',2,'[{"changed": {"fields": ["Name"]}}]',8,1,'2024-04-02 14:42:16.418253');
INSERT INTO "django_admin_log" VALUES (78,'24','Reverse Curl',2,'[{"changed": {"fields": ["Name"]}}]',8,1,'2024-04-02 14:45:05.845340');
INSERT INTO "django_admin_log" VALUES (79,'10','Upper Back',1,'[{"added": {}}]',9,1,'2024-04-02 14:46:24.653730');
INSERT INTO "django_admin_log" VALUES (80,'11','Forearm',1,'[{"added": {}}]',9,1,'2024-04-02 14:46:53.467589');
INSERT INTO "django_admin_log" VALUES (81,'6','Bar',1,'[{"added": {}}]',10,1,'2024-04-02 14:47:08.607031');
INSERT INTO "django_admin_log" VALUES (82,'27','Chinup',1,'[{"added": {}}]',8,1,'2024-04-02 14:47:24.077270');
INSERT INTO "django_admin_log" VALUES (83,'27','Chinup',2,'[{"changed": {"fields": ["Description", "Dangerous"]}}]',8,1,'2024-04-02 14:48:21.566077');
INSERT INTO "django_admin_log" VALUES (84,'26','Bicep and Forearm Stretch Two',2,'[{"changed": {"fields": ["Muscles"]}}]',8,1,'2024-04-02 14:55:49.293293');
INSERT INTO "django_admin_log" VALUES (85,'25','Bicep and Forearm Stretch One',2,'[{"changed": {"fields": ["Muscles"]}}]',8,1,'2024-04-02 14:55:55.841923');
INSERT INTO "django_admin_log" VALUES (86,'24','Reverse Curl',2,'[{"changed": {"fields": ["Muscles"]}}]',8,1,'2024-04-02 14:56:05.360191');
INSERT INTO "django_admin_log" VALUES (87,'7','Push Up',2,'[{"changed": {"fields": ["Name", "Muscles"]}}]',8,1,'2024-04-02 14:56:48.787920');
INSERT INTO "django_admin_log" VALUES (88,'6','Elevated Pike Press',2,'[{"changed": {"fields": ["Name"]}}]',8,1,'2024-04-02 14:57:04.781431');
INSERT INTO "django_admin_log" VALUES (89,'14','Hand Side Plank',2,'[{"changed": {"fields": ["Name"]}}]',8,1,'2024-04-02 14:57:14.086530');
INSERT INTO "django_admin_log" VALUES (90,'4','Dips',2,'[{"changed": {"fields": ["Name"]}}]',8,1,'2024-04-02 14:57:26.602561');
INSERT INTO "django_admin_log" VALUES (91,'12','Ab',1,'[{"added": {}}]',9,1,'2024-04-02 15:00:38.650761');
INSERT INTO "django_admin_log" VALUES (92,'28','Plank',1,'[{"added": {}}]',8,1,'2024-04-02 15:01:31.895489');
INSERT INTO "django_admin_log" VALUES (93,'28','Plank',2,'[{"changed": {"fields": ["Dangerous"]}}]',8,1,'2024-04-02 15:01:39.157946');
INSERT INTO "django_admin_log" VALUES (94,'29','Barbell Situp',1,'[{"added": {}}]',8,1,'2024-04-02 15:12:07.615364');
INSERT INTO "django_admin_log" VALUES (95,'28','Plank',2,'[]',8,1,'2024-04-02 15:12:12.051319');
INSERT INTO "django_admin_log" VALUES (96,'30','Abdominals Stretch One',1,'[{"added": {}}]',8,1,'2024-04-02 15:19:55.132384');
INSERT INTO "django_admin_log" VALUES (97,'7','Bosu Ball',1,'[{"added": {}}]',10,1,'2024-04-02 15:20:55.590692');
INSERT INTO "django_admin_log" VALUES (98,'31','Abdominals Stretch Two',1,'[{"added": {}}]',8,1,'2024-04-02 15:22:23.915703');
INSERT INTO "django_admin_log" VALUES (99,'31','Abdominals Stretch Two',2,'[]',8,1,'2024-04-02 15:26:26.569882');
INSERT INTO "django_admin_log" VALUES (100,'13','Quads',1,'[{"added": {}}]',9,1,'2024-04-02 15:46:33.622189');
INSERT INTO "django_admin_log" VALUES (101,'32','Barbell Squat',1,'[{"added": {}}]',8,1,'2024-04-02 15:47:47.512653');
INSERT INTO "django_admin_log" VALUES (102,'32','Barbell Squat',2,'[{"changed": {"fields": ["Dangerous"]}}]',8,1,'2024-04-02 15:48:29.548101');
INSERT INTO "django_admin_log" VALUES (103,'8','Machine',1,'[{"added": {}}]',10,1,'2024-04-02 15:48:54.647879');
INSERT INTO "django_admin_log" VALUES (104,'33','Leg Extension',1,'[{"added": {}}]',8,1,'2024-04-02 15:49:37.071670');
INSERT INTO "django_admin_log" VALUES (105,'34','Barbell Step Up Side',1,'[{"added": {}}]',8,1,'2024-04-02 15:52:48.618694');
INSERT INTO "django_admin_log" VALUES (106,'33','Leg Extension',2,'[]',8,1,'2024-04-02 15:52:58.208595');
INSERT INTO "django_admin_log" VALUES (107,'32','Barbell Squat',2,'[]',8,1,'2024-04-02 15:53:02.430885');
INSERT INTO "django_admin_log" VALUES (108,'35','Quad Stretch One',1,'[{"added": {}}]',8,1,'2024-04-02 16:08:23.941679');
INSERT INTO "django_admin_log" VALUES (109,'36','Quad Stretch Two',1,'[{"added": {}}]',8,1,'2024-04-02 16:09:35.642182');
INSERT INTO "django_admin_log" VALUES (110,'8','Outer Abdominals',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-04-05 18:17:22.922046');
INSERT INTO "django_admin_log" VALUES (111,'12','Abdominals',2,'[{"changed": {"fields": ["Name"]}}]',9,1,'2024-04-05 18:17:40.174931');
INSERT INTO "django_admin_log" VALUES (112,'7','Push Up',2,'[{"changed": {"fields": ["Dangerous"]}}]',8,1,'2024-04-05 23:09:53.742121');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'frontend','exercisetype');
INSERT INTO "django_content_type" VALUES (8,'frontend','video');
INSERT INTO "django_content_type" VALUES (9,'frontend','musclegroup');
INSERT INTO "django_content_type" VALUES (10,'frontend','equipment');
INSERT INTO "django_content_type" VALUES (11,'frontend','user');
INSERT INTO "django_session" VALUES ('ak7h5doadlochxik2iqdy1npp0ikuv70','.eJxVjL0OwyAQg9-FuUL8hZCO3fMM6OCOkrYiUkimqu9ekDK0kr34s_1mHo49-6PS5hdkVybZ5TcLEJ9UOsAHlPvK41r2bQm8V_hJK59XpNft7P4dZKi5rSejtCUYUWiIgKYrTKRTdNYKaUbSQrrmJGNC0xIBylklrDLDYBX7fAHhuTbv:1rS2Rm:Db3wXwb2N9EfL2OsAgsntiTQCNtglW0lfVefQGZMYhQ','2024-02-05 22:07:14.392133');
INSERT INTO "django_session" VALUES ('f9ny3g47gg9rmz2kim71rfoywax2tn2e','.eJxVjL0OwyAQg9-FuUL8hZCO3fMM6OCOkrYiUkimqu9ekDK0kr34s_1mHo49-6PS5hdkVybZ5TcLEJ9UOsAHlPvK41r2bQm8V_hJK59XpNft7P4dZKi5rSejtCUYUWiIgKYrTKRTdNYKaUbSQrrmJGNC0xIBylklrDLDYBX7fAHhuTbv:1raeEh:2mVOeA0C8QcmeU1IJqoQbNoMnHzi6N9CMO0yCD7xfzo','2024-02-29 16:05:19.806004');
INSERT INTO "django_session" VALUES ('q6g7vpie8lo5tyvn61l31iw10blk203c','.eJxVjL0OwyAQg9-FuUL8hZCO3fMM6OCOkrYiUkimqu9ekDK0kr34s_1mHo49-6PS5hdkVybZ5TcLEJ9UOsAHlPvK41r2bQm8V_hJK59XpNft7P4dZKi5rSejtCUYUWiIgKYrTKRTdNYKaUbSQrrmJGNC0xIBylklrDLDYBX7fAHhuTbv:1rpZwO:BdJr3f2jm5oOU5ulws4lJqEgzlDdFAerm6-w81e5ldk','2024-04-10 20:32:08.687839');
INSERT INTO "django_session" VALUES ('6tldnj96uv01tii6tkb02lwlrazripmi','.eJxVjL0OwyAQg9-FuUL8hZCO3fMM6OCOkrYiUkimqu9ekDK0kr34s_1mHo49-6PS5hdkVybZ5TcLEJ9UOsAHlPvK41r2bQm8V_hJK59XpNft7P4dZKi5rSejtCUYUWiIgKYrTKRTdNYKaUbSQrrmJGNC0xIBylklrDLDYBX7fAHhuTbv:1rso7F:Y6N1BZRNas9GoJweEP8EHcSonYd9mJXwG5MkKVxqQHU','2024-04-19 18:16:41.880370');
INSERT INTO "frontend_exercisetype" VALUES (1,'Muscle Builder');
INSERT INTO "frontend_exercisetype" VALUES (2,'Calisthenics');
INSERT INTO "frontend_exercisetype" VALUES (3,'Stretch');
INSERT INTO "frontend_musclegroup" VALUES (1,'Chest');
INSERT INTO "frontend_musclegroup" VALUES (2,'Shoulder');
INSERT INTO "frontend_musclegroup" VALUES (4,'Lower Back');
INSERT INTO "frontend_musclegroup" VALUES (5,'Tricep');
INSERT INTO "frontend_musclegroup" VALUES (7,'Bicep');
INSERT INTO "frontend_musclegroup" VALUES (8,'Outer Abdominals');
INSERT INTO "frontend_musclegroup" VALUES (9,'Elbow');
INSERT INTO "frontend_musclegroup" VALUES (10,'Upper Back');
INSERT INTO "frontend_musclegroup" VALUES (11,'Forearm');
INSERT INTO "frontend_musclegroup" VALUES (12,'Abdominals');
INSERT INTO "frontend_musclegroup" VALUES (13,'Quads');
INSERT INTO "frontend_video_muscles" VALUES (1,1,1);
INSERT INTO "frontend_video_muscles" VALUES (2,1,2);
INSERT INTO "frontend_video_muscles" VALUES (3,2,1);
INSERT INTO "frontend_video_muscles" VALUES (4,2,2);
INSERT INTO "frontend_video_muscles" VALUES (5,3,2);
INSERT INTO "frontend_video_muscles" VALUES (6,4,1);
INSERT INTO "frontend_video_muscles" VALUES (7,4,5);
INSERT INTO "frontend_video_muscles" VALUES (10,6,1);
INSERT INTO "frontend_video_muscles" VALUES (11,6,5);
INSERT INTO "frontend_video_muscles" VALUES (12,7,1);
INSERT INTO "frontend_video_muscles" VALUES (13,7,5);
INSERT INTO "frontend_video_muscles" VALUES (14,8,1);
INSERT INTO "frontend_video_muscles" VALUES (15,9,1);
INSERT INTO "frontend_video_muscles" VALUES (16,7,7);
INSERT INTO "frontend_video_muscles" VALUES (17,10,2);
INSERT INTO "frontend_video_muscles" VALUES (18,11,1);
INSERT INTO "frontend_video_muscles" VALUES (19,12,1);
INSERT INTO "frontend_video_muscles" VALUES (20,13,1);
INSERT INTO "frontend_video_muscles" VALUES (21,14,8);
INSERT INTO "frontend_video_muscles" VALUES (22,15,8);
INSERT INTO "frontend_video_muscles" VALUES (23,16,8);
INSERT INTO "frontend_video_muscles" VALUES (24,17,8);
INSERT INTO "frontend_video_muscles" VALUES (25,18,8);
INSERT INTO "frontend_video_muscles" VALUES (26,19,8);
INSERT INTO "frontend_video_muscles" VALUES (27,20,2);
INSERT INTO "frontend_video_muscles" VALUES (28,21,2);
INSERT INTO "frontend_video_muscles" VALUES (29,22,7);
INSERT INTO "frontend_video_muscles" VALUES (30,23,7);
INSERT INTO "frontend_video_muscles" VALUES (32,24,7);
INSERT INTO "frontend_video_muscles" VALUES (33,25,7);
INSERT INTO "frontend_video_muscles" VALUES (34,26,7);
INSERT INTO "frontend_video_muscles" VALUES (37,27,10);
INSERT INTO "frontend_video_muscles" VALUES (38,27,11);
INSERT INTO "frontend_video_muscles" VALUES (39,26,11);
INSERT INTO "frontend_video_muscles" VALUES (40,25,11);
INSERT INTO "frontend_video_muscles" VALUES (41,24,11);
INSERT INTO "frontend_video_muscles" VALUES (42,7,11);
INSERT INTO "frontend_video_muscles" VALUES (43,28,12);
INSERT INTO "frontend_video_muscles" VALUES (44,29,12);
INSERT INTO "frontend_video_muscles" VALUES (45,30,12);
INSERT INTO "frontend_video_muscles" VALUES (46,31,12);
INSERT INTO "frontend_video_muscles" VALUES (47,32,13);
INSERT INTO "frontend_video_muscles" VALUES (48,33,13);
INSERT INTO "frontend_video_muscles" VALUES (49,34,13);
INSERT INTO "frontend_video_muscles" VALUES (50,35,13);
INSERT INTO "frontend_video_muscles" VALUES (51,36,13);
INSERT INTO "frontend_video_type" VALUES (1,1,1);
INSERT INTO "frontend_video_type" VALUES (2,2,1);
INSERT INTO "frontend_video_type" VALUES (3,3,1);
INSERT INTO "frontend_video_type" VALUES (4,4,2);
INSERT INTO "frontend_video_type" VALUES (6,6,2);
INSERT INTO "frontend_video_type" VALUES (7,7,2);
INSERT INTO "frontend_video_type" VALUES (8,8,1);
INSERT INTO "frontend_video_type" VALUES (9,9,1);
INSERT INTO "frontend_video_type" VALUES (10,10,1);
INSERT INTO "frontend_video_type" VALUES (11,11,3);
INSERT INTO "frontend_video_type" VALUES (12,12,3);
INSERT INTO "frontend_video_type" VALUES (13,13,3);
INSERT INTO "frontend_video_type" VALUES (14,14,2);
INSERT INTO "frontend_video_type" VALUES (16,16,1);
INSERT INTO "frontend_video_type" VALUES (18,17,1);
INSERT INTO "frontend_video_type" VALUES (19,15,2);
INSERT INTO "frontend_video_type" VALUES (20,18,3);
INSERT INTO "frontend_video_type" VALUES (21,19,3);
INSERT INTO "frontend_video_type" VALUES (22,20,3);
INSERT INTO "frontend_video_type" VALUES (23,21,3);
INSERT INTO "frontend_video_type" VALUES (24,22,1);
INSERT INTO "frontend_video_type" VALUES (25,23,1);
INSERT INTO "frontend_video_type" VALUES (26,24,1);
INSERT INTO "frontend_video_type" VALUES (27,25,3);
INSERT INTO "frontend_video_type" VALUES (28,26,3);
INSERT INTO "frontend_video_type" VALUES (29,27,2);
INSERT INTO "frontend_video_type" VALUES (30,28,2);
INSERT INTO "frontend_video_type" VALUES (31,29,2);
INSERT INTO "frontend_video_type" VALUES (32,30,3);
INSERT INTO "frontend_video_type" VALUES (33,31,3);
INSERT INTO "frontend_video_type" VALUES (34,32,1);
INSERT INTO "frontend_video_type" VALUES (35,33,1);
INSERT INTO "frontend_video_type" VALUES (36,34,1);
INSERT INTO "frontend_video_type" VALUES (37,35,3);
INSERT INTO "frontend_video_type" VALUES (38,36,3);
INSERT INTO "frontend_video_dangerous" VALUES (1,1,1);
INSERT INTO "frontend_video_dangerous" VALUES (2,1,2);
INSERT INTO "frontend_video_dangerous" VALUES (3,2,1);
INSERT INTO "frontend_video_dangerous" VALUES (4,2,2);
INSERT INTO "frontend_video_dangerous" VALUES (5,3,2);
INSERT INTO "frontend_video_dangerous" VALUES (6,3,4);
INSERT INTO "frontend_video_dangerous" VALUES (7,4,1);
INSERT INTO "frontend_video_dangerous" VALUES (8,4,5);
INSERT INTO "frontend_video_dangerous" VALUES (11,6,1);
INSERT INTO "frontend_video_dangerous" VALUES (12,6,5);
INSERT INTO "frontend_video_dangerous" VALUES (13,7,1);
INSERT INTO "frontend_video_dangerous" VALUES (14,8,1);
INSERT INTO "frontend_video_dangerous" VALUES (15,9,1);
INSERT INTO "frontend_video_dangerous" VALUES (16,10,2);
INSERT INTO "frontend_video_dangerous" VALUES (17,15,2);
INSERT INTO "frontend_video_dangerous" VALUES (18,16,9);
INSERT INTO "frontend_video_dangerous" VALUES (19,22,7);
INSERT INTO "frontend_video_dangerous" VALUES (20,23,7);
INSERT INTO "frontend_video_dangerous" VALUES (21,24,5);
INSERT INTO "frontend_video_dangerous" VALUES (22,27,10);
INSERT INTO "frontend_video_dangerous" VALUES (23,27,11);
INSERT INTO "frontend_video_dangerous" VALUES (24,27,4);
INSERT INTO "frontend_video_dangerous" VALUES (25,28,12);
INSERT INTO "frontend_video_dangerous" VALUES (26,29,12);
INSERT INTO "frontend_video_dangerous" VALUES (27,30,12);
INSERT INTO "frontend_video_dangerous" VALUES (28,31,4);
INSERT INTO "frontend_video_dangerous" VALUES (29,32,4);
INSERT INTO "frontend_video_dangerous" VALUES (30,32,13);
INSERT INTO "frontend_video_dangerous" VALUES (31,33,13);
INSERT INTO "frontend_video_dangerous" VALUES (32,34,13);
INSERT INTO "frontend_video_dangerous" VALUES (33,7,9);
INSERT INTO "frontend_equipment" VALUES (1,'Barbell');
INSERT INTO "frontend_equipment" VALUES (2,'Bench');
INSERT INTO "frontend_equipment" VALUES (3,'Cable Machine');
INSERT INTO "frontend_equipment" VALUES (4,'Dumbell');
INSERT INTO "frontend_equipment" VALUES (5,'Kettlebell');
INSERT INTO "frontend_equipment" VALUES (6,'Bar');
INSERT INTO "frontend_equipment" VALUES (7,'Bosu Ball');
INSERT INTO "frontend_equipment" VALUES (8,'Machine');
INSERT INTO "frontend_video_equipment" VALUES (1,1,1);
INSERT INTO "frontend_video_equipment" VALUES (2,1,2);
INSERT INTO "frontend_video_equipment" VALUES (3,2,1);
INSERT INTO "frontend_video_equipment" VALUES (4,2,2);
INSERT INTO "frontend_video_equipment" VALUES (5,3,1);
INSERT INTO "frontend_video_equipment" VALUES (6,8,3);
INSERT INTO "frontend_video_equipment" VALUES (7,9,3);
INSERT INTO "frontend_video_equipment" VALUES (8,10,3);
INSERT INTO "frontend_video_equipment" VALUES (9,15,4);
INSERT INTO "frontend_video_equipment" VALUES (10,16,5);
INSERT INTO "frontend_video_equipment" VALUES (11,17,3);
INSERT INTO "frontend_video_equipment" VALUES (12,22,4);
INSERT INTO "frontend_video_equipment" VALUES (13,23,4);
INSERT INTO "frontend_video_equipment" VALUES (14,24,1);
INSERT INTO "frontend_video_equipment" VALUES (15,27,6);
INSERT INTO "frontend_video_equipment" VALUES (16,29,1);
INSERT INTO "frontend_video_equipment" VALUES (17,31,7);
INSERT INTO "frontend_video_equipment" VALUES (18,32,1);
INSERT INTO "frontend_video_equipment" VALUES (19,33,8);
INSERT INTO "frontend_video_equipment" VALUES (20,34,1);
INSERT INTO "frontend_video" VALUES (1,'videos_uploaded/male-barbell-bench-press-side_KciuhbB.mp4','Barbell Bench Press','Lie on a bench with your feet on the ground, grip the barbell slightly wider than shoulder-width apart, and lift off the rack. Lower the barbell to your chest in a controlled manner, keeping your elbows tucked at a 45-degree angle. Press the barbell back up, exhaling as you push, and fully extend your arms without locking your elbows. Repeat for the desired number of repetitions, maintaining proper form throughout by keeping your shoulder blades retracted and a slight arch in your lower back.');
INSERT INTO "frontend_video" VALUES (2,'videos_uploaded/male-Barbell-barbell-incline-bench-press-side.mp4','Incline Barbell Bench Press','The incline barbell bench press is a variation of the traditional bench press that targets the upper chest muscles and shoulders. To perform it, adjust the bench to a 30-45 degree angle, lie back with your feet flat on the floor, and grip the barbell slightly wider than shoulder-width apart. Lift the bar off the rack, lower it to your upper chest with controlled movement, then press it back up, exhaling as you push. Keep your elbows tucked at a 45-degree angle and maintain a slight arch in your lower back.');
INSERT INTO "frontend_video" VALUES (3,'videos_uploaded/male-barbell-overhead-press-side_1DIUbfS.mp4','Barbell Overhead Press','Stand with your feet shoulder-width apart, grip the barbell with your hands just slightly wider than shoulder-width, and lift it to shoulder height, resting it on your collarbones. Press the barbell overhead by extending your arms, exhaling as you push, until your arms are fully extended above your head. Keep your core engaged, avoid arching your back excessively, and ensure that the barbell moves in a straight line.');
INSERT INTO "frontend_video" VALUES (4,'videos_uploaded/male-Bodyweight-dips-side.mp4','Dips','Find parallel bars or dip bars and grasp them with a firm grip. Lift yourself up, supporting your body weight with your arms fully extended and your elbows locked. Lean slightly forward and lower your body by bending your elbows until your upper arms are parallel to the ground or slightly below. Keep your elbows tucked in close to your body to target your triceps more effectively. Push yourself back up to the starting position by straightening your arms, exhaling as you press.');
INSERT INTO "frontend_video" VALUES (6,'videos_uploaded/male-Bodyweight-elevated-pike-press-side.mp4','Elevated Pike Press','Start in a push-up position with your feet elevated on a stable surface, such as a bench or box, and your hands on the ground slightly wider than shoulder-width apart. Lift your hips upward, forming an inverted "V" shape with your body, and walk your hands closer to your feet, bringing your torso closer to your thighs. This is the starting position. From here, lower your head towards the ground by bending your elbows, keeping them pointed out to the sides. Lower yourself until your head almost touches the ground between your hands. Then, press back up to the starting position by straightening your arms, exhaling as you push.');
INSERT INTO "frontend_video" VALUES (7,'videos_uploaded/male-Bodyweight-push-up-side.mp4','Push Up','Start in a plank position with your hands placed slightly wider than shoulder-width apart and your arms fully extended, fingers pointing forward or slightly outward. Your body should form a straight line from your head to your heels, engaging your core muscles to maintain stability. Lower your body towards the ground by bending your elbows, keeping them close to your sides, until your chest nearly touches the ground. Ensure that your back remains flat and your hips don''t sag or rise too high. Then, push yourself back up to the starting position by straightening your arms, exhaling as you push.');
INSERT INTO "frontend_video" VALUES (8,'videos_uploaded/male-cable-chestpress-side.mp4','Cable Chest Press','Stand in front of a cable machine with handles attached at chest height, grab the handles with an overhand grip, and step forward to create stability. Push the handles forward by extending your arms in front of you while keeping a slight bend in your elbows. Exhale as you press the handles away, squeezing your chest muscles at the end of the movement. Slowly return to the starting position, inhaling as you bring the handles back towards your chest in a controlled manner.');
INSERT INTO "frontend_video" VALUES (9,'videos_uploaded/male-cable-pec-fly-side.mp4','Cable Pec-Fly','Set the cable machine''s handles to the lowest position, and select an appropriate weight. Stand in the middle of the machine, grasp each handle, and step forward to create tension in the cables. Keep a slight bend in your elbows and maintain a stable stance. Bring your arms forward and together in a wide arc, squeezing your chest muscles at the peak of the movement. Exhale as you bring the handles together. Slowly return to the starting position, controlling the movement and inhaling as you do so.');
INSERT INTO "frontend_video" VALUES (10,'videos_uploaded/male-Cables-cable-lateral-raise-side.mp4','Cable Lateral Raises','Stand sideways to the machine, grab one handle with the hand closest to the machine, and step away to create tension in the cable. Keep a slight bend in your elbow and maintain a neutral spine. Raise your arm to the side in a wide arc until it''s parallel to the ground, exhaling as you lift. Focus on using your shoulder muscles to lift the weight.');
INSERT INTO "frontend_video" VALUES (11,'videos_uploaded/male-chest-stretch-variation-1-side.mp4','Chest Stretch One',NULL);
INSERT INTO "frontend_video" VALUES (12,'videos_uploaded/male-chest-stretch-variation-2-side.mp4','Chest Stretch Two','Lay on your side with the arm you are resting on placed just in front of you. With a slight bend in your arm, rotate your arm around your body as slowly as possible then return to the starting position.');
INSERT INTO "frontend_video" VALUES (13,'videos_uploaded/male-chest-stretch-variation-3-side.mp4','Chest Stretch Three','Place your arms behind your back and clasp your hands together. Slowly extend your elbows until they are locked then lift them away from you. Pause in this position for a few seconds and then return them to starting position.');
INSERT INTO "frontend_video" VALUES (14,'videos_uploaded/male-bodyweight-hand-side-plank-front.mp4','Hand Side Plank','Start by lying on your side with your legs extended and stacked on top of each other. Place your lower forearm on the ground directly below your shoulder, with your elbow bent at a 90-degree angle. Press into the ground with your forearm and lift your hips off the ground, creating a straight line from your head to your heels. Extend your opposite arm straight up towards the ceiling or place it on your hip for stability. Engage your core muscles to keep your body in a straight line and hold this position for the desired amount of time. Ensure that your hips stay lifted and don''t sag towards the ground.');
INSERT INTO "frontend_video" VALUES (15,'videos_uploaded/male-Dumbbells-dumbbell-russian-twist-side.mp4','Dumbbell Russian-Twist','Sit on the floor with your knees bent and your feet flat on the ground. Hold a dumbbell with both hands close to your chest, or without any weight if you''re a beginner. Lean back slightly to engage your core muscles. Lift your feet off the ground and balance on your glutes, creating a V-shape with your torso and thighs. Keeping your back straight, rotate your torso to the right, bringing the dumbbell towards the floor next to your right hip. Then, rotate your torso to the left, bringing the dumbbell towards the floor next to your left hip. Keep your core engaged and your movements controlled throughout the exercise.');
INSERT INTO "frontend_video" VALUES (16,'videos_uploaded/male-Kettlebells-kettlebell-windmill-front.mp4','Kettlebell Windmill','With a kettlebell in your right hand, arm extended above your shoulder. Turn your right foot out to about a 45-degree angle and keep your left foot facing forward. Engage your core and press the kettlebell overhead, keeping your arm straight. Next, hinge at your hips, pushing them back as you lean your torso to the left while keeping your right arm extended overhead. Lower your left hand towards the ground or your left shin while keeping your gaze on the kettlebell. Maintain a straight line from your right hand to your right foot. Pause at the bottom position, then reverse the movement, returning to the starting position by driving through your right foot and engaging your core.');
INSERT INTO "frontend_video" VALUES (17,'videos_uploaded/male-cable-woodchopper-front.mp4','Cable Woodchopper','Stand sideways to the machine with your feet shoulder-width apart and grasp the handle with both hands. Begin with your arms straight and positioned above your shoulder closest to the machine. Engage your core and rotate your torso away from the machine, pulling the handle diagonally downwards across your body towards the opposite hip in a chopping motion. Keep your arms extended and your core engaged throughout the movement. Slowly return to the starting position with control.');
INSERT INTO "frontend_video" VALUES (18,'videos_uploaded/male-abdominals-stretch-variation-2-front.mp4','Outer Abdominals Stretch One','Stand upright. Reach with both hands upwards until you can interlock your fingers. With your hands above your head, lean back until a stretch is felt in the abdominals.');
INSERT INTO "frontend_video" VALUES (19,'videos_uploaded/male-abdominals-stretch-variation-3-front.mp4','Outer Abdominals Stretch Two','Stand upright. After completing the desired amount of reps with the left arm, switch to the right arm and lean to the left. Reach up with your left arm and then lean slowly to the right. Lean until a stretch is felt in the obliques.');
INSERT INTO "frontend_video" VALUES (20,'videos_uploaded/male-shoulders-stretch-variation-1-front.mp4','Shoulder Stretch One','Reach one arm behind your body, with your elbow pointing upward behind your head. Assist the stretch with your other hand on your elbow to engage your shoulder. Pause for a few seconds, then repeat the stretch with your other arm.');
INSERT INTO "frontend_video" VALUES (21,'videos_uploaded/male-shoulders-stretch-variation-3-front.mp4','Shoulder Stretch Two','Place the top of your hand into the small of your back, your arm at a 90 degree angle. Hold your elbow with the other arm, and slowly pull the arm forward until you feel your shoulder engaged in the stretch. Pause at the apex of the stretch and return to the starting position. Return to starting position, and repeat with your other arm.');
INSERT INTO "frontend_video" VALUES (22,'videos_uploaded/male-Dumbbells-dumbbell-curl-front.mp4','Dumbell Curl','Keep your elbows close to your torso and your back straight. Engage your core muscles for stability. Keeping your upper arms stationary, exhale and curl the dumbbells upwards towards your shoulders by flexing your elbows, contracting your biceps. Focus on keeping your wrists straight and avoiding swinging or using momentum. At the top of the movement, squeeze your biceps briefly. Inhale as you slowly lower the dumbbells back to the starting position.');
INSERT INTO "frontend_video" VALUES (23,'videos_uploaded/male-Dumbbells-dumbbell-hammer-curl-front.mp4','Hammer Curl','Stand or sit with a dumbbell in each hand, palms facing inward towards your body, arms fully extended down by your sides. Keep your elbows close to your torso and your back straight. Engage your core muscles for stability. Without rotating your wrists, exhale and curl the dumbbells upwards towards your shoulders by flexing your elbows. Keep the movement controlled and focus on contracting your biceps and the muscles in your forearms. At the top of the movement, squeeze your muscles briefly. Inhale as you slowly lower the dumbbells back to the starting position');
INSERT INTO "frontend_video" VALUES (24,'videos_uploaded/male-Barbell-barbell-reverse-curl-side.mp4','Reverse Curl','Stand or sit with a dumbbell in each hand, arms fully extended down by your sides, palms facing down towards the floor. Keep your elbows close to your torso and your back straight. Engage your core muscles for stability. Without rotating your wrists, exhale and curl the dumbbells upwards towards your shoulders by flexing your elbows. Focus on keeping your wrists straight and contracting the muscles in your forearms. At the top of the movement, briefly squeeze your muscles. Inhale as you slowly lower the dumbbells back to the starting position');
INSERT INTO "frontend_video" VALUES (25,'videos_uploaded/male-biceps-stretch-variation-1-side.mp4','Bicep and Forearm Stretch One','Stand one foot in front of the other with the wall to your right, an arms width away. Place your hand on the wall, fingers pointing away from you. Gently lean forward, keeping your hand stationary. Repeat with the other arm.');
INSERT INTO "frontend_video" VALUES (26,'videos_uploaded/male-biceps-stretch-variation-2-side.mp4','Bicep and Forearm Stretch Two','Stand facing the wall, an arm''s width away. Place your hand on the wall with your fingers pointing down. Lean slightly into the wall to feel the stretch in your bicep.');
INSERT INTO "frontend_video" VALUES (27,'videos_uploaded/male-bodyweight-chinup-front.mp4','Chinup','Start by hanging from a pull-up bar with your palms facing towards you, hands shoulder-width apart or slightly narrower. Engage your core muscles and keep your shoulders down and back. Exhale as you pull yourself up towards the bar by bending your elbows, keeping them close to your body. Focus on using your back and arm muscles to lift your body until your chin clears the bar. Hold the top position for a moment, then inhale as you slowly lower yourself back down to the starting position');
INSERT INTO "frontend_video" VALUES (28,'videos_uploaded/male-bodyweight-hand-plank-side_GnZ2NZh.mp4','Plank','Start by lying face down on the floor or exercise mat. Position your elbows directly under your shoulders, with your forearms flat on the ground and your hands clasped together. Extend your legs straight behind you, toes tucked under, and engage your core muscles to lift your body off the ground, forming a straight line from your head to your heels. Keep your neck in line with your spine and your gaze towards the floor. Hold this position, focusing on maintaining a tight core and avoiding sagging or arching in your back.');
INSERT INTO "frontend_video" VALUES (29,'videos_uploaded/male-Barbell-barbell-situp-side.mp4','Barbell Situp','Start by lying flat on your back on an exercise mat or bench, with your knees bent and your feet flat on the floor. Hold a barbell plate securely against your chest with both hands, or position a barbell across your chest and hold it firmly in place. Engage your core muscles to lift your upper body off the ground, curling your torso towards your thighs. Keep your arms extended and the barbell plate or barbell steady against your chest. Continue to lift your upper body until your torso is in a seated position, with your back straight and your chest lifted. Slowly lower your upper body back down to the starting position with control, allowing your back to rest on the ground or bench.');
INSERT INTO "frontend_video" VALUES (30,'videos_uploaded/male-abdominals-stretch-variation-1-side.mp4','Abdominals Stretch One','Lay on your stomach on the floor with your forearms flat on the ground. Extend your elbows and push your upper body upwards. Push your upper body upwards until you feel a stretch in your abs, then return to the starting position and repeat.');
INSERT INTO "frontend_video" VALUES (31,'videos_uploaded/male-abdominals-stretch-variation-4-front.mp4','Abdominals Stretch Two','Lay on a ball or a Bosu ball with your feet firmly planted on the floor. Lean all the way back until you feel a stretch in your abdomen. Crunch upwards and hold for a 1-2 count. Slowly return to the starting position and repeat.');
INSERT INTO "frontend_video" VALUES (32,'videos_uploaded/male-Barbell-barbell-squat-side.mp4','Barbell Squat','Start by standing with your feet shoulder-width apart, the barbell resting on your upper traps or rear delts, and your hands gripping the bar wider than shoulder-width apart. Keeping your core engaged and chest up, initiate the movement by bending your knees and pushing your hips back, descending until your thighs are parallel to the ground. Ensure your knees track in line with your toes and maintain a neutral spine throughout. Drive through your heels to return to the starting position');
INSERT INTO "frontend_video" VALUES (33,'videos_uploaded/male-machine-leg-extension-front.mp4','Leg Extension','Sit on the machine with your back against the cushion and adjust the machine you are using so that your knees are at a 90 degree angle at the starting position. Raise the weight by extending your knees outward, then lower your leg to the starting position. Both movements should be done in a slow, controlled motion.');
INSERT INTO "frontend_video" VALUES (34,'videos_uploaded/male-barbell-step-up-side.mp4','Barbell Step Up Side','start by standing in front of a bench with a barbell positioned on your upper back, gripping it with hands wider than shoulder-width apart. Step onto the bench with one foot, driving through the heel to lift your body upward, and bringing the other foot to meet it on top of the bench. Lower yourself back down with control by stepping back with the foot that initially stepped up. Maintain proper form throughout, keeping your chest up, back straight, and knees tracking in line with your toes.');
INSERT INTO "frontend_video" VALUES (35,'videos_uploaded/male-quads-stretch-variation-1-front.mp4','Quad Stretch One','Stand perpendicular to a wall, using one arm against the wall for balance. With your other arm, grab the top of your foot. Pull your leg upwards and back to engage your quads, pausing at the apex of the stretch for a few seconds. Return to starting position and repeat with your other leg.');
INSERT INTO "frontend_video" VALUES (36,'videos_uploaded/male-quads-stretch-variation-2-side.mp4','Quad Stretch Two','Place one foot flat on the ground in front of you at a 90 degree angle. With your other leg, balance upon your knee, placing the tip of your foot against the wall behind you for balance. Place your hands on your knee in front of you, and lean forward so that your knee extends over your foot. Pause at the apex of the stretch, and slowly return to starting position. Repeat with your other leg.');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (14,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (15,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (16,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (17,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (18,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (19,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (20,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (21,9,'add_musclegroup','Can add muscle group');
INSERT INTO "auth_permission" VALUES (22,9,'change_musclegroup','Can change muscle group');
INSERT INTO "auth_permission" VALUES (23,9,'delete_musclegroup','Can delete muscle group');
INSERT INTO "auth_permission" VALUES (24,9,'view_musclegroup','Can view muscle group');
INSERT INTO "auth_permission" VALUES (25,7,'add_exercisetype','Can add exercise type');
INSERT INTO "auth_permission" VALUES (26,7,'change_exercisetype','Can change exercise type');
INSERT INTO "auth_permission" VALUES (27,7,'delete_exercisetype','Can delete exercise type');
INSERT INTO "auth_permission" VALUES (28,7,'view_exercisetype','Can view exercise type');
INSERT INTO "auth_permission" VALUES (29,10,'add_equipment','Can add equipment');
INSERT INTO "auth_permission" VALUES (30,10,'change_equipment','Can change equipment');
INSERT INTO "auth_permission" VALUES (31,10,'delete_equipment','Can delete equipment');
INSERT INTO "auth_permission" VALUES (32,10,'view_equipment','Can view equipment');
INSERT INTO "auth_permission" VALUES (33,8,'add_video','Can add video');
INSERT INTO "auth_permission" VALUES (34,8,'change_video','Can change video');
INSERT INTO "auth_permission" VALUES (35,8,'delete_video','Can delete video');
INSERT INTO "auth_permission" VALUES (36,8,'view_video','Can view video');
INSERT INTO "auth_permission" VALUES (37,11,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (38,11,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (39,11,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (40,11,'view_user','Can view user');
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_video_muscles_video_id_musclegroup_id_63351df1_uniq" ON "frontend_video_muscles" (
	"video_id",
	"musclegroup_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_muscles_video_id_793265be" ON "frontend_video_muscles" (
	"video_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_muscles_musclegroup_id_5a0cdace" ON "frontend_video_muscles" (
	"musclegroup_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_video_type_video_id_exercisetype_id_1635591c_uniq" ON "frontend_video_type" (
	"video_id",
	"exercisetype_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_type_video_id_3829c340" ON "frontend_video_type" (
	"video_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_type_exercisetype_id_c0990902" ON "frontend_video_type" (
	"exercisetype_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_video_dangerous_video_id_musclegroup_id_0182847a_uniq" ON "frontend_video_dangerous" (
	"video_id",
	"musclegroup_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_dangerous_video_id_357fe0c0" ON "frontend_video_dangerous" (
	"video_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_dangerous_musclegroup_id_226d41ec" ON "frontend_video_dangerous" (
	"musclegroup_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "frontend_video_equipment_video_id_equipment_id_802b85ca_uniq" ON "frontend_video_equipment" (
	"video_id",
	"equipment_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_equipment_video_id_8ad4695d" ON "frontend_video_equipment" (
	"video_id"
);
CREATE INDEX IF NOT EXISTS "frontend_video_equipment_equipment_id_155c4043" ON "frontend_video_equipment" (
	"equipment_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
COMMIT;
