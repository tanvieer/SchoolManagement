create or replace package pkg_tuc_user_mast is

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
                                  p_password  in nvarchar2,
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
create or replace package body pkg_tuc_user_mast is
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
               --role_id          = p_role_id,
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
             
              --  AVG GRADE CALCULATION START
             (select nvl(avg(grade),0.0)
                from TUC_result rslt
               where rslt.student_id = t.id
                 and rslt.test_id in
                     (select tst.test_id
                        from TUC_TEST tst
                       where subject_id in
                             (select sub.subject_id
                                from tuc_subject sub
                               where sub.class_id = t.class_id))) avg_grade,
              -- AVG GRADE CALCULATION END
             
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
       --  AVG GRADE CALCULATION START
       (select nvl(avg(grade),0.0)
          from TUC_result rslt
         where rslt.student_id = t.id
           and rslt.test_id in
               (select tst.test_id
                  from TUC_TEST tst
                 where subject_id in
                       (select sub.subject_id
                          from tuc_subject sub
                         where sub.class_id = t.class_id))) avg_grade,
        -- AVG GRADE CALCULATION END
        t.class_id,
       (select upper(role_name) from tuc_sys_role where role_id = t.role_id) as role_name,
       (select upper(class_name) from tuc_class where class_id = t.class_id) as class_name
  from tuc_sys_user_mast t
 where T.STATUS <> 'D'
   and (role_id = p_user_type or p_user_type = 0)
 order by role_id, username;

  
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
  
    p_err_msg := initcap('Password changed successfully! Please login again !');
    commit;
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_change_password;

  procedure sp_sys_reset_password(p_username  in nvarchar2,
                                  p_password  in nvarchar2,
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
      pkg_tuc_user_mast.IS_NULL('Password',
                              p_password,
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
    
  /*  if p_password is null then
      p_password := dbms_random.string(4, 4);
    end if;*/
    
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
