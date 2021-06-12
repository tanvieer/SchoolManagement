create or replace package pkg_user_master is

  -- Author  : TANVI
  -- Created : 6/11/2021 7:53:53 PM
  -- Purpose : 

  -- Public type declarations

  procedure sp_sys_user_master_gk(p_username in nvarchar2,
                                  p_out      out number,
                                  p_err_code out nvarchar2,
                                  p_err_msg  out nvarchar2,
                                  T_CURSOR   out sys_refcursor);

end pkg_user_master;
/
create or replace package body pkg_user_master is

  procedure sp_sys_verify_user(p_username in nvarchar2,
                               p_password in nvarchar2,
                               p_out      out number,
                               p_err_code out nvarchar2,
                               p_err_msg  out nvarchar2,
                               T_CURSOR   out sys_refcursor) is
    v_count      number(8);
    v_session_id nvarchar2(100);
    v_enc_key    nvarchar2(100);
    v_pas_enc    sys_user_master.enc_key%type;
    v_password   sys_user_master.password%type;
  begin
    p_out := 0;
  
    begin
      select t.enc_key, t.password
        into v_enc_key, v_password
        from sys_user_master t
       where upper(t.username) = upper(p_username);
    
    exception
      when no_data_found then
        p_out      := 1;
        p_err_code := 'sys_1002';
        p_err_msg  := 'Username not found!';
        rollback;
        return;
    end;
  
    v_pas_enc := p_password; -- need to encrypt and match
  
    if v_pas_enc = v_password then
      v_session_id := SYS_GUID();
    
      update sys_user_master t
         set t.session_id       = v_session_id,
             t.last_logged_in   = sysdate,
             t.session_exp_time = sysdate + 1
       where upper(t.username) = upper(p_username);
      commit;
       
      p_err_msg  := 'Successfully logged in!';
      
    else
      p_out      := 1;
      p_err_code := 'sys_1001';
      p_err_msg  := 'Invalid Username or Password!';
      rollback;
      return;
    end if;
  
  if p_out = 0 then
    commit;
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
             (select role_name from sys_role where role_id = t.role_id) as role_name
        from sys_user_master t
       where upper(t.username) = upper(p_username);
   end if;
   
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_verify_user;

  procedure sp_sys_user_master_gk(p_username in nvarchar2,
                                  p_out      out number,
                                  p_err_code out nvarchar2,
                                  p_err_msg  out nvarchar2,
                                  T_CURSOR   out sys_refcursor) is
    --v_count number(8);
  
  begin  
    P_OUT := 0;
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
             (select upper(role_name) from sys_role where role_id = t.role_id) as role_name
        from sys_user_master t
       where upper(t.username) = upper(p_username);
     
    p_err_msg := 'Data found successfully.';
  exception
    when others then
      p_out      := 1;
      p_err_code := sqlcode;
      p_err_msg  := sqlerrm;
      rollback;
  end sp_sys_user_master_gk;

end pkg_user_master;
/
