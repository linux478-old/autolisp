(princ ".")
(defun c:MP:ENTSEL-RENAME-LAYER ( /
                                  ed - entity defination of selected item
                                )
  (setq ed (entget (car (entsel)))
  )
  (MP:ENTSEL-RENAME-LAYER ed)
  (princ)
); defun
(princ ".")
(defun MP:ENTSEL-RENAME-LAYER (ed)
  (princ "\n")
  (command "-rename" "layer" (cdr (assoc 8 ed)) pause)
); defun

