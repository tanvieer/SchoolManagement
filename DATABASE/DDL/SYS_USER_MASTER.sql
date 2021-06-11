-- Create table
create table SYS_USER_MASTER
(
  id               VARCHAR2(100) default SYS_GUID() not null,
  username         VARCHAR2(50) not null,
  first_name       VARCHAR2(50) not null,
  last_name        VARCHAR2(50) not null,
  email            VARCHAR2(50) not null,
  phone_number     VARCHAR2(20),
  password         VARCHAR2(500) not null,
  enc_key          VARCHAR2(100) not null,
  status           CHAR(1) default 'R' not null,
  role_id          NUMBER(8) not null,
  maker_id         VARCHAR2(100) default 'SYSTEM' not null,
  maker_time       DATE default SYSDATE not null,
  last_update_by   VARCHAR2(100) default 'SYSTEM' not null,
  last_update_time DATE default SYSDATE not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column SYS_USER_MASTER.id
  is 'a system generated unique id';
comment on column SYS_USER_MASTER.username
  is 'a unique username which can be used for login';
comment on column SYS_USER_MASTER.first_name
  is 'forename';
comment on column SYS_USER_MASTER.last_name
  is 'surname';
comment on column SYS_USER_MASTER.email
  is 'this email will be used for sending passwar through email and email should be unique';
comment on column SYS_USER_MASTER.password
  is 'encrypted password';
comment on column SYS_USER_MASTER.enc_key
  is 'encryption key';
comment on column SYS_USER_MASTER.status
  is 'A = archived,  R = active/running';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_USER_MASTER
  add constraint SYS_USER_MASTER_PK primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SYS_USER_MASTER
  add constraint SYS_USER_MASTER_UK1 unique (USERNAME)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SYS_USER_MASTER
  add constraint SYS_USER_MASTER_FK1 foreign key (ROLE_ID)
  references SYS_ROLE (ROLE_ID);
