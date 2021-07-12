-- Create table
create table TUC_MENU
(
  id               NUMBER(5) not null,
  router_link      VARCHAR2(50) not null,
  router_name      VARCHAR2(50) not null,
  role_id          NUMBER(2) not null,
  is_sub_menu      NUMBER(1) default 0 not null,
  module_name      VARCHAR2(50) not null,
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
