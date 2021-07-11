-- Create table
create table TUC_RESULT
(
  result_id        NUMBER(5) not null,
  test_id          NUMBER(5) not null,
  student_id       VARCHAR2(100) not null,
  grade            NUMBER(8,2) not null,
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
alter table TUC_RESULT
  add constraint TUC_RESULT_PK primary key (RESULT_ID)
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
alter table TUC_RESULT
  add constraint TUC_RESULT_FK1 foreign key (STUDENT_ID)
  references TUC_SYS_USER_MAST (ID);
