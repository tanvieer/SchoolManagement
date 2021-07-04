-----------------------------------------------
-- Export file for user SCHOOLMGMT           --
-- Created by tanvi on 7/4/2021, 10:19:12 PM --
-----------------------------------------------

spool Table and Package Script.log

prompt
prompt Creating table TUC_CLASS
prompt ========================
prompt
create table SCHOOLMGMT.TUC_CLASS
(
  class_id         NUMBER(5) not null,
  class_name       VARCHAR2(50) not null,
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
alter table SCHOOLMGMT.TUC_CLASS
  add constraint TUC_CLASS_PK primary key (CLASS_ID)
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

prompt
prompt Creating table TUC_SYS_ROLE
prompt ===========================
prompt
create table SCHOOLMGMT.TUC_SYS_ROLE
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
comment on column SCHOOLMGMT.TUC_SYS_ROLE.role_name
  is 'A UNIQUE ROLE NAME';
comment on column SCHOOLMGMT.TUC_SYS_ROLE.role_description
  is 'ROLE DESCRIPTION';
comment on column SCHOOLMGMT.TUC_SYS_ROLE.status
  is 'A = archived,  R = active/running';
alter table SCHOOLMGMT.TUC_SYS_ROLE
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
alter table SCHOOLMGMT.TUC_SYS_ROLE
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

prompt
prompt Creating table TUC_SYS_USER_MAST
prompt ================================
prompt
create table SCHOOLMGMT.TUC_SYS_USER_MAST
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
  last_update_time DATE default SYSDATE not null,
  last_logged_in   DATE,
  session_id       VARCHAR2(100),
  session_exp_time DATE,
  class_id         NUMBER(8)
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
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.id
  is 'a system generated unique id';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.username
  is 'a unique username which can be used for login';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.first_name
  is 'forename';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.last_name
  is 'surname';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.email
  is 'this email will be used for sending passwar through email and email should be unique';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.password
  is 'encrypted password';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.enc_key
  is 'encryption key';
comment on column SCHOOLMGMT.TUC_SYS_USER_MAST.status
  is 'A = archived,  R = active/running';
alter table SCHOOLMGMT.TUC_SYS_USER_MAST
  add constraint SYS_USER_MASTER_TUC_PK primary key (ID)
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
alter table SCHOOLMGMT.TUC_SYS_USER_MAST
  add constraint SYS_USER_MASTER_TUC_UK1 unique (USERNAME)
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
alter table SCHOOLMGMT.TUC_SYS_USER_MAST
  add constraint SYS_USER_MASTER_TUC_FK1 foreign key (ROLE_ID)
  references SCHOOLMGMT.TUC_SYS_ROLE (ROLE_ID);
alter table SCHOOLMGMT.TUC_SYS_USER_MAST
  add constraint SYS_USER_MASTER_TUC_FK2 foreign key (CLASS_ID)
  references SCHOOLMGMT.TUC_CLASS (CLASS_ID);

prompt
prompt Creating table TUC_SUBJECT
prompt ==========================
prompt
create table SCHOOLMGMT.TUC_SUBJECT
(
  subject_id       NUMBER(5) not null,
  subject_name     VARCHAR2(50) not null,
  teacher_id       VARCHAR2(100) not null,
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
alter table SCHOOLMGMT.TUC_SUBJECT
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
alter table SCHOOLMGMT.TUC_SUBJECT
  add constraint TUC_SUBJECT_FK foreign key (TEACHER_ID)
  references SCHOOLMGMT.TUC_SYS_USER_MAST (ID);

prompt
prompt Creating table TUC_CLASS_SUBJECT_MAP
prompt ====================================
prompt
create table SCHOOLMGMT.TUC_CLASS_SUBJECT_MAP
(
  class_id         NUMBER(5) not null,
  subject_id       NUMBER(5) not null,
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
alter table SCHOOLMGMT.TUC_CLASS_SUBJECT_MAP
  add constraint TUC_CLASS_SUBJECT_MAP_PK primary key (CLASS_ID, SUBJECT_ID)
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
alter table SCHOOLMGMT.TUC_CLASS_SUBJECT_MAP
  add constraint TUC_CLASS_SUBJECT_MAP_FK1 foreign key (CLASS_ID)
  references SCHOOLMGMT.TUC_CLASS (CLASS_ID);
alter table SCHOOLMGMT.TUC_CLASS_SUBJECT_MAP
  add constraint TUC_CLASS_SUBJECT_MAP_FK2 foreign key (SUBJECT_ID)
  references SCHOOLMGMT.TUC_SUBJECT (SUBJECT_ID);

prompt
prompt Creating table TUC_RESULT
prompt =========================
prompt
create table SCHOOLMGMT.TUC_RESULT
(
  result_id        NUMBER(5) not null,
  test_id          NUMBER(5) not null,
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
alter table SCHOOLMGMT.TUC_RESULT
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

prompt
prompt Creating table TUC_TEST
prompt =======================
prompt
create table SCHOOLMGMT.TUC_TEST
(
  test_id          NUMBER(5) not null,
  test_name        VARCHAR2(50) not null,
  subject_id       NUMBER(5) not null,
  test_date        DATE not null,
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
alter table SCHOOLMGMT.TUC_TEST
  add constraint TUC_TEST_PK primary key (TEST_ID)
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
alter table SCHOOLMGMT.TUC_TEST
  add constraint TUC_TEST_FK1 foreign key (SUBJECT_ID)
  references SCHOOLMGMT.TUC_SUBJECT (SUBJECT_ID);

prompt
prompt Creating package PKG_TUC_MANAGE_OP
prompt ==================================
prompt
create or replace package schoolmgmt.pkg_tuc_manage_op is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations
  procedure sp_class_subject_map(p_activity   in char,
                                 p_subject_id in tuc_class_subject_map.subject_id%type,
                                 p_class_id   in tuc_class_subject_map.class_id%type,
                                 p_user_id    in TUC_SYS_USER_MAST.maker_id%type,
                                 p_out        out number,
                                 p_err_code   out varchar2,
                                 p_err_msg    out varchar2);
  procedure sp_tuc_class(p_activity   in char,
                         p_class_id   out tuc_class.class_id%type,
                         p_class_name in tuc_class.class_name%type,
                         p_user_id    in tuc_class.maker_id%type,
                         p_out        out number,
                         p_err_code   out varchar2,
                         p_err_msg    out varchar2);
  procedure sp_tuc_class_gk(p_class_id in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor);

  procedure sp_tuc_class_ga(p_in       in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor);

  procedure sp_tuc_subject(p_activity     in char,
                           p_subject_id   out tuc_subject.subject_id%type,
                           p_subject_name in tuc_subject.subject_name%type,
                           p_teacher_id   in tuc_sys_user_mast.id%type,
                           p_user_id      in tuc_subject.maker_id%type,
                           p_out          out number,
                           p_err_code     out varchar2,
                           p_err_msg      out varchar2);

  procedure sp_tuc_subject_gk(p_subject_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor);

  procedure sp_tuc_subject_ga(p_in       in nvarchar2,
                              p_class_id in nvarchar2,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor);

  procedure sp_tuc_test(p_activity   in char,
                        p_test_id    in out tuc_test.test_id%type,
                        p_test_name  in tuc_test.test_name%type,
                        p_subject_id in tuc_test.subject_id%type,
                        p_test_date  in tuc_test.test_date%type,
                        p_user_id    in tuc_test.maker_id%type,
                        p_out        out number,
                        p_err_code   out varchar2,
                        p_err_msg    out varchar2);

  procedure sp_tuc_test_gk(p_test_id  in nvarchar2,
                           p_user_id  in nvarchar2,
                           p_out      out number,
                           p_err_code out nvarchar2,
                           p_err_msg  out nvarchar2,
                           T_CURSOR   out sys_refcursor);

  procedure sp_tuc_test_ga(p_in         in nvarchar2,
                           p_subject_id number,
                           p_user_id    in nvarchar2,
                           p_out        out number,
                           p_err_code   out nvarchar2,
                           p_err_msg    out nvarchar2,
                           T_CURSOR     out sys_refcursor);

end pkg_tuc_manage_op;
/

prompt
prompt Creating package PKG_TUC_USER_MAST
prompt ==================================
prompt
create or replace package schoolmgmt.pkg_tuc_user_mast is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations
 
  procedure sp_tuc_sys_user_mast_i(p_activity     in char,
                                   p_username     in tuc_sys_user_mast.username%type,
                                   p_first_name   in tuc_sys_user_mast.first_name%type,
                                   p_last_name    in tuc_sys_user_mast.last_name%type,
                                   p_email        in tuc_sys_user_mast.email%type,
                                   p_phone_number in tuc_sys_user_mast.phone_number%type,
                                   p_password     in tuc_sys_user_mast.password%type,
                                   p_role_id      in tuc_sys_user_mast.role_id%type,
                                   p_class_id      in tuc_sys_user_mast.class_id%type,
                                   p_user_id      in tuc_sys_user_mast.maker_id%type,
                                   p_out          out number,
                                   p_err_code     out varchar2,
                                   p_err_msg      out varchar2);
  procedure sp_tuc_sys_user_mast_gk(p_username in nvarchar2,
                                      p_user_id  in nvarchar2,
                                      p_out      out number,
                                      p_err_code out nvarchar2,
                                      p_err_msg  out nvarchar2,
                                      T_CURSOR   out sys_refcursor);
  
  procedure sp_tuc_sys_user_mast_ga(  p_user_type in number, 
                                      p_out       out number,
                                      p_err_code  out nvarchar2,
                                      p_err_msg   out nvarchar2,
                                      T_CURSOR    out sys_refcursor);
  
  procedure sp_sys_verify_user(p_username in nvarchar2,
                               p_password in nvarchar2,
                               p_out      out number,
                               p_err_code out nvarchar2,
                               p_err_msg  out nvarchar2,
                               T_CURSOR   out sys_refcursor);

  procedure sp_sys_change_password(p_username     in nvarchar2,
                                   p_password_old in nvarchar2,
                                   p_password_new in nvarchar2,
                                   p_user_id      in nvarchar2,
                                   p_out          out number,
                                   p_err_code     out nvarchar2,
                                   p_err_msg      out nvarchar2);

  procedure sp_sys_reset_password(p_username  in nvarchar2,
                                  p_password  in out nvarchar2,
                                  p_out_email out nvarchar2,
                                  p_user_id   in nvarchar2,
                                  p_out       out number,
                                  p_err_code  out nvarchar2,
                                  p_err_msg   out nvarchar2);

  procedure sp_pass_encrypt(p_user_id  in varchar2,
                            p_password in varchar2,
                            p_enc_key  in varchar2,
                            p_enc_pass out varchar2);

  procedure sp_check_session(p_session_id in TUC_SYS_USER_MAST.session_id%type,
                             p_username   out TUC_SYS_USER_MAST.username%type,
                             p_role_name  out tuc_sys_role.role_name%type,
                             p_out        out number,
                             p_err_code   out nvarchar2,
                             p_err_msg    out nvarchar2);

  function is_session_expired(p_username in varchar2) return number;

  procedure is_null(p_attribute_name  in varchar2,
                    p_attribute_value in varchar2,
                    p_module          in varchar2,
                    p_out             out number,
                    p_err_code        out varchar2,
                    p_err_msg         out varchar2);

  procedure is_null(p_attribute_name  in varchar2,
                    p_attribute_value in blob,
                    p_module          in varchar2,
                    p_out             out number,
                    p_err_code        out varchar2,
                    p_err_msg         out varchar2);

  procedure sp_tuc_sys_role_ga(p_user_id  in nvarchar2,
                               p_out      out number,
                               p_err_code out nvarchar2,
                               p_err_msg  out nvarchar2,
                               T_CURSOR   out sys_refcursor);

end pkg_tuc_user_mast;
/

prompt
prompt Creating package body PKG_TUC_MANAGE_OP
prompt =======================================
prompt
create or replace package body schoolmgmt.pkg_tuc_manage_op is

  --mng-1016

  procedure sp_class_subject_map(p_activity   in char,
                                 p_subject_id in tuc_class_subject_map.subject_id%type,
                                 p_class_id   in tuc_class_subject_map.class_id%type,
                                 p_user_id    in TUC_SYS_USER_MAST.maker_id%type,
                                 p_out        out number,
                                 p_err_code   out varchar2,
                                 p_err_msg    out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id   TUC_SYS_USER_MAST.id%type;   
    v_count number(5);
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('subject ID',
                                p_subject_id,
                                'mng-sp_class_subject_map',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('CLASS ID',
                                p_class_id,
                                'mng-sp_class_subject_map',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_class_subject_map',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
      IF P_ACTIVITY = 'I' THEN
        -- assign subject to class
      
        v_count := 0;
        select count(1)
          into v_count
          from TUC_SYS_USER_MAST t
         where t.username = p_subject_id
           and t.status <> 'D';
      
        if v_count < 1 then
          p_out      := 1;
          p_err_code := 'mng-1001';
          p_err_msg  := initcap('No active subject found by username : ' ||
                                p_subject_id);
          raise L_USER_ERR;
        end if;
      
        v_count := 0;
        select count(1)
          into v_count
          from tuc_class t
         where t.class_id = p_class_id
           and t.status <> 'D';
      
        if v_count < 1 then
          p_out      := 1;
          p_err_code := 'mng-1002';
          p_err_msg  := initcap('No active class found by class id : ' ||
                                p_class_id);
          raise L_USER_ERR;
        end if;
      
        insert into tuc_class_subject_map
          (class_id,
           subject_id,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (p_class_id,
           p_subject_id,
           p_user_id,
           sysdate,
           p_user_id,
           sysdate);
        commit;
        p_err_msg := initcap('subject assigned successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign subject from class
      
        delete tuc_class_subject_map
         where class_id = p_class_id
           and subject_id = p_subject_id;
        commit;
        p_err_msg := initcap('subject deassigned successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1003';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
        end;
      END IF;
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    WHEN EXCP_FK_CONSTRAINT_VIOLATED THEN
      p_out      := 1;
      p_err_code := 'mng-1004';
      p_err_msg  := initcap('subject not found');
      ROLLBACK;
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1005';
        p_err_msg  := initcap('subject already assignend in given class.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1006';
      p_err_msg  := initcap('unexpected error in sp_class_subject_map ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_class_subject_map;

  procedure sp_tuc_class(p_activity   in char,
                         p_class_id   out tuc_class.class_id%type,
                         p_class_name in tuc_class.class_name%type,
                         p_user_id    in tuc_class.maker_id%type,
                         p_out        out number,
                         p_err_code   out varchar2,
                         p_err_msg    out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    -- l_row_count number(8);
    -- v_count     number(5);
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_tuc_class',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'U' then
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Class ID',
                                  p_class_id,
                                  'mng-sp_tuc_class',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('Class Name',
                                p_class_name,
                                'mng-sp_tuc_class',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(class_id), 0) + 1 into p_class_id from tuc_class;
      
        insert into tuc_class
          (class_id,
           class_name,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (P_class_id,
           P_class_name,
           'R',
           P_USER_ID,
           SYSDATE,
           P_USER_ID,
           SYSDATE);
        commit;
        p_err_msg := initcap('New class created successfully! Class Id = ' ||
                             p_class_id);
      
      ELSIF P_ACTIVITY = 'U' THEN
        update tuc_class u
           set u.class_name       = p_class_name,
               u.last_update_by   = p_user_id,
               u.last_update_time = sysdate
         where class_id = p_class_id;
        commit;
        p_err_msg := initcap('Class name updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign STUDENTS from class    
        update tuc_sys_user_mast u
           set u.class_id = null
         where class_id = p_class_id;
      
        delete tuc_class where class_id = p_class_id;
        commit;
        p_err_msg := initcap('Class deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1007';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
        end;
      END IF;
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1008';
        p_err_msg  := initcap('Class id already exist.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1009';
      p_err_msg  := initcap('unexpected error in sp_tuc_class ') || sqlerrm;
      ROLLBACK;
  end sp_tuc_class;

  procedure sp_tuc_class_gk(p_class_id in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor) is
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_class_gk',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select class_id,
             class_name,
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_class c
       where c.status <> 'D'
         and c.class_id = p_class_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1010';
      p_err_msg  := initcap('No Active Class found Found by Class ID = ') ||
                    p_class_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_class_gk;

  procedure sp_tuc_class_ga(p_in       in nvarchar2,
                            p_user_id  in nvarchar2,
                            p_out      out number,
                            p_err_code out nvarchar2,
                            p_err_msg  out nvarchar2,
                            T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_class_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    if p_in = 1 then
      open T_CURSOR for
        select class_id,
               class_name,
               status,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_class c
         where c.status <> 'D'
         order by class_id;
    end if;
  
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_class_ga;

  procedure sp_tuc_subject(p_activity     in char,
                           p_subject_id   out tuc_subject.subject_id%type,
                           p_subject_name in tuc_subject.subject_name%type,
                           p_teacher_id   in tuc_sys_user_mast.id%type,
                           p_user_id      in tuc_subject.maker_id%type,
                           p_out          out number,
                           p_err_code     out varchar2,
                           p_err_msg      out varchar2) as
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
  
    -- l_row_count  number(8);
    -- v_count      number(5);
    V_STATUS     tuc_subject.STATUS%TYPE;
    v_teacher_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('subject ID',
                                p_subject_id,
                                'mng-sp_tuc_subject',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_tuc_subject',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_teacher_id',
                                  p_teacher_id,
                                  'mng-sp_tuc_subject',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Subject Name',
                                  p_subject_name,
                                  'mng-sp_tuc_subject',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
    
      begin
        select id
          into v_teacher_id
          from tuc_sys_user_mast u
         where upper(u.username) = upper(p_teacher_id)
           and u.role_id = 2
           and status <> 'D';
      exception
        when others then
          p_out      := 1;
          p_err_code := 'mng-1011';
          p_err_msg  := initcap('No active teacher found by username : ' ||
                                p_teacher_id);
          ROLLBACK;
          raise l_user_err;
      end;
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(subject_id), 0) + 1
          into p_subject_id
          from tuc_subject;
      
        insert into tuc_subject
          (subject_id,
           subject_name,
           teacher_id,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (P_subject_id,
           P_subject_name,
           v_teacher_id,
           'R',
           P_USER_ID,
           SYSDATE,
           P_USER_ID,
           SYSDATE);
        commit;
        p_err_msg := initcap('New subject created successfully! subject Id = ' ||
                             p_subject_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- deasign teacher from subject  
      
        update tuc_subject
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where subject_id = p_subject_id;
      
        commit;
        p_err_msg := initcap('subject archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign teacher from subject  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_subject S
           WHERE S.SUBJECT_ID = P_SUBJECT_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1012';
            p_err_msg  := initcap('SUBJECT NOT FOUND BY SUBJECT ID: ' ||
                                  P_SUBJECT_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
      
        update tuc_subject s
           set s.subject_name   = 'A',
               s.teacher_id     = p_teacher_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where subject_id = p_subject_id;
      
        commit;
        p_err_msg := initcap('subject updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
        -- deasign teacher from subject 
        delete tuc_class_subject_map where subject_id = p_subject_id;
        delete tuc_subject where subject_id = p_subject_id;
        commit;
        p_err_msg := initcap('subject deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1013';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
          RAISE L_USER_ERR;
        end;
      
      end if;
    
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 0;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1014';
        p_err_msg  := initcap('subject id already exist.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1015';
      p_err_msg  := initcap('unexpected error in sp_tuc_subject ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_subject;

  procedure sp_tuc_subject_gk(p_subject_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor) is
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_subject_gk',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select subject_id,
             subject_name,
             teacher_id,
             (select username from tuc_sys_user_mast where id = c.teacher_id) as teacher_username,
             (select first_name || ' ' || last_name
                from tuc_sys_user_mast
               where id = c.teacher_id) as teacher_full_name,
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_subject c
       where c.status <> 'D'
         and c.subject_id = p_subject_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1016';
      p_err_msg  := initcap('No Active subject found Found by subject ID = ') ||
                    p_subject_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_subject_gk;

  procedure sp_tuc_subject_ga(p_in       in nvarchar2,
                              p_class_id in nvarchar2,
                              p_user_id  in nvarchar2,
                              p_out      out number,
                              p_err_code out nvarchar2,
                              p_err_msg  out nvarchar2,
                              T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_subject_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
    if p_in = 1 then
      open T_CURSOR for
        select subject_id,
               subject_name,
               status,
               teacher_id,
               (select username
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_full_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status <> 'D'
          order by subject_id;
    elsif p_in = 2
      then
        open T_CURSOR for
        select subject_id,
               subject_name,
               status,
               teacher_id,
               (select username
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_username,
               (select first_name || ' ' || last_name
                  from tuc_sys_user_mast
                 where id = s.teacher_id) as teacher_full_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_subject s
         where s.status <> 'D'
          and subject_id in (select subject_id from tuc_class_subject_map m where m.class_id = p_class_id and status <> 'R')
          order by subject_id;
    end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_subject_ga;

  /*************************************************************************/

  procedure sp_tuc_test(p_activity   in char,
                        p_test_id    in out tuc_test.test_id%type,
                        p_test_name  in tuc_test.test_name%type,
                        p_subject_id in tuc_test.subject_id%type,
                        p_test_date  in tuc_test.test_date%type,
                        p_user_id    in tuc_test.maker_id%type,
                        p_out        out number,
                        p_err_code   out varchar2,
                        p_err_msg    out varchar2) as
  
    /*****************************************************************************************************
    NAME         : sp_tuc_test
    PURPOSE      : To insert update delete archive a test
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
  
    l_row_count number(8);
    -- v_count      number(5);
    V_STATUS     tuc_test.STATUS%TYPE;
    v_subject_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('test ID',
                                p_test_id,
                                'mng-sp_tuc_test',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                                p_activity,
                                'mng-sp_tuc_test',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_subject_id',
                                  p_subject_id,
                                  'mng-sp_tuc_test',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('test Name',
                                  p_test_name,
                                  'mng-sp_tuc_test',
                                  P_OUT,
                                  P_ERR_CODE,
                                  P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
    
      begin
        select subject_id
          into v_subject_id
          from tuc_subject u
         where u.subject_id = p_subject_id
           and status <> 'D';
      
        select count(1)
          into l_row_count
          from tuc_test
         where test_id = p_test_id
           and status in ('A', 'D');
      
        if l_row_count > 0 then
          p_out      := 1;
          p_err_code := 'mng-1024';
          p_err_msg  := initcap('this test is already archived or deleted.');
          raise l_user_err;
        end if;
      
      exception
        when others then
          p_out      := 1;
          p_err_code := 'mng-1041';
          p_err_msg  := initcap('No active subject found by p_subject_id : ' ||
                                p_subject_id);
          raise l_user_err;
      end;
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(test_id), 0) + 1 into p_test_id from tuc_test;
        insert into tuc_test
          (test_id,
           test_name,
           subject_id,
           test_date,
           status,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time)
        values
          (p_test_id,
           p_test_name,
           p_subject_id,
           p_test_date,
           'R',
           p_user_id,
           sysdate,
           p_user_id,
           sysdate);
      
        commit;
        p_err_msg := initcap('New test created successfully! test Id = ' ||
                             p_test_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- Archiving Test 
      
        update tuc_test
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id;
      
        commit;
        p_err_msg := initcap('test archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign subject from test  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_test S
           WHERE S.test_ID = P_test_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1018';
            p_err_msg  := initcap('test NOT FOUND BY test ID: ' ||
                                  P_test_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
      
        update tuc_test s
           set s.test_name      = p_test_name,
               s.subject_id     = p_subject_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id;
      
        commit;
        p_err_msg := initcap('test updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_test s
           set s.status         = 'D',
               s.subject_id     = p_subject_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where test_id = p_test_id;
        commit;
        p_err_msg := initcap('test deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1019';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
          RAISE L_USER_ERR;
        end;
      
      end if;
    
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 1;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1020';
        p_err_msg  := initcap('test id already exist.');
        ROLLBACK;
      end;
    
    when EXCP_FK_CONSTRAINT_VIOLATED then
      begin
        p_out      := 1;
        p_err_code := 'mng-1023';
        p_err_msg  := initcap('Subject ID not found.');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1021';
      p_err_msg  := initcap('unexpected error in sp_tuc_test ~ ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_test;

  procedure sp_tuc_test_gk(p_test_id  in nvarchar2,
                           p_user_id  in nvarchar2,
                           p_out      out number,
                           p_err_code out nvarchar2,
                           p_err_msg  out nvarchar2,
                           T_CURSOR   out sys_refcursor) is
  
    /*****************************************************************************************************
    NAME         : sp_tuc_test_gk
    PURPOSE      : To to get specific test info
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_test_gk',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select test_id,
             test_name,
             subject_id,
             (select subject_name
                from tuc_subject
               where subject_id = c.subject_id) as subject_name,
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_test c
       where c.status <> 'D'
         and c.test_id = p_test_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1022';
      p_err_msg  := initcap('No Active test found Found by test ID = ') ||
                    p_test_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_test_gk;

  procedure sp_tuc_test_ga(p_in         in nvarchar2,
                           p_subject_id number,
                           p_user_id    in nvarchar2,
                           p_out        out number,
                           p_err_code   out nvarchar2,
                           p_err_msg    out nvarchar2,
                           T_CURSOR     out sys_refcursor) is
    /*****************************************************************************************************
    NAME         : sp_tuc_test_ga
    PURPOSE      : To to get list of test by subject id
    MODULE       : tuc test
    CREATED BY   : MOHAMMAD TANVIR ISLAM
    Matriculation: #676614
    EMAIL        : imoh@hrz.tu-chemnitz.de
    CREATED AT   : 28-JUNE-2021
    
    REVISIONS:
    
    VERSION     DATE        AUTHOR                      DESCRIPTION
    ---------   ----------  -----------------           ------------------------------------
    1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
    *****************************************************************************************************/
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                                p_user_id,
                                'mng- sp_tuc_test_ga',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
    if p_in = 1 then
      open T_CURSOR for
        select test_id,
               test_name,
               status,
               subject_id,
               (select t.subject_name
                  from tuc_subject t
                 where t.subject_id = s.subject_id) as subject_name,
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_test s
         where s.status <> 'D'
           and (s.subject_id = p_subject_id or p_subject_id is null)
           order by test_id;
    end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_test_ga;

/*  
  procedure sp_tuc_result   (p_activity       in char,
                               p_result_id      in out tuc_result.result_id%type,
                               p_student_id     in tuc_result.student_id%type,
                               p_grade          in tuc_result.grade%type,
                               p_test_id        in tuc_result.test_id%type, 
                               p_user_id      in tuc_result.maker_id%type,
                               p_out          out number,
                               p_err_code     out varchar2,
                               p_err_msg      out varchar2) as
  
  \*****************************************************************************************************
NAME         : sp_tuc_result
PURPOSE      : To insert update delete archive a result
MODULE       : tuc test
CREATED BY   : MOHAMMAD TANVIR ISLAM
Matriculation: #676614
EMAIL        : imoh@hrz.tu-chemnitz.de
CREATED AT   : 28-JUNE-2021

REVISIONS:

VERSION     DATE        AUTHOR                      DESCRIPTION
---------   ----------  -----------------           ------------------------------------
1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
*****************************************************************************************************\

  
   
    L_USER_ERR                  EXCEPTION;
    EXCP_UK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_UK_CONSTRAINT_VIOLATED, -00001);
  
    EXCP_FK_CONSTRAINT_VIOLATED EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCP_FK_CONSTRAINT_VIOLATED, -02291);
    --v_user_id    TUC_SYS_USER_MAST.id%type;
    
    l_row_count  number(8);
   -- v_count      number(5);
    V_STATUS     tuc_result.STATUS%TYPE;
    v_test_id tuc_sys_user_mast.id%type;
  
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('result ID',
                              p_result_id,
                              'mng-sp_tuc_result',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_activity',
                              p_activity,
                              'mng-sp_tuc_result',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if p_activity = 'I' OR p_activity = 'U' then
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('p_test_id',
                                p_test_id,
                                'mng-sp_tuc_result',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('Grade',
                                p_grade,
                                'mng-sp_tuc_result',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    end if;
  
    IF P_OUT = 1 THEN
      RAISE L_USER_ERR;
    END IF;
  
    IF P_OUT = 0 THEN
    
      begin
        select test_id
          into v_test_id
          from tuc_test u
         where u.test_id = p_test_id
           and status <> 'D';
           
        select count(1)
          into l_row_count
          from tuc_result
         where result_id = p_result_id
           and status in ('A', 'D');
        
        if  l_row_count > 0 then
           p_out      := 1;
           p_err_code := 'mng-1025';
           p_err_msg  := initcap('this result is already archived or deleted.'); 
           raise l_user_err;
        end if;
         
      exception
        when others then
          p_out      := 1;
          p_err_code := 'mng-1026';
          p_err_msg  := initcap('No active test found by p_test_id : ' || p_test_id); 
          raise l_user_err;
      end;
    
      IF P_ACTIVITY = 'I' THEN
        select nvl(max(result_id), 0) + 1
          into p_result_id
          from tuc_result;
       insert into tuc_result
         (result_id,
          test_id,
          student_id,
          grade,
          status,
          maker_id,
          maker_time,
          last_update_by,
          last_update_time)
       values
         (p_result_id,
          p_test_id,
          p_student_id,
          p_grade,
          'R',
          p_user_id,
          sysdate,
          p_user_id,
          sysdate); 
     
        commit;
        p_err_msg := initcap('New result created successfully! result Id = ' ||  p_result_id);
      
      ELSIF P_ACTIVITY = 'A' THEN
        -- Archiving result 
      
        update tuc_result
           set status           = 'A',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;
      
        commit;
        p_err_msg := initcap('result archived successfully!');
      
      ELSIF P_ACTIVITY = 'U' THEN
        -- deasign test from result  
      
        BEGIN
          SELECT STATUS
            INTO V_STATUS
            FROM tuc_result S
           WHERE S.result_ID = P_result_ID;
        EXCEPTION
          WHEN OTHERS THEN
            p_out      := 1;
            p_err_code := 'mng-1027';
            p_err_msg  := initcap('result NOT FOUND BY result ID: ' ||
                                  P_result_ID);
            ROLLBACK;
            RAISE L_USER_ERR;
        END;
        
        if V_STATUS = 'A'
          then
              p_out      := 1;
              p_err_code := 'mng-1034';
              p_err_msg  := initcap('result is already archived '); 
              RAISE L_USER_ERR;
         elsif V_STATUS = 'D' 
           then
            p_out      := 1;
            p_err_code := 'mng-1035';
            p_err_msg  := initcap('result is already deleted '); 
            RAISE L_USER_ERR;
         end if;
      
        update tuc_result s
           set s.grade          = p_grade, 
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;
      
        commit;
        p_err_msg := initcap('Grade updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_result s
           set s.status         = 'D',
               s.test_id     = p_test_id,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where result_id = p_result_id;         
        commit;
        p_err_msg := initcap('result deleted successfully!');
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'mng-1036';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
          RAISE L_USER_ERR;
        end;
      
      end if;
    
    ELSE
      RAISE L_USER_ERR;
    END IF;
  EXCEPTION
    WHEN L_USER_ERR THEN
      BEGIN
        P_OUT := 1;
        ROLLBACK;
      END;
    
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'mng-1037';
        p_err_msg  := initcap('result id already exist.');
        ROLLBACK;
      end;
    
    when EXCP_FK_CONSTRAINT_VIOLATED then
      begin
        p_out      := 1;
        p_err_code := 'mng-1038';
        p_err_msg  := initcap('test ID not found.');
        ROLLBACK;
      end;      
    
    when others then
      p_out      := 1;
      p_err_code := 'mng-1039';
      p_err_msg  := initcap('unexpected error in sp_tuc_result ~ ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_result;

  procedure sp_tuc_result_gk( p_result_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor) is
  
  
  
\*****************************************************************************************************
NAME         : sp_tuc_result_gk
PURPOSE      : To get specific result by result id
MODULE       : tuc test
CREATED BY   : MOHAMMAD TANVIR ISLAM
Matriculation: #676614
EMAIL        : imoh@hrz.tu-chemnitz.de
CREATED AT   : 28-JUNE-2021

REVISIONS:

VERSION     DATE        AUTHOR                      DESCRIPTION
---------   ----------  -----------------           ------------------------------------
1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
*****************************************************************************************************\

  
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_result_gk',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select result_id,
             grade,
             test_id,           
             status,
             maker_id,
             maker_time,
             last_update_by,
             last_update_time
        from tuc_result c
       where c.status <> 'D'
         and c.result_id = p_result_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'mng-1040';
      p_err_msg  := initcap('No Active result found Found by result ID = ') ||
                    p_result_id;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_result_gk;

  procedure sp_tuc_result_ga( p_in         in nvarchar2,
                              p_test_id    in number,
                              p_student_id in nvarchar2,
                              p_user_id    in nvarchar2,
                              p_out        out number,
                              p_err_code   out nvarchar2,
                              p_err_msg    out nvarchar2,
                              T_CURSOR     out sys_refcursor) is
  
\*****************************************************************************************************
NAME         : sp_tuc_result_ga
PURPOSE      : To get list of result by test id or student_id
MODULE       : tuc test
CREATED BY   : MOHAMMAD TANVIR ISLAM
Matriculation: #676614
EMAIL        : imoh@hrz.tu-chemnitz.de
CREATED AT   : 28-JUNE-2021

REVISIONS:

VERSION     DATE        AUTHOR                      DESCRIPTION
---------   ----------  -----------------           ------------------------------------
1.0         28-06-2021  MOHAMMAD  TANVIR ISLAM           1. INITIATE SP
*****************************************************************************************************\

  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'mng- sp_tuc_result_ga',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
   if p_in = 1 
     then
      open T_CURSOR for
        select result_id,
               grade,
               status,
               test_id,               
               maker_id,
               maker_time,
               last_update_by,
               last_update_time
          from tuc_result s
         where s.status <> 'D' 
         and (s.test_id = p_test_id or p_test_id is null)
         and (s.student_id = p_student_id or p_student_id is null);
   end if;
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_result_ga;
 
*/
end pkg_tuc_manage_op;
/

prompt
prompt Creating package body PKG_TUC_USER_MAST
prompt =======================================
prompt
create or replace package body schoolmgmt.pkg_tuc_user_mast is
--usr-1016
  v_session_exp_min NUMBER(8) := 5; -- min
  procedure sp_tuc_sys_user_mast_i(p_activity     in char,
                                   p_username     in tuc_sys_user_mast.username%type,
                                   p_first_name   in tuc_sys_user_mast.first_name%type,
                                   p_last_name    in tuc_sys_user_mast.last_name%type,
                                   p_email        in tuc_sys_user_mast.email%type,
                                   p_phone_number in tuc_sys_user_mast.phone_number%type,
                                   p_password     in tuc_sys_user_mast.password%type,
                                   p_role_id      in tuc_sys_user_mast.role_id%type,
                                   p_class_id      in tuc_sys_user_mast.class_id%type,
                                   p_user_id      in tuc_sys_user_mast.maker_id%type,
                                   p_out          out number,
                                   p_err_code     out varchar2,
                                   p_err_msg      out varchar2) as
  
    excp_uk_constraint_violated exception;
    pragma exception_init(excp_uk_constraint_violated, -00001);
    v_user_id tuc_sys_user_mast.id%type;
    v_enc_key tuc_sys_user_mast.enc_key%type;
    v_pas_enc tuc_sys_user_mast.password%type;
    l_row_count number(8);
  begin
  
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'USR-sp_tuc_sys_user_mast',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('USERNAME',
                              p_username,
                              'USR-sp_tuc_sys_user_mast',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF p_activity = 'I' THEN
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('PASSWORD',
                                p_password,
                                'USR-sp_tuc_sys_user_mast',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('ROLE',
                                p_role_id,
                                'USR-sp_tuc_sys_user_mast',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
    END IF;
  
    IF p_activity = 'U' OR p_activity = 'I' THEN
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('FIRST NAME',
                                p_first_name,
                                'USR-sp_tuc_sys_user_mast',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('LAST NAME',
                                p_last_name,
                                'USR-sp_tuc_sys_user_mast',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    
      IF P_OUT = 0 THEN
        pkg_tuc_user_mast.IS_NULL('EMAIL',
                                p_email,
                                'USR-sp_tuc_sys_user_mast',
                                P_OUT,
                                P_ERR_CODE,
                                P_ERR_MSG);
      ELSE
        RETURN;
      END IF;
    END IF;
    IF P_OUT = 0 THEN
      IF P_ACTIVITY = 'I' THEN
      
        v_user_id := sys_guid();
        v_enc_key := to_char(sysdate, 'ddmmyyhhmiss') ||
                     dbms_random.string(9, 10);
      
        pkg_tuc_user_mast.sp_pass_encrypt(p_user_id  => v_user_id,
                                        p_password => p_password,
                                        p_enc_key  => v_enc_key,
                                        p_enc_pass => v_pas_enc);
      
        insert into tuc_sys_user_mast
          (id,
           username,
           first_name,
           last_name,
           email,
           phone_number,
           password,
           enc_key,
           status,
           role_id,
           class_id,
           maker_id,
           maker_time,
           last_update_by,
           last_update_time,
           last_logged_in,
           session_id,
           session_exp_time)
        values
          (v_user_id,
           TRIM(LOWER(p_username)),
           p_first_name,
           p_last_name,
           p_email,
           p_phone_number,
           v_pas_enc,
           v_enc_key,
           'R',
           p_role_id,
           p_class_id,
           p_user_id,
           sysdate,
           p_user_id,
           sysdate,
           null,
           'empty',
           sysdate);
        commit;
        p_err_msg := initcap('User saved successfully!');
      ELSIF P_ACTIVITY = 'U' THEN
      
        update tuc_sys_user_mast
           set first_name       = p_first_name,
               last_name        = p_last_name,
               email            = p_email,
               role_id          = p_role_id,
               class_id         = p_class_id,
               phone_number     = p_phone_number,
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where username = p_username and status <> 'D';
         
         l_row_count := sql%rowcount;
         
         if l_row_count < 1 then 
              p_out      := 1;
              p_err_code := 'usr-1001';
              p_err_msg  := initcap('No Active User Found by username = ') || p_username;
              rollback; 
             return;
         end if;
         
        commit;
        p_err_msg := initcap('User updated successfully!');
      
      ELSIF P_ACTIVITY = 'D' THEN
      
        update tuc_sys_user_mast
           set status           = 'D',
               last_update_by   = p_user_id,
               last_update_time = sysdate
         where username = p_username and status <> 'D';
          if l_row_count < 1 then 
                p_out      := 1;
                p_err_code := 'usr-1002';
                p_err_msg  := initcap('No Active User Found by username = ') || p_username;
                rollback; 
               return;
           end if;  
        commit;
        p_err_msg := initcap('User deleted successfully!');
      
      ELSE
        begin
          p_out      := 1;
          p_err_code := 'usr-1003';
          p_err_msg  := initcap('Invalid p_activity value.');
          ROLLBACK;
        end;
      END IF;
    ELSE
      ROLLBACK;
      RETURN;
    END IF;
  exception
    when excp_uk_constraint_violated then
      begin
        p_out      := 1;
        p_err_code := 'usr-1004';
        p_err_msg  := initcap('username already exist');
        ROLLBACK;
      end;
    
    when others then
      p_out      := 1;
      p_err_code := 'usr-1005';
      p_err_msg  := initcap('unexpected error in sp_tuc_sys_user_mast_i ') ||
                    sqlerrm;
      ROLLBACK;
  end sp_tuc_sys_user_mast_i;

  procedure sp_tuc_sys_user_mast_gk(p_username in nvarchar2,
                                      p_user_id  in nvarchar2,
                                      p_out      out number,
                                      p_err_code out nvarchar2,
                                      p_err_msg  out nvarchar2,
                                      T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'USR-sp_tuc_sys_user_mast_gk',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('USERNAME',
                              p_username,
                              'USR-sp_tuc_sys_user_mast_gk',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select t.id,
             t.username,
             t.email,
             t.first_name,
             t.last_name,
             t.phone_number,
             t.last_logged_in,
             t.session_exp_time,
             t.session_id,
             t.class_id,
             t.role_id,
             (select upper(role_name)
                from tuc_sys_role
               where role_id = t.role_id) as role_name,
             (select upper(class_name)
                from tuc_class
               where class_id = t.class_id) as class_name
        from tuc_sys_user_mast t
       where upper(t.username) = upper(p_username) and t.status <> 'D';
  
    p_err_msg := 'Data found successfully.';
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'usr-1006';
      p_err_msg  := initcap('No Active User Found by username = ') || p_username;
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_sys_user_mast_gk;

  procedure sp_tuc_sys_user_mast_ga(  p_user_type in number, 
                                      p_out       out number,
                                      p_err_code  out nvarchar2,
                                      p_err_msg   out nvarchar2,
                                      T_CURSOR    out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
 
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('USER TYPE',
                              p_user_type,
                              'USR-sp_tuc_sys_user_mast_ga',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
  
  
    IF P_USER_TYPE NOT IN (0, 1, 2, 3) THEN
      p_out      := 1;
      p_err_code := 'usr-1007';
      p_err_msg  := 'P_USER_TYPE Must be in 0,1,2,3 !';
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select t.id,
             t.username,
             t.email,
             t.first_name,
             t.last_name,
             t.phone_number,
             t.last_logged_in,
             t.session_exp_time,
             t.session_id,
             t.role_id,
             t.class_id,
             (select upper(role_name)
                from tuc_sys_role
               where role_id = t.role_id) as role_name,
              (select upper(class_name)
                from tuc_class
               where class_id = t.class_id) as class_name
        from tuc_sys_user_mast t
       where T.STATUS <> 'D' 
         and (role_id = p_user_type or p_user_type = 0)
         order by role_id,username;
  
    p_err_msg := 'Data found successfully.';
  exception
  /*  when no_data_found then 
        p_out      := 1;
        p_err_code := 'usr-1008';
        p_err_msg  := initcap('No Active User Found by username = ') || p_username;
        rollback; */ 
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_sys_user_mast_ga;

  procedure sp_sys_verify_user(p_username in nvarchar2,
                               p_password in nvarchar2,
                               p_out      out number,
                               p_err_code out nvarchar2,
                               p_err_msg  out nvarchar2,
                               T_CURSOR   out sys_refcursor) is
    v_session_id     nvarchar2(100);
    v_enc_key        nvarchar2(100);
    v_pas_enc        tuc_sys_user_mast.enc_key%type;
    v_password_db    tuc_sys_user_mast.password%type;
    v_sessin_expired timestamp;
  
    v_user_id tuc_sys_user_mast.id%type;
  begin
    p_out := 0;
  
    begin
      select t.enc_key, t.password, id
        into v_enc_key, v_password_db, v_user_id
        from tuc_sys_user_mast t
       where lower(t.username) = lower(p_username) and status <> 'D';
    
      dbms_output.put_line('v_enc_key = ' || v_enc_key);
      dbms_output.put_line('v_password = ' || v_password_db);
      dbms_output.put_line('v_user_id = ' || v_user_id);
    
    exception
      when no_data_found then
        p_out      := 1;
        p_err_code := 'usr-1009';
        p_err_msg  := 'User not found!';
        rollback;
        return;
    end;
  
    pkg_tuc_user_mast.sp_pass_encrypt(p_user_id  => v_user_id,
                                    p_password => p_password,
                                    p_enc_key  => v_enc_key,
                                    p_enc_pass => v_pas_enc);
  
    if v_pas_enc = v_password_db then
      v_session_id     := SYS_GUID();
      v_sessin_expired := to_CHAR(sysdate + (.000694 * v_session_exp_min),
                                  'DD-MON-YYYY HH:MI:SS PM');
    
      update tuc_sys_user_mast t
         set t.session_id       = v_session_id,
             t.last_logged_in   = sysdate,
             t.session_exp_time = v_sessin_expired
       where upper(t.username) = upper(p_username)  and status <> 'D';
      commit;
    
      p_err_msg := 'Successfully logged in!';
    
    else
      p_out      := 1;
      p_err_code := 'usr-1010';
      p_err_msg  := 'Invalid Username or Password!';
      rollback;
      return;
    end if;
  
    if p_out = 0 then
      open T_CURSOR for
        select t.id,
               t.username,
               t.email,
               t.first_name,
               t.last_name,
               t.phone_number,
               t.role_id,
               t.session_id,
               t.session_exp_time,
               (select role_name from tuc_sys_role where role_id = t.role_id) as role_name
          from tuc_sys_user_mast t
         where upper(t.username) = upper(p_username) and status <> 'D';
    end if;
  
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'usr-1011';
      p_err_msg  := initcap('No Active User Found by username = ') || p_username;
      rollback;
      
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_verify_user;

  procedure sp_sys_change_password(p_username     in nvarchar2,
                                   p_password_old in nvarchar2,
                                   p_password_new in nvarchar2,
                                   p_user_id      in nvarchar2,
                                   p_out          out number,
                                   p_err_code     out nvarchar2,
                                   p_err_msg      out nvarchar2) is
    v_enc_key nvarchar2(100);
    v_pas_enc tuc_sys_user_mast.enc_key%type;
    v_user_id tuc_sys_user_mast.id%type;
    V_CURSOR  sys_refcursor;
  begin
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'USR-sp_sys_change_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('USERNAME',
                              p_username,
                              'USR-sp_sys_change_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('OLD PASSWORD',
                              p_password_old,
                              'USR-sp_sys_change_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('NEW PASSWORD',
                              p_password_new,
                              'USR-sp_sys_change_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    pkg_tuc_user_mast.sp_sys_verify_user(p_username => p_username,
                                       p_password => p_password_old,
                                       p_out      => p_out,
                                       p_err_code => p_err_code,
                                       p_err_msg  => p_err_msg,
                                       t_cursor   => V_CURSOR);
  
    if p_out = 1 then
      return;
    end if;
  
    select id, enc_key
      into v_user_id, v_enc_key
      from tuc_sys_user_mast
     where username = lower(p_username);
  
    pkg_tuc_user_mast.sp_pass_encrypt(p_user_id  => v_user_id,
                                    p_password => p_password_new,
                                    p_enc_key  => v_enc_key,
                                    p_enc_pass => v_pas_enc);
  
    update tuc_sys_user_mast t
       set t.password         = v_pas_enc,
           t.last_update_time = sysdate,
           t.last_update_by   = p_user_id
     where t.username = lower(p_username);
  
    p_err_msg := initcap('Password changed successfully!');
    commit;
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_change_password;

  procedure sp_sys_reset_password(p_username  in nvarchar2,
                                  p_password  in out nvarchar2,
                                  p_out_email out nvarchar2,
                                  p_user_id   in nvarchar2,
                                  p_out       out number,
                                  p_err_code  out nvarchar2,
                                  p_err_msg   out nvarchar2) is
    v_enc_key nvarchar2(100);
    v_pas_enc tuc_sys_user_mast.enc_key%type;
    v_user_id tuc_sys_user_mast.id%type;
  begin
    p_out := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'USR-sp_sys_reset_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('USERNAME',
                              p_username,
                              'USR-sp_sys_reset_password',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    if P_OUT <> 0 then
      return;
    end if;
    
    if p_password is null then
      p_password := dbms_random.string(4, 4);
    end if;
    
    select id, enc_key, email
      into v_user_id, v_enc_key, p_out_email
      from tuc_sys_user_mast
     where username = lower(p_username);
  
    pkg_tuc_user_mast.sp_pass_encrypt(p_user_id  => v_user_id,
                                    p_password => p_password,
                                    p_enc_key  => v_enc_key,
                                    p_enc_pass => v_pas_enc);
  
    update tuc_sys_user_mast t
       set t.password         = v_pas_enc,
           t.last_update_time = sysdate,
           t.last_update_by   = p_user_id
     where t.username = lower(p_username);
  
    p_err_msg := initcap('Password reset done!');
  
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'usr-1012';
      p_err_msg  := p_username || initcap(' User not found!');
      rollback;
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_reset_password;

  procedure sp_pass_encrypt(p_user_id  in varchar2,
                            p_password in varchar2,
                            p_enc_key  in varchar2,
                            p_enc_pass out varchar2) as
  
    v_hash_value_raw raw(1000);
  
  begin
  
    dbms_output.put_line('original string: ' || p_password);
  
    v_hash_value_raw := dbms_crypto.hash(src => utl_raw.cast_to_raw(p_user_id || '|' ||
                                                                    p_password ||
                                                                    p_enc_key),
                                         typ => dbms_crypto.hash_sh1);
  
    p_enc_pass := utl_raw.cast_to_varchar2(utl_encode.base64_encode(v_hash_value_raw));
    p_enc_pass := substr(p_enc_pass, 0, 28);
  
    dbms_output.put_line('encrypted string: ' || p_enc_pass);
  
  end sp_pass_encrypt;

  procedure sp_check_session(p_session_id in tuc_sys_user_mast.session_id%type,
                             p_username   out tuc_sys_user_mast.username%type,
                             p_role_name  out tuc_sys_role.role_name%type,
                             p_out        out number,
                             p_err_code   out nvarchar2,
                             p_err_msg    out nvarchar2) is
    /******************************************************************************
       name:       sp_check_session
       purpose:    user log-in verification
    
       revisions:
       ver        date        author           description
       ---------  ----------  ---------------  ------------------------------------
     1.0        13-june-2021  mohammad tanvir islam     1. created this package.
    ******************************************************************************/
  
    v_last_session_id tuc_sys_user_mast.session_id%type := null;
    v_session_expired timestamp;
    v_current_time    timestamp;
  
  begin
    p_out          := 0;
    v_current_time := sysdate;
  
    if p_session_id is null or p_session_id = '' then
      p_out      := 1;
      p_err_code := 'sys-1011';
      p_err_msg  := Initcap('Session id cannot be empty');
      return;
    end if;
  
    begin
      select session_id,
             username,
             (select role_name from tuc_sys_role where role_id = u.role_id) as role_name,
             u.session_exp_time
        into v_last_session_id, p_username, p_role_name, v_session_expired
        from tuc_sys_user_mast u
       where session_id = p_session_id;
    exception
      when others then
        p_out      := 1;
        p_err_code := 'usr-1013';
        p_err_msg  := initcap('session does not exist!');
        return;
    end;
  
/*    if v_session_expired < v_current_time then
      p_out      := 1;
      p_err_code := 'usr-1014';
      p_err_msg  := initcap('session is expired!');
      return;
    end if;
  
    update tuc_sys_user_mast t
       set t.session_exp_time = to_CHAR(sysdate +
                                        (.000694 * v_session_exp_min),
                                        'DD-MON-YYYY HH:MI:SS PM')
     where username = p_username;*/
  
  exception
    when no_data_found then
      p_out      := 1;
      p_err_code := 'usr-1015';
      p_err_msg  := p_username || initcap(' user not found!');
    when others then
      p_out      := 1;
      p_err_code := 'usr-1016';
      p_err_msg  := initcap('problem in getting user session!') || sqlerrm;
  end sp_check_session;

  function is_session_expired(p_username in varchar2) return number is
    v_out              number(1);
    v_session_exp_time timestamp;
    v_current_time     timestamp;
  begin
    v_out          := 0;
    v_current_time := sysdate;
  
    begin
      select u.session_exp_time
        into v_session_exp_time
        from tuc_sys_user_mast u
       where upper(username) = upper(p_username);
    
      if v_session_exp_time <= v_current_time then
        v_out := 1;
      end if;
    
    exception
      when no_data_found then
        v_out := 2;
      when others then
        v_out := 3;
    end;
  
    return v_out;
  end;

  procedure is_null(p_attribute_name  in varchar2,
                    p_attribute_value in varchar2,
                    p_module          in varchar2,
                    p_out             out number,
                    p_err_code        out varchar2,
                    p_err_msg         out varchar2) is
    /******************************************************************************
      name:       is_null
      purpose:    null or empty value checking
    
      revisions:
      ver        date        author           description
      ---------  ----------  ---------------  ------------------------------------
     1.0        13-june-2021  mohammad tanvir islam     1. created this package.
    ******************************************************************************/
  
  begin
    p_out := 0;
  
    if (p_out = 0) and
       ((p_attribute_value is null) or (length(p_attribute_value) = 0)) then
      p_out      := 1;
      p_err_code := 'utl-20001';
      p_err_msg  := initcap(p_attribute_name || ' missing!' || '[' ||
                            p_module || ']');
    end if;
  end is_null;

  /** null checking for blob **/

  procedure is_null(p_attribute_name  in varchar2,
                    p_attribute_value in blob,
                    p_module          in varchar2,
                    p_out             out number,
                    p_err_code        out varchar2,
                    p_err_msg         out varchar2) is
    /******************************************************************************
      name:       is_null
      purpose:    null or empty value checking
    
      revisions:
      ver        date        author           description
      ---------  ----------  ---------------  ------------------------------------
     1.0        13-june-2021  mohammad tanvir islam     1. created this package.
    ******************************************************************************/
  
  begin
    p_out := 0;
  
    if (p_out = 0) and
       ((p_attribute_value is null) or (length(p_attribute_value) = 0)) then
      p_out      := 1;
      p_err_code := 'utl-20002';
      p_err_msg  := initcap(p_attribute_name || ' missing!' || '[' ||
                            p_module || ']');
    end if;
  end is_null;

  /*==============================================================================*/

  procedure sp_tuc_sys_role_ga(p_user_id  in nvarchar2,
                               p_out      out number,
                               p_err_code out nvarchar2,
                               p_err_msg  out nvarchar2,
                               T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin
    P_OUT := 0;
  
    IF P_OUT = 0 THEN
      pkg_tuc_user_mast.IS_NULL('p_user_id',
                              p_user_id,
                              'USR-sp_tuc_sys_role_ga',
                              P_OUT,
                              P_ERR_CODE,
                              P_ERR_MSG);
    ELSE
      RETURN;
    END IF;
  
    IF P_OUT <> 0 THEN
      RETURN;
    END IF;
  
    open T_CURSOR for
      select t.role_id, t.role_name, t.role_description
        from tuc_sys_role t
       where t.status = 'R'
        order by role_id;
  
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_tuc_sys_role_ga;

end pkg_tuc_user_mast;
/


spool off
