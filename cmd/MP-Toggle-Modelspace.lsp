(defun c:MP:Toggle-Modelspace ()
  (setvar 'tilemode (rem (1+ (getvar 'tilemode)) 2))
  (princ)
); defun

