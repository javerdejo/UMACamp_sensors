create table bluetooth (
  id int not null auto_increment,
  sensor_id int not null,
  mac_address char(17) not null,
  duration int DEFAULT null,
  date_time datetime not null,
  primary key (id)
);

create table wifi (
   id int  not null auto_increment,
   sensor_id int not null,
   mac_address char(17) not null,
   first_time datetime not null,
   last_time datetime not null,
   power float not null,
   primary key (id)
);

create table sound (
   id int  not null auto_increment,
   sensor_id int not null,
   noise float not null,
   peak float not null,
   low float not null,
   date_time datetime not null,
   primary key (id)
);

create table status (
   id int not null auto_increment,
   sensor_id int not null,
   date_time datetime not null,
   ip char(15) not null,
   event int default 0,
   sound_records int not null default 0,
   bt_records int not null default 0,
   wifi_records int not null default 0,
   message varchar(255) default 'ok',
   primary key (id)
);

create table sensors (
   sensor_id int not null,
   ip char(15) not null,
   date_time_sensor datetime not null,
   date_time_server datetime not null,
   status int default 0,
   message varchar(255) default 'ok',
   primary key (sensor_id)
);

CREATE EVENT update_sensors_status ON SCHEDULE EVERY 5 MINUTE STARTS now() DO
update sensors set message = 'off' where date_time_server < DATE_SUB(now(), INTERVAL 10 MINUTE);
