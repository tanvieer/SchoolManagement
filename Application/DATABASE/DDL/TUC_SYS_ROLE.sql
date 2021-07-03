-- Create table
create table TUC_SYS_ROLE
(
  role_id          NUMBER(8) not null,
  role_name        VARCHAR2(20) not null,
  role_description VARCHAR2(100) not null,
  status           CHAR(1) default 'R' not null,
  maker_id         VARCHAR2(100) default 'SYSTEM' not null,
  maker_time       DATE default SYSDATE not null,
  last_update_time DATE default SYSDATE not null,
  last_update_by   VARCHAR2(50) default 'SYSTEM' not null
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
comment on column TUC_SYS_ROLE.role_name
  is 'A UNIQUE ROLE NAME';
comment on column TUC_SYS_ROLE.role_description
  is 'ROLE DESCRIPTION';
comment on column TUC_SYS_ROLE.status
  is 'A = archived,  R = active/running';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TUC_SYS_ROLE
  add constraint SYS_ROLE_PK primary key (ROLE_ID)
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
alter table TUC_SYS_ROLE
  add constraint SYS_ROLE_UK unique (ROLE_NAME)
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
