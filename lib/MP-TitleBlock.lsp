(princ "\nLoading MP-TBlock ")
(princ ".")
(defun MP:TBlock->get ( /
                        ss
                      )
  (setq ss (ssget "all" (list
                 '(0 . "insert")
                 '(10 0 0 0)
                 (cons 410 (MP:Layout->getName))
               )
  )
  (if ss
    (ssname ss 0)
    nil
  )
); defun
(princ ".")
(defun MP:TBlock->getName ()
  "SHEET D"
); defun
(princ ".")
(defun MP:TBlock->getRevision ( oTBlock )
  (LM:vl-getattributevalue 
    (vlax-ename->vla-object oTBlock)
    "Revision"
  )
); defun
(princ ".")
(defun MP:TBlock->isAtOrigin ( oTBlock
                               /
                               pt
                             )
  (if
    (and
      (setq pt (assoc 10 (entget oTBlock)))
      (= 0 (nth 1 pt))
      (= 0 (nth 2 pt))
      (= 0 (nth 3 pt))
    )
    T
    nil
  )
); defun
(princ ".")
(defun MP:TBlock->load ()
  (princ "")
)
(princ " [Done]")
(princ)
