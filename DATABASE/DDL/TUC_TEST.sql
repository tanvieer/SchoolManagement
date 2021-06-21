-- Create table
create table TUC_TEST
(
  test_id          NUMBER(5) not null,
  test_name        VARCHAR2(50) not null,
  subject_id       VARCHAR2(100) not null,
  test_date        date not null,
  status           CHAR(1) default 'R' not null,
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table TUC_TEST
  add constraint TUC_TEST_PK primary key (test_id)
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
