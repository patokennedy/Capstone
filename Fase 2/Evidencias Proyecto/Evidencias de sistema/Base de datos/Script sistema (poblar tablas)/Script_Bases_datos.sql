BEGIN TRANSACTION;
DROP TABLE IF EXISTS "auth_group";
CREATE TABLE "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_group_permissions";
CREATE TABLE "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_permission";
CREATE TABLE "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user";
CREATE TABLE "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "auth_user_groups";
CREATE TABLE "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "auth_user_user_permissions";
CREATE TABLE "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_alumno";
CREATE TABLE "core_alumno" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"apellido"	varchar(200) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"user_id"	integer NOT NULL UNIQUE,
	"apoderado_id"	bigint,
	"curso_id"	bigint,
	"estado_admision"	varchar(50) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("apoderado_id") REFERENCES "core_apoderado"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_apoderado";
CREATE TABLE "core_apoderado" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"apellido"	varchar(200) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"telefono"	varchar(15),
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_asistencia";
CREATE TABLE "core_asistencia" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"curso_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_asistencia_alumnos_ausentes";
CREATE TABLE "core_asistencia_alumnos_ausentes" (
	"id"	integer NOT NULL,
	"asistencia_id"	bigint NOT NULL,
	"alumno_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("asistencia_id") REFERENCES "core_asistencia"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_asistencia_alumnos_justificados";
CREATE TABLE "core_asistencia_alumnos_justificados" (
	"id"	integer NOT NULL,
	"asistencia_id"	bigint NOT NULL,
	"alumno_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("asistencia_id") REFERENCES "core_asistencia"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_asistencia_alumnos_presentes";
CREATE TABLE "core_asistencia_alumnos_presentes" (
	"id"	integer NOT NULL,
	"asistencia_id"	bigint NOT NULL,
	"alumno_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("asistencia_id") REFERENCES "core_asistencia"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_calificacion";
CREATE TABLE "core_calificacion" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"alumno_id"	bigint NOT NULL,
	"curso_id"	bigint NOT NULL,
	"nota"	decimal NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_contrato";
CREATE TABLE "core_contrato" (
	"id"	integer NOT NULL,
	"forma_pago"	varchar(100) NOT NULL,
	"apoderado_id"	bigint NOT NULL,
	"fecha"	date NOT NULL,
	"alumno_id"	bigint UNIQUE,
	"observaciones"	text,
	"valor_total"	decimal NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("apoderado_id") REFERENCES "core_apoderado"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_curso";
CREATE TABLE "core_curso" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"asignatura"	varchar(100) NOT NULL,
	"dias"	varchar(100) NOT NULL,
	"hora"	time NOT NULL,
	"profesor_id"	bigint NOT NULL,
	"sala"	varchar(50) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("profesor_id") REFERENCES "core_profesor"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_curso_alumnos";
CREATE TABLE "core_curso_alumnos" (
	"id"	integer NOT NULL,
	"curso_id"	bigint NOT NULL,
	"alumno_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_director";
CREATE TABLE "core_director" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"apellido"	varchar(200) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_informe";
CREATE TABLE "core_informe" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"contenido"	text NOT NULL,
	"curso_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_informeacademico";
CREATE TABLE "core_informeacademico" (
	"id"	integer NOT NULL,
	"total_alumnos"	integer NOT NULL,
	"promedio_notas"	decimal NOT NULL,
	"promedio_asistencia"	decimal NOT NULL,
	"curso_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_informefinanciero";
CREATE TABLE "core_informefinanciero" (
	"id"	integer NOT NULL,
	"concepto"	varchar(200) NOT NULL,
	"monto"	decimal NOT NULL,
	"observaciones"	text,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "core_observacion";
CREATE TABLE "core_observacion" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"contenido"	text NOT NULL,
	"alumno_id"	bigint NOT NULL,
	"curso_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_profesor";
CREATE TABLE "core_profesor" (
	"id"	integer NOT NULL,
	"nombre"	varchar(100) NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"user_id"	integer NOT NULL UNIQUE,
	"apellido"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "core_registroacademico";
CREATE TABLE "core_registroacademico" (
	"id"	integer NOT NULL,
	"fecha"	date NOT NULL,
	"observaciones"	text,
	"alumno_id"	bigint NOT NULL,
	"curso_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("alumno_id") REFERENCES "core_alumno"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("curso_id") REFERENCES "core_curso"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_admin_log";
CREATE TABLE "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
DROP TABLE IF EXISTS "django_content_type";
CREATE TABLE "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "django_migrations";
CREATE TABLE "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
DROP TABLE IF EXISTS "django_session";
CREATE TABLE "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
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
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_profesor','Can add profesor');
INSERT INTO "auth_permission" VALUES (26,7,'change_profesor','Can change profesor');
INSERT INTO "auth_permission" VALUES (27,7,'delete_profesor','Can delete profesor');
INSERT INTO "auth_permission" VALUES (28,7,'view_profesor','Can view profesor');
INSERT INTO "auth_permission" VALUES (29,8,'add_alumno','Can add alumno');
INSERT INTO "auth_permission" VALUES (30,8,'change_alumno','Can change alumno');
INSERT INTO "auth_permission" VALUES (31,8,'delete_alumno','Can delete alumno');
INSERT INTO "auth_permission" VALUES (32,8,'view_alumno','Can view alumno');
INSERT INTO "auth_permission" VALUES (33,9,'add_curso','Can add curso');
INSERT INTO "auth_permission" VALUES (34,9,'change_curso','Can change curso');
INSERT INTO "auth_permission" VALUES (35,9,'delete_curso','Can delete curso');
INSERT INTO "auth_permission" VALUES (36,9,'view_curso','Can view curso');
INSERT INTO "auth_permission" VALUES (37,10,'add_informe','Can add informe');
INSERT INTO "auth_permission" VALUES (38,10,'change_informe','Can change informe');
INSERT INTO "auth_permission" VALUES (39,10,'delete_informe','Can delete informe');
INSERT INTO "auth_permission" VALUES (40,10,'view_informe','Can view informe');
INSERT INTO "auth_permission" VALUES (41,11,'add_observacion','Can add observacion');
INSERT INTO "auth_permission" VALUES (42,11,'change_observacion','Can change observacion');
INSERT INTO "auth_permission" VALUES (43,11,'delete_observacion','Can delete observacion');
INSERT INTO "auth_permission" VALUES (44,11,'view_observacion','Can view observacion');
INSERT INTO "auth_permission" VALUES (45,12,'add_calificacion','Can add calificacion');
INSERT INTO "auth_permission" VALUES (46,12,'change_calificacion','Can change calificacion');
INSERT INTO "auth_permission" VALUES (47,12,'delete_calificacion','Can delete calificacion');
INSERT INTO "auth_permission" VALUES (48,12,'view_calificacion','Can view calificacion');
INSERT INTO "auth_permission" VALUES (49,13,'add_registroacademico','Can add registro academico');
INSERT INTO "auth_permission" VALUES (50,13,'change_registroacademico','Can change registro academico');
INSERT INTO "auth_permission" VALUES (51,13,'delete_registroacademico','Can delete registro academico');
INSERT INTO "auth_permission" VALUES (52,13,'view_registroacademico','Can view registro academico');
INSERT INTO "auth_permission" VALUES (53,14,'add_asistencia','Can add asistencia');
INSERT INTO "auth_permission" VALUES (54,14,'change_asistencia','Can change asistencia');
INSERT INTO "auth_permission" VALUES (55,14,'delete_asistencia','Can delete asistencia');
INSERT INTO "auth_permission" VALUES (56,14,'view_asistencia','Can view asistencia');
INSERT INTO "auth_permission" VALUES (57,15,'add_apoderado','Can add apoderado');
INSERT INTO "auth_permission" VALUES (58,15,'change_apoderado','Can change apoderado');
INSERT INTO "auth_permission" VALUES (59,15,'delete_apoderado','Can delete apoderado');
INSERT INTO "auth_permission" VALUES (60,15,'view_apoderado','Can view apoderado');
INSERT INTO "auth_permission" VALUES (61,16,'add_informefinanciero','Can add informe financiero');
INSERT INTO "auth_permission" VALUES (62,16,'change_informefinanciero','Can change informe financiero');
INSERT INTO "auth_permission" VALUES (63,16,'delete_informefinanciero','Can delete informe financiero');
INSERT INTO "auth_permission" VALUES (64,16,'view_informefinanciero','Can view informe financiero');
INSERT INTO "auth_permission" VALUES (65,17,'add_informeacademico','Can add informe academico');
INSERT INTO "auth_permission" VALUES (66,17,'change_informeacademico','Can change informe academico');
INSERT INTO "auth_permission" VALUES (67,17,'delete_informeacademico','Can delete informe academico');
INSERT INTO "auth_permission" VALUES (68,17,'view_informeacademico','Can view informe academico');
INSERT INTO "auth_permission" VALUES (69,18,'add_director','Can add director');
INSERT INTO "auth_permission" VALUES (70,18,'change_director','Can change director');
INSERT INTO "auth_permission" VALUES (71,18,'delete_director','Can delete director');
INSERT INTO "auth_permission" VALUES (72,18,'view_director','Can view director');
INSERT INTO "auth_permission" VALUES (73,19,'add_contrato','Can add contrato');
INSERT INTO "auth_permission" VALUES (74,19,'change_contrato','Can change contrato');
INSERT INTO "auth_permission" VALUES (75,19,'delete_contrato','Can delete contrato');
INSERT INTO "auth_permission" VALUES (76,19,'view_contrato','Can view contrato');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$870000$8cZuf7G99Ru4BXCprW29FK$gbiv/IFZriV2/DayfIlAkGbP1vFuPHMZIHGjFd0c4/M=','2024-10-27 15:30:15.851732',1,'admin','','or.sierra@duocuc.cl',1,1,'2024-10-04 13:05:47.675659','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$870000$7wRQxUxlkzXkFLclUHXwmv$KeNC8n9ZJ6tGfoQBCPqj7jUfbiTuRqYDAhE/HGz8QX4=','2024-10-27 01:25:59.620290',0,'profesor1','','profesor1@colegio.com',0,1,'2024-10-13 20:18:03.263246','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$870000$wvYA9V9Zmrf6iuhlbYDsht$ZIxiCQRIKjlTsKwws87CG7J/qtylB+vQMonG3ASUfac=','2024-10-14 19:05:13.736041',0,'profesor2','','profesor2@colegio.com',0,1,'2024-10-13 20:18:03.682225','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$870000$uolabDhVeiEdFt3oB4jqAT$xbNU+ahpA38Cu3gAeDiBuzn8ryY0mrbHJR3C06RApUQ=','2024-10-25 12:21:51.570215',0,'alumno1','','alumno1@colegio.com',0,1,'2024-10-13 20:18:04.063729','');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$390000$MgRNStowzPVvnnnHa0m8Ek$3ur0s/yb3+8OLINh+80jn6JW/R9ndHx/a/B8ks8at0E=','2024-10-14 21:18:51.040852',0,'alumno2','','alumno2@colegio.com',0,1,'2024-10-13 20:18:04.441865','');
INSERT INTO "auth_user" VALUES (6,'pbkdf2_sha256$870000$QqqKuCLbBHNtd6Ri7IKhJV$CIzDgbxojNwtnBBg0LyYLo6HiKoLPtnRk435F+BqGQA=','2024-10-25 12:15:49.054670',0,'luis_diaz','','luis.diaz@example.com',0,1,'2024-10-20 21:56:00.452806','');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$870000$BNeWylAJd8UF5ooQt3Bbc8$p7WUuFrUQjIpaKCqRHXnmlc5J1iI3sgGn+A9X2Fnz9Q=',NULL,0,'maria_fernandez','','maria.fernandez@example.com',0,1,'2024-10-20 21:56:00.870026','');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$870000$Y17mAtybyPV2qko2F5zJPZ$lGC0NyRzjrdJBoFkLon0D+ngg5qUVC0N/LNb0xfeAK8=',NULL,0,'benja@gmail.com','','benja@gmail.com',0,1,'2024-10-21 21:02:04.371414','');
INSERT INTO "auth_user" VALUES (9,'pbkdf2_sha256$870000$IleDHhyntp5n8B8GeXr2tr$Kr7Ce2pbOdtabsC3aht6Pb/2z7Gxi/ylVM7ovwq7HXw=',NULL,0,'benj@gmail.com','','benj@gmail.com',0,1,'2024-10-21 21:08:50.268105','');
INSERT INTO "auth_user" VALUES (10,'pbkdf2_sha256$870000$1vZDjWzjhkRFihZl7tZ13u$60vaNuZf3rz6TI7zTi9kHkjHqsTvL0zJ0Kim4DwgTw4=',NULL,0,'patr@gmail.com','','patr@gmail.com',0,1,'2024-10-21 21:13:53.586957','');
INSERT INTO "auth_user" VALUES (11,'pbkdf2_sha256$870000$TWHSJ9ebbMzh1xvSdM2SVM$8go4cWLacoBFsne/CKJmlqALs3nnEPxIS2DPHUNyP2o=',NULL,0,'or@gmail.com','','or@gmail.com',0,1,'2024-10-21 21:40:36.277977','');
INSERT INTO "auth_user" VALUES (12,'pbkdf2_sha256$870000$FGtp1WM6Tx51ZtKebD0qWZ$ncDoSmZmoEbfQWRysluma1N6+DsQw4RBu+iaMN7rG8Y=',NULL,0,'matias@gmail.com','','matias@gmail.com',0,1,'2024-10-21 21:41:13.480290','');
INSERT INTO "auth_user" VALUES (13,'pbkdf2_sha256$870000$0ffD3k9mmeWgCvLm2PfYDY$FDY4R4MOuU2OFQ5SBkbM084m3ziT5fMCnkXPbvkQVRE=','2024-10-21 21:59:15.933679',0,'mati@gmail.com','','mati@gmail.com',0,1,'2024-10-21 21:50:45.339162','');
INSERT INTO "auth_user" VALUES (14,'pbkdf2_sha256$870000$DiTpILx2ResJf2txzLLfm8$BzM+PDvckILvbcTuZyCjozIomkJPNEse0cdSEPPwTGM=',NULL,0,'sierra@gmail.com','','sierra@gmail.com',0,1,'2024-10-21 22:33:12.579629','');
INSERT INTO "auth_user" VALUES (15,'pbkdf2_sha256$870000$GGTmeYqeod78E6fuxjFx4B$9ugh6a/ArKg63vpVZsJZ+7D2GvVIcwPjkdk4ugtT6lQ=',NULL,0,'diaz@gmail.com','','diaz@gmail.com',0,1,'2024-10-21 22:37:20.912800','');
INSERT INTO "auth_user" VALUES (16,'pbkdf2_sha256$870000$Ec6L3mKqnx4c7HDHrIOYWR$rTjaUfHguJy7fgmATV65YXv8AAu0y/AlX5ghMpg4QC4=',NULL,0,'ray@gmail.com','','ray@gmail.com',0,1,'2024-10-21 22:37:49.031642','');
INSERT INTO "auth_user" VALUES (17,'pbkdf2_sha256$870000$Z0gbx3FtJ1bY2dOpMgWakO$1tqAu5+2kEV6KxAWYmz5FUCm5lqQtAylB9pJdVUrS9k=','2024-10-22 21:07:29.421436',0,'marc@gmail.com','','marc@gmail.com',0,1,'2024-10-22 16:38:28.202232','');
INSERT INTO "auth_user" VALUES (18,'pbkdf2_sha256$870000$zNnLSbRXUO7tBzq8jnV0KM$88nODmhrx39UB0qwXwng0eHQrF20l6Elxqvdrr+2/t4=',NULL,0,'dimi@gmail.com','','dimi@gmail.com',0,1,'2024-10-22 16:38:58.152995','');
INSERT INTO "auth_user" VALUES (19,'pbkdf2_sha256$870000$oDuOLQH8bIezgaKtacZme4$6osRUzYux2ZlULQgSv8ozkZ7hNHc5Vf6W+VH3VpwjBE=','2024-10-25 12:14:36.947118',0,'director','','',0,1,'2024-10-24 19:34:16.031172','');
INSERT INTO "core_alumno" VALUES (1,'Pedro','López','pedro.lopez@colegio.com',4,1,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (2,'Ana','Martínez','ana.martinez@colegio.com',5,2,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (5,'patricio','vergara','patr@gmail.com',10,1,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (8,'matias','fernandez','mati@gmail.com',13,2,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (9,'orlando','Sierra','sierra@gmail.com',14,2,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (10,'felipe','diaz','diaz@gmail.com',15,1,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (11,'jose','ray','ray@gmail.com',16,1,5,'Aprobado');
INSERT INTO "core_alumno" VALUES (12,'marcelo','almiray','marc@gmail.com',17,2,6,'Aprobado');
INSERT INTO "core_alumno" VALUES (13,'dimitri','almiray','dimi@gmail.com',18,2,6,'Pendiente');
INSERT INTO "core_apoderado" VALUES (1,'Luis','Díaz','luis.diaz@example.com','123456789',6);
INSERT INTO "core_apoderado" VALUES (2,'María','Fernández','maria.fernandez@example.com','987654321',7);
INSERT INTO "core_asistencia" VALUES (1,'2024-10-14',5);
INSERT INTO "core_asistencia" VALUES (2,'2024-10-14',6);
INSERT INTO "core_asistencia" VALUES (3,'2024-10-14',7);
INSERT INTO "core_asistencia" VALUES (4,'2024-10-14',8);
INSERT INTO "core_asistencia" VALUES (5,'2024-10-15',5);
INSERT INTO "core_asistencia" VALUES (6,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (7,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (8,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (9,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (10,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (11,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (12,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (13,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (14,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (15,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (16,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (17,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (18,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (19,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (20,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (21,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (22,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (23,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (24,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (25,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (26,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (27,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (28,'2024-10-22',5);
INSERT INTO "core_asistencia" VALUES (29,'2024-10-22',6);
INSERT INTO "core_asistencia" VALUES (30,'2024-10-25',5);
INSERT INTO "core_asistencia" VALUES (31,'2024-10-25',6);
INSERT INTO "core_asistencia" VALUES (32,'2024-10-25',5);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (4,2,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (5,3,2);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (6,4,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (9,7,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (10,7,8);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (11,8,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (12,8,5);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (13,9,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (14,9,8);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (15,9,10);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (16,10,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (17,11,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (18,12,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (19,13,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (20,14,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (21,14,5);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (22,14,9);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (23,30,2);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (24,32,1);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (25,32,2);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (26,32,5);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (27,32,8);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (28,32,9);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (29,32,10);
INSERT INTO "core_asistencia_alumnos_ausentes" VALUES (30,32,11);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (4,7,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (5,8,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (6,8,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (7,9,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (8,9,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (9,10,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (10,10,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (11,10,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (12,10,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (13,10,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (14,11,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (15,11,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (16,11,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (17,11,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (18,11,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (19,12,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (20,12,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (21,12,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (22,12,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (23,12,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (24,13,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (25,13,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (26,13,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (27,13,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (28,13,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (29,14,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (30,14,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (31,15,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (32,16,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (33,16,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (34,16,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (35,16,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (36,16,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (37,16,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (38,18,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (39,18,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (40,18,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (41,18,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (42,18,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (43,18,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (44,19,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (45,19,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (46,19,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (47,19,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (48,19,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (49,19,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (50,21,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (51,21,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (52,21,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (53,21,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (54,21,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (55,21,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (56,22,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (57,22,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (58,22,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (59,22,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (60,22,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (61,22,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (62,23,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (63,23,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (64,23,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (65,23,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (66,23,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (67,23,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (68,24,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (69,24,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (70,24,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (71,24,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (72,24,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (73,24,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (74,25,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (75,25,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (76,25,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (77,25,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (78,25,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (79,25,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (80,26,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (81,26,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (82,26,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (83,26,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (84,26,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (85,26,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (86,27,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (87,27,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (88,27,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (89,27,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (90,27,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (91,27,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (92,28,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (93,28,2);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (94,28,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (95,28,8);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (96,28,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (97,28,10);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (98,29,12);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (99,30,1);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (100,30,5);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (101,30,9);
INSERT INTO "core_asistencia_alumnos_justificados" VALUES (102,31,12);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (5,4,2);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (6,1,1);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (27,5,1);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (28,7,2);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (29,7,9);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (30,7,10);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (31,8,2);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (32,8,9);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (33,9,9);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (34,14,10);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (35,15,2);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (36,15,5);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (37,15,8);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (38,15,9);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (39,15,10);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (40,17,1);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (41,17,2);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (42,17,5);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (43,17,8);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (44,17,9);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (45,17,10);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (46,30,8);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (47,30,10);
INSERT INTO "core_asistencia_alumnos_presentes" VALUES (48,30,11);
INSERT INTO "core_calificacion" VALUES (1,'2024-10-14',2,6,6);
INSERT INTO "core_calificacion" VALUES (2,'2024-10-14',1,5,7);
INSERT INTO "core_calificacion" VALUES (3,'2024-10-14',1,5,7);
INSERT INTO "core_calificacion" VALUES (4,'2024-10-14',2,6,7);
INSERT INTO "core_calificacion" VALUES (5,'2024-10-14',2,6,7);
INSERT INTO "core_calificacion" VALUES (6,'2024-10-14',2,6,7);
INSERT INTO "core_calificacion" VALUES (7,'2024-10-15',1,5,7);
INSERT INTO "core_calificacion" VALUES (8,'2024-10-15',1,5,7);
INSERT INTO "core_calificacion" VALUES (9,'2024-10-15',1,5,6);
INSERT INTO "core_calificacion" VALUES (10,'2024-10-15',1,5,5);
INSERT INTO "core_calificacion" VALUES (11,'2024-10-15',1,5,1);
INSERT INTO "core_calificacion" VALUES (12,'2024-10-15',1,5,3);
INSERT INTO "core_calificacion" VALUES (13,'2024-10-15',1,5,5);
INSERT INTO "core_calificacion" VALUES (14,'2024-10-15',1,5,4);
INSERT INTO "core_calificacion" VALUES (15,'2024-10-15',1,5,5);
INSERT INTO "core_calificacion" VALUES (16,'2024-10-22',1,5,7);
INSERT INTO "core_calificacion" VALUES (17,'2024-10-22',2,5,7);
INSERT INTO "core_calificacion" VALUES (18,'2024-10-22',5,5,7);
INSERT INTO "core_calificacion" VALUES (19,'2024-10-22',8,5,7);
INSERT INTO "core_calificacion" VALUES (20,'2024-10-22',9,5,7);
INSERT INTO "core_calificacion" VALUES (21,'2024-10-22',10,5,7);
INSERT INTO "core_calificacion" VALUES (22,'2024-10-22',12,6,7);
INSERT INTO "core_calificacion" VALUES (23,'2024-10-25',1,5,7);
INSERT INTO "core_calificacion" VALUES (24,'2024-10-25',2,5,6);
INSERT INTO "core_calificacion" VALUES (25,'2024-10-25',5,5,4);
INSERT INTO "core_calificacion" VALUES (26,'2024-10-25',8,5,7);
INSERT INTO "core_calificacion" VALUES (27,'2024-10-25',9,5,2);
INSERT INTO "core_calificacion" VALUES (28,'2024-10-25',10,5,1);
INSERT INTO "core_calificacion" VALUES (29,'2024-10-25',11,5,7);
INSERT INTO "core_calificacion" VALUES (30,'2024-10-25',12,6,5);
INSERT INTO "core_contrato" VALUES (1,'efectivo',1,'2024-01-21',2,'xb',1500000);
INSERT INTO "core_contrato" VALUES (2,'efectivo',1,'2024-01-21',1,'rtfyy',1500000);
INSERT INTO "core_contrato" VALUES (3,'efectivo',2,'2024-01-22',13,'Holaaa',1500000);
INSERT INTO "core_contrato" VALUES (4,'cheque',2,'2024-01-22',12,'xfghfdhdh',1500000);
INSERT INTO "core_curso" VALUES (5,'1ero Medio','Lenguaje','Lunes, Miércoles','10:00:00',1,'Sala 5');
INSERT INTO "core_curso" VALUES (6,'3ero Medio','Lenguaje','Martes, Jueves','10:30:00',1,'Sala 2');
INSERT INTO "core_curso" VALUES (7,'2do Medio','Historia','Lunes, Miércoles','11:00:00',2,'Sala 3');
INSERT INTO "core_curso" VALUES (8,'2do Medio','Historia','Martes, Viernes','14:00:00',2,'Sala 4');
INSERT INTO "core_curso_alumnos" VALUES (1,5,1);
INSERT INTO "core_curso_alumnos" VALUES (2,6,2);
INSERT INTO "core_director" VALUES (1,'Alex','Pérez','alex.perez@example.com',19);
INSERT INTO "core_informefinanciero" VALUES (1,'matricula',1000000,'muy caro');
INSERT INTO "core_observacion" VALUES (1,'2024-10-15','alumno se porta mal',1,5);
INSERT INTO "core_observacion" VALUES (7,'2024-10-18','Alumno se porta bien',1,5);
INSERT INTO "core_observacion" VALUES (10,'2024-10-22','ALUMNO',8,5);
INSERT INTO "core_profesor" VALUES (1,'Juan','juan.perez@colegio.com',2,'Pérez');
INSERT INTO "core_profesor" VALUES (2,'María','maria.gonzalez@colegio.com',3,'González');
INSERT INTO "django_admin_log" VALUES (1,'5','patricio vergara',2,'[{"changed": {"fields": ["Apoderado"]}}]',8,1,'2024-10-22 16:24:17.495051');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'core','profesor');
INSERT INTO "django_content_type" VALUES (8,'core','alumno');
INSERT INTO "django_content_type" VALUES (9,'core','curso');
INSERT INTO "django_content_type" VALUES (10,'core','informe');
INSERT INTO "django_content_type" VALUES (11,'core','observacion');
INSERT INTO "django_content_type" VALUES (12,'core','calificacion');
INSERT INTO "django_content_type" VALUES (13,'core','registroacademico');
INSERT INTO "django_content_type" VALUES (14,'core','asistencia');
INSERT INTO "django_content_type" VALUES (15,'core','apoderado');
INSERT INTO "django_content_type" VALUES (16,'core','informefinanciero');
INSERT INTO "django_content_type" VALUES (17,'core','informeacademico');
INSERT INTO "django_content_type" VALUES (18,'core','director');
INSERT INTO "django_content_type" VALUES (19,'core','contrato');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2024-10-04 13:04:34.363543');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2024-10-04 13:04:34.379165');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2024-10-04 13:04:34.394800');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2024-10-04 13:04:34.410407');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2024-10-04 13:04:34.426029');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2024-10-04 13:04:34.441684');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2024-10-04 13:04:34.457272');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2024-10-04 13:04:34.472894');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2024-10-04 13:04:34.488514');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2024-10-04 13:04:34.504136');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2024-10-04 13:04:34.504136');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2024-10-04 13:04:34.519757');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2024-10-04 13:04:34.519757');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2024-10-04 13:04:34.535377');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2024-10-04 13:04:34.551004');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2024-10-04 13:04:34.566627');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2024-10-04 13:04:34.566627');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2024-10-04 13:04:34.582242');
INSERT INTO "django_migrations" VALUES (19,'core','0001_initial','2024-10-13 19:34:29.373518');
INSERT INTO "django_migrations" VALUES (20,'core','0002_remove_alumno_apellido','2024-10-13 19:46:21.399117');
INSERT INTO "django_migrations" VALUES (21,'core','0002_alter_profesor_apellido','2024-10-13 20:00:30.278402');
INSERT INTO "django_migrations" VALUES (22,'core','0002_alter_alumno_apellido','2024-10-13 20:06:24.573977');
INSERT INTO "django_migrations" VALUES (23,'core','0003_alter_alumno_apellido_asistencia_calificacion_and_more','2024-10-14 00:25:30.737485');
INSERT INTO "django_migrations" VALUES (24,'core','0004_curso_sala','2024-10-14 13:23:35.778318');
INSERT INTO "django_migrations" VALUES (25,'core','0005_asistencia_alumnos_ausentes_and_more','2024-10-14 14:08:33.340583');
INSERT INTO "django_migrations" VALUES (26,'core','0006_remove_curso_alumnos_curso_alumno','2024-10-14 20:29:51.261037');
INSERT INTO "django_migrations" VALUES (27,'core','0007_remove_curso_alumno_curso_alumnos','2024-10-14 21:05:10.433545');
INSERT INTO "django_migrations" VALUES (28,'core','0006_alter_calificacion_fecha','2024-10-14 22:07:27.789056');
INSERT INTO "django_migrations" VALUES (29,'core','0007_alter_calificacion_fecha_alter_calificacion_nota','2024-10-14 22:07:27.821198');
INSERT INTO "django_migrations" VALUES (30,'core','0008_alter_calificacion_fecha_alter_calificacion_nota','2024-10-14 22:07:27.848264');
INSERT INTO "django_migrations" VALUES (31,'core','0009_merge_20241014_1906','2024-10-14 22:07:27.862727');
INSERT INTO "django_migrations" VALUES (32,'core','0009_merge_20241014_1905','2024-10-15 19:10:46.475374');
INSERT INTO "django_migrations" VALUES (33,'core','0010_apoderado_alumno_apoderado','2024-10-15 19:10:46.530924');
INSERT INTO "django_migrations" VALUES (34,'core','0011_merge_20241015_1610','2024-10-15 19:10:46.544723');
INSERT INTO "django_migrations" VALUES (35,'core','0011_merge_20241015_1555','2024-10-15 20:28:53.016322');
INSERT INTO "django_migrations" VALUES (36,'core','0012_merge_20241015_1728','2024-10-15 20:28:53.043451');
INSERT INTO "django_migrations" VALUES (37,'core','0011_merge_20241015_1618','2024-10-20 19:18:13.504992');
INSERT INTO "django_migrations" VALUES (38,'core','0013_merge_20241017_1612','2024-10-20 19:18:13.508994');
INSERT INTO "django_migrations" VALUES (39,'core','0013_merge_20241016_1631','2024-10-20 19:18:13.513206');
INSERT INTO "django_migrations" VALUES (40,'core','0014_merge_20241017_2331','2024-10-20 19:18:13.517550');
INSERT INTO "django_migrations" VALUES (41,'core','0015_alumno_estado_admision','2024-10-21 20:44:18.826083');
INSERT INTO "django_migrations" VALUES (42,'core','0016_alumno_curso_alter_alumno_estado_admision_and_more','2024-10-21 21:30:31.744781');
INSERT INTO "django_migrations" VALUES (43,'core','0017_alter_alumno_apellido_alter_alumno_estado_admision','2024-10-22 15:51:00.421509');
INSERT INTO "django_migrations" VALUES (44,'core','0018_alter_alumno_apellido_alter_alumno_estado_admision','2024-10-22 16:17:09.962137');
INSERT INTO "django_migrations" VALUES (45,'core','0019_informefinanciero','2024-10-22 21:15:41.118045');
INSERT INTO "django_migrations" VALUES (46,'core','0020_informeacademico','2024-10-22 23:24:16.655499');
INSERT INTO "django_migrations" VALUES (47,'core','0021_director','2024-10-24 19:32:22.433489');
INSERT INTO "django_migrations" VALUES (48,'core','0022_contrato','2024-10-25 11:43:04.511152');
INSERT INTO "django_migrations" VALUES (49,'core','0023_rename_fecha_firma_contrato_fecha_and_more','2024-10-27 01:05:45.700854');
INSERT INTO "django_session" VALUES ('11sw9p58kqtsraixqx20natd2vseued2','.eJxVjEEOwiAQRe_C2hALDLQu3fcMzQwzSNVAUtqV8e7apAvd_vfef6kJtzVPW5NlmlldVKdOvxthfEjZAd-x3KqOtazLTHpX9EGbHivL83q4fwcZW_7WLhKciR15n7wJDqJYkdQFwz7BQHEwiQiRkwUQpEi9BYOJAShAb9X7Aw8yOSQ:1swi0k:SCiFjPzXHVJvYNjGJZjHE0MG_6eVAhsrO8ZwXgyYaUk','2024-10-18 13:06:22.342072');
INSERT INTO "django_session" VALUES ('3u5303wqbbhcpi0c9zo567fdz40ra4ko','.eJxVjMEOwiAQRP-FsyFAWxY8eu83kF1YpGpoUtqT8d9tkx70NMm8N_MWAbe1hK3xEqYkrsKIy29HGJ9cD5AeWO-zjHNdl4nkociTNjnOiV-30_07KNjKvgYbmTk7M6TOY7LKWTKd9YoANPcxD0pRZABP0CMm8Mga9R6ZHCKIzxf1Bjig:1t2cm4:nOkuVhOU-v-IZYfotdwCwbO8ajHfSc4oI1VXKl3rf-A','2024-11-03 20:43:40.323223');
INSERT INTO "django_session" VALUES ('4oabvjtmj3nihhe6t6h27rufmpksodjc','.eJxVjMEOwiAQRP-FsyFAWxY8eu83kF1YpGpoUtqT8d9tkx70NMm8N_MWAbe1hK3xEqYkrsKIy29HGJ9cD5AeWO-zjHNdl4nkociTNjnOiV-30_07KNjKvgYbmTk7M6TOY7LKWTKd9YoANPcxD0pRZABP0CMm8Mga9R6ZHCKIzxf1Bjig:1t0MYO:IEmGz-5LALeztYk_YrabeJ-BuVIavRrmmsj7PEhDkLE','2024-10-28 15:00:12.189833');
INSERT INTO "django_session" VALUES ('7llifxeo2qd48apxhk57ffwvaqti7j1m','e30:1t0QSt:GhnJCJn31bdb1uDOdSjhiXmenNaUOitYH82SNBHMkSk','2024-10-28 19:10:47.561084');
INSERT INTO "django_session" VALUES ('vfusxcr6hb69aaxf5c0sa4j6ms2sbcd9','e30:1t0QTH:DHq10cbtz3GzvY7zRAh3olLZ9NMkpJ7w3_n7vLR4qKA','2024-10-28 19:11:11.950194');
INSERT INTO "django_session" VALUES ('vdenqsiga6camr4tfprjt7g98aycllr0','.eJxVjMEOwiAQRP-FsyFs2YJ49O43kIUFqRpISnsy_rtt0oMeZ96beQtP61L82tPsJxYXMYrTbxcoPlPdAT-o3puMrS7zFOSuyIN2eWucXtfD_Tso1Mu21kYRQyIwZ0RAZ4chK-u0JrAYtqwMAHEmYBeYHUPUOSHjmF1OisXnC8HPN88:1t0SSp:4e5hZc9hoZa8vNjdT6xAfhp2dgf9769PNESuyyIrSrM','2024-10-28 21:18:51.059342');
INSERT INTO "django_session" VALUES ('rou6rq4rukchh7ng3zvch36fchpf70wa','.eJxVjMsOwiAQRf-FtSEw5enSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM7MsNPvFpEeue0g3bHdOqfe1mWOfFf4QQe_9pSfl8P9O6g46rcG0gTC5TKJmEBDQTIyg7KiWOfAeBdFFD4r4ZGiIpJJWkhoi7bkYGLvD-KAN8s:1t2fsn:QRveIU2tZdI-65GOvTprstVD6omxe6bbondLdoCgXHY','2024-11-04 00:02:49.947462');
INSERT INTO "django_session" VALUES ('g6qvf0wqx98p33ovpt6qnkxspffl123k','.eJxVjMsOwiAQRf-FtSE8Bgou3fsNZIBBqgaS0q6M_65NutDtPefcFwu4rTVsg5YwZ3ZmcmKn3zFielDbSb5ju3WeeluXOfJd4Qcd_NozPS-H-3dQcdRvLUgUMUVVskvRQiLjpJWlICnQaKK3ILQuqCCDJ7AOVZLZokNvyBnP3h8Zhjg9:1t3M6D:KcXLvoZd8vErfjfMXxjbGDCHg33T2l8GqYfTy_buxVI','2024-11-05 21:07:29.436275');
INSERT INTO "django_session" VALUES ('sh9es3cgic6qp09fa0jznr2p1a6k3bxf','.eJxVjMsOwiAQRf-FtSEw5enSvd9AhgGkaiAp7cr479qkC93ec859sYDbWsM28hLmxM7MsNPvFpEeue0g3bHdOqfe1mWOfFf4QQe_9pSfl8P9O6g46rcG0gTC5TKJmEBDQTIyg7KiWOfAeBdFFD4r4ZGiIpJJWkhoi7bkYGLvD-KAN8s:1t3Nyn:N_lEAEwYNX-y1HUbTv3JhE24mUFUxhVwiiLHr5CuSA8','2024-11-05 23:07:57.459747');
INSERT INTO "django_session" VALUES ('91voaxno3huv8rse2fjxg4dbat1nhatc','e30:1t43fG:y14Jtwaw1DLvzKakWX6P5WFUdOl9r_nF69Wl64IlVNs','2024-11-07 19:38:34.474287');
INSERT INTO "django_session" VALUES ('noac3icn8n9ue0hv1air2tcm5agoujaw','e30:1t43fo:MAWD6Erm26hP2oz7O0oXqcKhGftfMFSpjjKbvU67Ulk','2024-11-07 19:39:08.960708');
INSERT INTO "django_session" VALUES ('hshob5hggoyqmqtrepo4tdd0dofppt5l','.eJxVjMEOgjAQRP-lZ9OwLoXWo3e_odntbgU1JaFwMv67kHDQOc57M28TaV2GuFad4yjmYiCY02_JlJ5adiIPKvfJpqks88h2V-xBq71Noq_r4f4dDFSHbd24AB7BSQ9AkFrA3IBwx50w-Qazyx334ILHjK1nhS0BUVSV2nMwny_l6jdp:1t43jw:YlM1nPdZ1D1n9raQsCuKYektOdzc8g9UkR4kopZk_00','2024-11-07 19:43:24.008923');
INSERT INTO "django_session" VALUES ('9s5303vg804s502y3bwioodoegeq3yv2','e30:1t463F:7T0-q8FKFYitTbui0NKTdvIGIAdYsNjArK_jlhXdfhI','2024-11-07 22:11:29.850809');
INSERT INTO "django_session" VALUES ('mmjjm3q6v9ikq1mpopou052aj9kjsjrn','e30:1t464I:4FsK62RRtkWwVqk9HTYt2k5gPy4rf5Kw02wm1FK78qA','2024-11-07 22:12:34.223831');
INSERT INTO "django_session" VALUES ('aqeea7ca935lhbsnsx4g4atdug7f2tzi','e30:1t4Ivo:AM_fdhSqglBOh3Hx_DrEbjpBz_Okrfqeznay7nZm85w','2024-11-08 11:56:40.204788');
INSERT INTO "django_session" VALUES ('kz3n9ptykxloxppqtrne03fpg3v94rky','e30:1t4IyK:T7WhEHZWwGUbg3v3ITjyJ-PDOaNv1rsLodu8AzTdXeM','2024-11-08 11:59:16.682576');
INSERT INTO "django_session" VALUES ('561npdpyeodfdpvv97nlyf0wmf9spdo2','e30:1t4J6F:Q94RirsdHY2qA08TDqCli_DCq2WboEx84-ltj5AvgNc','2024-11-08 12:07:27.984665');
INSERT INTO "django_session" VALUES ('0ck12sdacgn9p1pz0ghakbfx40rput6g','.eJxVjMEOwiAQRP-FsyFAWxY8eu83kF1YpGpoUtqT8d9tkx70NMm8N_MWAbe1hK3xEqYkrsKIy29HGJ9cD5AeWO-zjHNdl4nkociTNjnOiV-30_07KNjKvgYbmTk7M6TOY7LKWTKd9YoANPcxD0pRZABP0CMm8Mga9R6ZHCKIzxf1Bjig:1t4J94:UU8kkBrRkboKccmCUOYkfSBmuV4vAiMKX4X5LVa4OEY','2024-11-08 12:10:22.764121');
INSERT INTO "django_session" VALUES ('98lnajg5wmvqex7epss49eb3k3wk871m','.eJxVjMEOwiAQRP-FsyFAWxY8eu83kF1YpGpoUtqT8d9tkx70NMm8N_MWAbe1hK3xEqYkrsKIy29HGJ9cD5AeWO-zjHNdl4nkociTNjnOiV-30_07KNjKvgYbmTk7M6TOY7LKWTKd9YoANPcxD0pRZABP0CMm8Mga9R6ZHCKIzxf1Bjig:1t4JOs:HoR4SOb4IdRqQndE5f4bd2UcaSjsqJu2t_xOXizRv4o','2024-11-08 12:26:42.145459');
INSERT INTO "django_session" VALUES ('eyn1bhgw3mi1tmab3tgsrqrzlvuiu4yq','.eJxVjEEOwiAQRe_C2hALDLQu3fcMzQwzSNVAUtqV8e7apAvd_vfef6kJtzVPW5NlmlldVKdOvxthfEjZAd-x3KqOtazLTHpX9EGbHivL83q4fwcZW_7WLhKciR15n7wJDqJYkdQFwz7BQHEwiQiRkwUQpEi9BYOJAShAb9X7Aw8yOSQ:1t55Db:kx_ZdU6EcfyTEpKiqcWuPWvsyQdq6i37-3l9io7r4sk','2024-11-10 15:30:15.857208');
DROP INDEX IF EXISTS "auth_group_permissions_group_id_b120cbf9";
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq";
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
DROP INDEX IF EXISTS "auth_group_permissions_permission_id_84c5c92e";
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_2f476e4b";
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
DROP INDEX IF EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq";
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
DROP INDEX IF EXISTS "auth_user_groups_group_id_97559544";
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_6a12ed8b";
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq";
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c";
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_a95ead1b";
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
DROP INDEX IF EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq";
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
DROP INDEX IF EXISTS "core_alumno_apoderado_id_a3a4343b";
CREATE INDEX "core_alumno_apoderado_id_a3a4343b" ON "core_alumno" (
	"apoderado_id"
);
DROP INDEX IF EXISTS "core_alumno_curso_id_34cb5723";
CREATE INDEX "core_alumno_curso_id_34cb5723" ON "core_alumno" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_ausentes_alumno_id_7e6c8ae0";
CREATE INDEX "core_asistencia_alumnos_ausentes_alumno_id_7e6c8ae0" ON "core_asistencia_alumnos_ausentes" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_ausentes_asistencia_id_alumno_id_64069c22_uniq";
CREATE UNIQUE INDEX "core_asistencia_alumnos_ausentes_asistencia_id_alumno_id_64069c22_uniq" ON "core_asistencia_alumnos_ausentes" (
	"asistencia_id",
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_ausentes_asistencia_id_f07f411d";
CREATE INDEX "core_asistencia_alumnos_ausentes_asistencia_id_f07f411d" ON "core_asistencia_alumnos_ausentes" (
	"asistencia_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_justificados_alumno_id_1baa4f36";
CREATE INDEX "core_asistencia_alumnos_justificados_alumno_id_1baa4f36" ON "core_asistencia_alumnos_justificados" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_justificados_asistencia_id_99b4cc98";
CREATE INDEX "core_asistencia_alumnos_justificados_asistencia_id_99b4cc98" ON "core_asistencia_alumnos_justificados" (
	"asistencia_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_justificados_asistencia_id_alumno_id_a09ae52d_uniq";
CREATE UNIQUE INDEX "core_asistencia_alumnos_justificados_asistencia_id_alumno_id_a09ae52d_uniq" ON "core_asistencia_alumnos_justificados" (
	"asistencia_id",
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_presentes_alumno_id_4d6c13bf";
CREATE INDEX "core_asistencia_alumnos_presentes_alumno_id_4d6c13bf" ON "core_asistencia_alumnos_presentes" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_presentes_asistencia_id_5c271012";
CREATE INDEX "core_asistencia_alumnos_presentes_asistencia_id_5c271012" ON "core_asistencia_alumnos_presentes" (
	"asistencia_id"
);
DROP INDEX IF EXISTS "core_asistencia_alumnos_presentes_asistencia_id_alumno_id_0b8ef97c_uniq";
CREATE UNIQUE INDEX "core_asistencia_alumnos_presentes_asistencia_id_alumno_id_0b8ef97c_uniq" ON "core_asistencia_alumnos_presentes" (
	"asistencia_id",
	"alumno_id"
);
DROP INDEX IF EXISTS "core_asistencia_curso_id_f001b1d0";
CREATE INDEX "core_asistencia_curso_id_f001b1d0" ON "core_asistencia" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_calificacion_alumno_id_f08d9963";
CREATE INDEX "core_calificacion_alumno_id_f08d9963" ON "core_calificacion" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_calificacion_curso_id_edf2cd73";
CREATE INDEX "core_calificacion_curso_id_edf2cd73" ON "core_calificacion" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_contrato_apoderado_id_8f4ee8d6";
CREATE INDEX "core_contrato_apoderado_id_8f4ee8d6" ON "core_contrato" (
	"apoderado_id"
);
DROP INDEX IF EXISTS "core_curso_alumnos_alumno_id_5206ab9c";
CREATE INDEX "core_curso_alumnos_alumno_id_5206ab9c" ON "core_curso_alumnos" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_curso_alumnos_curso_id_6a55a879";
CREATE INDEX "core_curso_alumnos_curso_id_6a55a879" ON "core_curso_alumnos" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_curso_alumnos_curso_id_alumno_id_eb771c13_uniq";
CREATE UNIQUE INDEX "core_curso_alumnos_curso_id_alumno_id_eb771c13_uniq" ON "core_curso_alumnos" (
	"curso_id",
	"alumno_id"
);
DROP INDEX IF EXISTS "core_curso_profesor_id_4eaccbc4";
CREATE INDEX "core_curso_profesor_id_4eaccbc4" ON "core_curso" (
	"profesor_id"
);
DROP INDEX IF EXISTS "core_informe_curso_id_33650b48";
CREATE INDEX "core_informe_curso_id_33650b48" ON "core_informe" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_informeacademico_curso_id_ecba3812";
CREATE INDEX "core_informeacademico_curso_id_ecba3812" ON "core_informeacademico" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_observacion_alumno_id_9a33eef0";
CREATE INDEX "core_observacion_alumno_id_9a33eef0" ON "core_observacion" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_observacion_curso_id_1d69f871";
CREATE INDEX "core_observacion_curso_id_1d69f871" ON "core_observacion" (
	"curso_id"
);
DROP INDEX IF EXISTS "core_registroacademico_alumno_id_5881119f";
CREATE INDEX "core_registroacademico_alumno_id_5881119f" ON "core_registroacademico" (
	"alumno_id"
);
DROP INDEX IF EXISTS "core_registroacademico_curso_id_fcff1db7";
CREATE INDEX "core_registroacademico_curso_id_fcff1db7" ON "core_registroacademico" (
	"curso_id"
);
DROP INDEX IF EXISTS "django_admin_log_content_type_id_c4bce8eb";
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
DROP INDEX IF EXISTS "django_admin_log_user_id_c564eba6";
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
DROP INDEX IF EXISTS "django_content_type_app_label_model_76bd3d3b_uniq";
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
DROP INDEX IF EXISTS "django_session_expire_date_a5c62663";
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
