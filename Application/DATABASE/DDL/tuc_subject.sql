-- Create table
create table TUC_SUBJECT
(
  subject_id       NUMBER(5) not null,
  subject_name     VARCHAR2(50) not null,
  teacher_id       VARCHAR2(100) not null,
  status           CHAR(1) default 'R' not null,
  maker_id         VARCHAR2(100) default 'SYSTEM' not null,
  maker_time       DATE default SYSDATE not null,
  last_update_by   VARCHAR2(100) default 'SYSTEM' not null,
  last_update_time DATE default SYSDATE not null,
  class_id         NUMBER(5) not null
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
alter table TUC_SUBJECT
  add constraint TUC_SUBJECT_PK primary key (SUBJECT_ID)
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
alter table TUC_SUBJECT
  add constraint TUC_SUBJECT_UK unique (SUBJECT_NAME)
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
alter table TUC_SUBJECT
  add constraint TUC_SUBJECT_FK foreign key (TEACHER_ID)
  references TUC_SYS_USER_MAST (ID);
alter table TUC_SUBJECT
  add constraint TUC_SUBJECT_FK2 foreign key (CLASS_ID)
  references TUC_CLASS (CLASS_ID);
