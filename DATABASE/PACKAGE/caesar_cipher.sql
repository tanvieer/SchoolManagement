CREATE OR REPLACE FUNCTION caesar_cipher(p_source IN VARCHAR2,
                                         p_offset IN PLS_INTEGER)
  RETURN VARCHAR2 IS
  c_abc CONSTANT VARCHAR2(128) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+|}{[]\;:"/.,<>?=-0987654321`';
  v_offset PLS_INTEGER;
  v_target VARCHAR2(32767);
  v_transl VARCHAR2(128);
BEGIN
  v_offset := MOD(p_offset, LENGTH(c_abc));
  IF (v_offset < 0) THEN
    v_offset := v_offset + LENGTH(c_abc);
  END IF;
  v_transl := SUBSTR(c_abc, v_offset + 1) || SUBSTR(c_abc, 1, v_offset);
  v_target := TRANSLATE(p_source,
                        c_abc || LOWER(c_abc),
                        v_transl || LOWER(v_transl));

  RETURN v_target;
END;
