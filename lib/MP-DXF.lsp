(princ "\nLoading MP-DXF ")
(princ ".")
(defun MP:DXF->load ()
  (princ "")
)
(princ ".")
(defun MP:DXF->get (n d)
  (cond
    ((= 'int (type n))(cdr (assoc n d)))
    ((= 'entity n)(cdr (assoc 0 d)))
    ((= 'insert n)(cdr (assoc 10 d)))
    ((= 'layer n)(cdr (assoc 8 d)))
    ((= 'color n)(cdr (assoc 62 d)))
    ((= 1 1) nil)
  )
); defun
(princ " [Done]")

